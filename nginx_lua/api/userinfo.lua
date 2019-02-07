local json = require("cjson")
local http = require("resty.http")
function init()
    local uuid = require("resty.jit-uuid")
    uuid.seed()
    local method_name = ngx.req.get_method()
    if method_name == "GET" then
        ngx.header["Content-Type"] = "text/plain"
        ngx.header["Grip-Hold"] = "stream"
        ngx.header["Grip-Channel"] = "userinfo"
        ngx.say("is stream open")
        return
    end
    ngx.req.read_body()
    local body = ngx.req.get_body_data()
    if not body then
        if ngx.req.get_body_file() then
            return nil, "request body did not fit into client body buffer, consider raising 'client_body_buffer_size'"
        else
            return ""
        end
    end
    local mode = json.decode(body)
    local body_entity = {
        items = {
            {
                channel = mode.channel,
                id = uuid(),
                formats = {
                    ["http-stream"] = {
                        content = json.encode(mode.data)..'\n',
                    },
                    -- action = "send"
                }
            }
        }
    }
    ngx.log(ngx.ERR, json.encode(body_entity))
    local requestapiurl = "http://pushpin:5561/publish/"
    local httpc = http.new()
    local res, err =
        httpc:request_uri(
        requestapiurl,
        {
            method = "POST",
            body = json.encode(body_entity),
            headers = {
                ["Content-Type"] = "application/json"
            }
        }
    )
    if not res then
        ngx.say("failed to request: ", err)
        return
    end
    ngx.log(ngx.ERR, res.body)
    ngx.say(res.body)
end
return init

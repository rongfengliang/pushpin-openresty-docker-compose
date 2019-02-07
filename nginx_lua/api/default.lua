function init()
   ngx.header["Content-Type"] = 'text/plain';
   ngx.header["Grip-Hold"] = 'stream';
   ngx.header["Grip-Channel"] = 'user';
end
return init;
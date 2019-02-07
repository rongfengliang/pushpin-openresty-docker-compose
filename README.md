# pushpin with openresty

## stream

* access

```code
curl -i http://localhost:7999/userinfo

```

* publish message

```code
curl -X POST \
  http://localhost:8080/userinfo \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: a401a816-2f51-4183-811b-b62a5c9c66a3' \
  -H 'cache-control: no-cache' \
  -d '{
 "channel":"userinfo",
 "data":{
  "username":"demoapp\n,userinfo app \\n",
  "userage":333
 }
}'
```

## sse

* access

```code
http://localhost:7999/sse with broswer or some tools
```

* publish message

be like sse message type

```code
curl -X POST \
  http://localhost:8080/sse \
  -H 'Content-Type: application/json' \
  -H 'Postman-Token: eb2dda2f-705a-42d8-87dd-be3036dd632c' \
  -H 'cache-control: no-cache' \
  -d '{
	"channel":"loginfo",
	"data": "event: userlogin\ndata: demo login \n\n"
}'
```
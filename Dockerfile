FROM openresty/openresty:alpine-fat
LABEL author="1141591465@qq.com"
RUN /usr/local/openresty/luajit/bin/luarocks install lua-resty-http
RUN opm get thibaultcha/lua-resty-jit-uuid
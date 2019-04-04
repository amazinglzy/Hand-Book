## Apache2 服务器反向代理配置
* 使用a2enmod命令加载proxy模块

```sh
    sudo a2enmod proxy proxy_balancer proxy_http
```

* 修改主机站点配置文件
    /etc/apache2/sites-enabled/000-default.conf

```sh
<VirtualHost *:80>
        #自定义域名
        ServerName example.com
        #off表示开启反向代理，on表示开启正向代理
        ProxyRequests Off
        ProxyMaxForwards 100
        ProxyPreserveHost On
        #反代理要解析的ip 支持添加端口
        ProxyPass / http://172.16.168.35:7001/
        ProxyPassReverse / http://172.16.168.35:7001/

        <Proxy *>
            Order Deny,Allow
            Allow from all
        </Proxy>
</VirtualHost>
```

## Name-based Virtual Hosts

修改 `httpd.conf` 文件，加入以下内容。
```sh
<VirtualHost *:80>
    # This first-listed virtual host is also the default for *:80
    ServerName www.example.com
    ServerAlias example.com 
    DocumentRoot "/www/domain"
</VirtualHost>
```
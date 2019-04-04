# nginx
```sh
sudo vim /etc/nginx/conf.d/mgedata.conf
```

```conf
server {
    listen      80;
    server_name 192.168.56.130;
    charset     utf-8;

    client_max_body_size 75M;
 
    location /static {
        alias /home/owly/mgedata/static;
    }
 
    location / {
        uwsgi_pass  unix:///tmp/uwsgi_mgedata.sock;
        include     /etc/nginx/uwsgi_params;
    }
}

server {
    listen      443 ssl;
    server_name 192.168.56.130;
    charset     utf-8;

	ssl_certificate /home/owly/mge_certificate/server.crt;
	ssl_certificate_key /home/owly/mge_certificate/server.key;
 
    client_max_body_size 75M;
 
    location /static {
        alias /home/owly/mgedata/static;
    }
 
    location / {
        uwsgi_pass  unix:///tmp/uwsgi_mgedata.sock;
        include     /etc/nginx/uwsgi_params;
    }
}
```
## 部署
**uwsgi+nginx**
1. uwsgi

    安装
    ```sh
    sudo apt install pythonX.Y-dev
    source /path/to/virtualenv/bin/activate
    pip install uwsgi
    ```

    新建uwsgi配置文件，以启动django工程
    ```sh
    # vim uwsgi_project.ini
    # mysite_uwsgi.ini file
    [uwsgi]

    # Django-related settings
    # the base directory (full path)
    chdir           = /path/to/your/project
    # Django's wsgi file
    module          = project.wsgi
    # the virtualenv (full path)
    home            = /path/to/virtualenv

    # process-related settings
    # master
    master          = true
    # maximum number of worker processes
    processes       = 10
    # the socket (use the full path to be safe
    socket          = /path/to/your/project/mysite.sock
    # ... with appropriate permissions - may be needed
    # chmod-socket    = 664
    # clear environment on exit
    vacuum          = true

    ## mgedata add by yuvv
    threads         = 2
    lazy-apps       = true
    daemonize = /var/log/uwsgi/mgedata.log

    pidfile = /tmp/uwsgi_mgedata.pid

    touch-reload = /opt/www/sites/mgedata/manage.py

    wsgi-disable-file-wrapper = true
    ```

    运行 `uwsgi --ini uwsgi_project.ini` 即可运行改 django project。
    
2. nginx

    安装
    ```sh
    sudo apt install nginx
    ```

    设置开机自启
    ```sh
    sudo systemctl daemon-reload
    sudo systemctl enable nginx
    sudo systemctl start nginx
    ```

    nginx与uwsgi对接
    ```sh
    # vim /etc/nginx/conf.d/project.conf
    # configuration of the server
    server {
        # the port your site will be served on
        listen      80;
        # the domain name it will serve for
        server_name example.com; # substitute your machine's IP address or FQDN
        charset     utf-8;

        # max upload size
        client_max_body_size 75M;   # adjust to taste

        # Django media
        location /media  {
            alias /path/to/your/mysite/media;  # your Django project's media files - amend as required
        }

        location /static {
            alias /path/to/your/mysite/static; # your Django project's static files - amend as required
        }

        # Finally, send all non-media requests to the Django server.
        location / {
            uwsgi_pass  /tmp/xxx.sock; # socket's path
            include     /path/to/your/mysite/uwsgi_params; # the uwsgi_params file you installed /etc/nginx/uwsgi_params
        }
    }
    ```

    重启nginx
    ```sh
    sudo systemctl restart nginx
    ```

## 出现的问题
1.  Django 服务不能被外部主机访问
    将服务地址设为 `0.0.0.0:8000`
    ```sh
    python manage.py runserver 0.0.0.0:8000
    ```
2. 国际化
    ```sh
    python manage.py makemessages --all
    ```
    在模板里要加
    ```html
    {% load i18n %}
    ```
    js 国际化
    ```
    # urls.py 加上下面的语句
    from django.views.i18n import JavaScriptCatalog
    urlpatterns += [
        url(r'^jsi18n/$', JavaScriptCatalog.as_view(), name='javascript-catalog'),
    ]
    ```

3. 将queryset转化为json
    ```python
    from django.core import serializers
    data = serializers.serialize("json", SomeModel.objects.all())
    data1 = serializers.serialize("json", SomeModel.objects.filter(myfield1=myvalue))
    ```

4. 解决Djanog 和 JS标签冲突的问题

    ```html
    {% verbatim %}
        {{if dying}}Still alive.{{/if}}
    {% endverbatim %}
    ```

5. Template 使用 url
    ```html
    {% url 'search:adv' %}
    ```

6. 使用 SearchVector 搜索 JsonField
    ```pyhton
    from django.contrib.postgres.search import SearchVector
    from django.db.models import TextField
    from django.db.models.functions import Cast

    Product.objects.annotate(
        search=SearchVector(Cast('attributes', TextField())),
    ).filter(search=keyword)
    ```

    或者
    ```python
    from django.contrib.postgres.search import SearchVector
    from django.contrib.postgres.fields.jsonb import KeyTextTransform

    Product.objects.annotate(
        search=SearchVector(KeyTextTransform('key1', 'attributes')),
    ).filter(search=keyword)
    ```

7. Django 出现 no such table 'django_session' 的问题
    1. 没有 migrations 好
    2. pycharm 没有设置正确的配置文件（如果使用不同的数据库会出现这样的问题）
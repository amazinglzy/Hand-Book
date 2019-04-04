# 使用 typecho 搭建博客网站

## 环境配置
1. 安装apache2
    ```sh
    apt install apache2
    ```
    可以通过在浏览器中访问服务器地址测试是否安装成功。

2. 安装数据库

    ```sh
    apt install mysql-server mysql-client
    ```
    > 在安装过程会提示输入 `root` 的密码.
    ```sh
    mysql -u root -p
    # 输入密码
    ```
    这样就可以登陆数据库进行操作了。
    ```sh
    $ mysql -u adminusername -p
    Enter password:
    Welcome to the MySQL monitor.  Commands end with ; or \g.
    Your MySQL connection id is 5340 to server version: 3.23.54

    Type 'help;' or '\h' for help. Type '\c' to clear the buffer.

    mysql> CREATE DATABASE databasename;
    Query OK, 1 row affected (0.00 sec)

    mysql> GRANT ALL PRIVILEGES ON databasename.* TO "wordpressusername"@"hostname"
        -> IDENTIFIED BY "password";
    Query OK, 0 rows affected (0.00 sec)

    mysql> FLUSH PRIVILEGES;
    Query OK, 0 rows affected (0.01 sec)

    mysql> EXIT
    Bye
    $
    ```
    1. `CREATE DATABASE databasename;` 将 `databasename` 改为自己定义的数据库名字，作用是新建一个数据库；
    2. `GRANT ALL PRIVILEGES ON databasename.* TO "wordpressusername"@"hostname" IDENTIFIED BY "password";` 作用是给用户赋予操作数据库的全部权限。`databasename` 是指定的数据库名称，`wordpressusername` 是用户名；`hostname` 一般用 `localhost` ，`password` 用自己的密码替代；
    3. `FLUSH PRIVILEGES;` 将当前user和privilige表中的用户信息/权限设置从mysql库(MySQL数据库的内置库)中提取到内存里。
    4. `CREATE USER 'username'@'host' IDENTIFIED BY 'password';` 用于创建新用户。


3. 安装 php7.2

    ```sh
    add-apt-repository ppa:ondrej/php
    apt update
    apt install php7.2-fpm php7.2-mysql php7.2-curl php7.2-gd php7.2-mbstring php7.2-xml php7.2-xmlrpc php7.2-zip php7.2-opcache -y
    ```
    在网站根目录中 apache2 默认 `/var/www/html` 中新建一个文件 `test.php`，将以下代码放入其中，输入网址 `www.examle.com/test.php` 查看是否有页面显示出来。
    ```php
    <?php phpinfo(); ?>
    ```
    > 如果不显示页面而是下载文件的话，执行以下命令：
    > ```sh
    > apt install libapache2-mod-php
    > service apache2 restart
    > # a2enmod php7.2
    > ```

## 安装博客程序

下载博客代码
```sh
wget http://typecho.org/downloads/1.1-17.10.30-release.tar.gz
tar -zxf xxx
```

将该文件夹放到网站根目录对应的文件夹，访问 `www.example.con/install.php` 进行安装，其中会提示输入一些信息，按照提示输入即可。

## 显示Markdown的mathjax公式
```php
<script type="text/x-mathjax-config">
      MathJax.Hub.Config({
      extensions: ["tex2jax.js"],
      jax: ["input/TeX", "output/HTML-CSS"],
      tex2jax: {
	inlineMath: [ ['$','$'], ["\\(","\\)"] ],
	displayMath: [ ['$$','$$'], ["\\[","\\]"] ],
	processEscapes: true
      },
      "HTML-CSS": { availableFonts: ["TeX"] }
      });
</script>
<script type="text/javascript"
    src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?   config=TeX-AMS-MML_HTMLorMML">
</script>
```

将上面的代码加到 `{website_dir}/usr/themes/default/header.php` 中的 `<heder>` 标签内。

1. [参考博客](https://blog.csdn.net/u011134961/article/details/51290616)
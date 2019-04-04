## 0. 出现的问题
+ 安装 zhparser 过程中 make 失败

**Problem 1:**
```sh
You need to install postgresql-server-dev-X.Y for building a server-side extension or libpq-dev for building a client-side application.
make: *** No targets.  Stop.
```
Solution:

```sh
sudo apt-get install postgresql
sudo apt-get install python-psycopg2
sudo apt-get install libpq-dev
```

**Problem 2:**
```sh
Makefile:18: /usr/lib/postgresql/10/lib/pgxs/src/makefiles/pgxs.mk: No such file or directory
make: *** No rule to make target '/usr/lib/postgresql/10/lib/pgxs/src/makefiles/pgxs.mk'.  Stop.
```

Solution:
```sh
sudo apt-get install postgresql-server-dev-all
sudo apt-get install postgresql-common
```

## 1. 入门
[Installnation](https://www.postgresql.org/download/linux/ubuntu/)
[博客](https://www.cnblogs.com/ae6623/p/6149375.html)

## 2. 安装中文分词
[github/README](https://github.com/amutu/zhparser)


## 3. 配置
> 相关问题
> 1. psql: FATAL: Peer authentication failed for user "dev"
> 
>    ```sh
>    psql user_name  -h 127.0.0.1 -d db_name
>    ```
**外部访问**
`vim /etc/postgresql/9.6/main/postgresql.conf`
```sh
listen_addresses = 'xx.xx.xx.xx'
```

`vim /etc/postgresql/9.6/main/pg_hba.conf`
```sh
# TYPE  DATABASE        USER            ADDRESS                 METHOD
host    play            owly            192.168.56.1/32         password
```

## Tools
1. pg_restore

    ```sh
    pg_restore -U mge -h 202.204.62.61 -W -d mgedata -F d -l pg-dump/
    ```

    `-d` database

    `-F d` directory

    `-l` list toc.dat
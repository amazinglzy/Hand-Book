# Mongodb 的一些操作
## Installnation

**OS**: Ubuntu 16.04

**MongoDB Version**: 3.4

1. Import the public key.

    ```sh
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
    ```
    ps: 3.6

    ```sh
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5
    ```

2. Create a list file for MongoDB
    ```sh
    echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list
    ```

    ps: 3.6
    ```sh
    echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list
    ```

3. update the source
    ````sh
    sudo apt-get update
    ````

4. install MongoDB
    ```sh
    sudo apt-get install -y mongodb-org
    ```

## Enable Auth
**MongoDB Version**: 3.4

> Create keyfile
> ```sh
> openssl rand -base64 756 > <path-to-keyfile>
> chmod 400 <path-to-keyfile>
> ```

```sh
use admin
db.createUser(
  {
    user: "myUserAdmin",
    pwd: "abc123",
    roles: [ { role: "userAdminAnyDatabase", db: "admin" } ]
  }
)
exit
```

[MongoDB配置文件](https://docs.mongodb.com/v3.4/reference/configuration-options/)
[Built-In Roles](https://docs.mongodb.com/v3.4/core/security-built-in-roles/)
> dbAdmin

```sh
security:
  authorization: enabled
```

```sh
db.auth("username", "password")
```

```sh
use reporting
db.grantRolesToUser(
    "reportsUser",
    [
      { role: "read", db: "accounts" }
    ]
)
```
> 需要注意的是，当执行操作时，要切换到对应用户所在的 Database

```sh
use reporting
db.revokeRolesFromUser(
    "reportsUser",
    [
      { role: "readWrite", db: "accounts" }
    ]
)
```

```sh
use admin
db.changeUserPassword("mge", "mge")
```


## 配置默认的 Primary 节点
1. 通过设置节点的优先度
    ```sh
    conf = rs.conf()
    conf.members[0].priority=3
    rs.reconfig(conf)
    ```

## mongodb 配置副本集
如果有一台服务器状态是 (unreachable) 等等，可能是防火墙没有设置好得原因，增加以下过滤语句。
```sh
iptables -A INPUT -p tcp -m state --state NEW -m tcp --dport 27017 -j ACCEPT
```

## mongodb 内部shell 的命令示例
```sh
# 显示数据库
show dbs

# 删除数据库
db.dropDatabase()
```

## mongodump & mongorestore 用于转移数据库
```sh
# mongodump -h dbhost -d dbname -o dbdirectory
```

```sh
# mongorestore -h <hostname><:port> -d dbname <path>
mongorestore -d name dir/
# --username=<username>, -u=<username>
# --authenticationDatabase=<dbname>
# --gzip  decompress gzipped input
```



## 查找 _id 为 xxx 的 collection 的名称
```sh
db.getCollectionNames().forEach(function(collName) { var doc = db.getCollection(collName).findOne({"_id":ObjectId("57908c549fe7602a10090238")}); if (doc != null) print(doc._id + " was found in " +collName); });
```

## Python 操作 Mongo
```py
# -*- coding:utf-8 -*-
from pymongo import MongoClient

client = MongoClient('192.168.119.130', 27017)


db = client.test
collection = db.tmp

many_data = [
    {"name": "Alice"},
    {"name": "Bob"}
]

for data in many_data:
    collection.insert(data)

```

## Index
 > If you don't index it will result in a collection scan and very poor performance. However, even if the field is indexed it can result in poor performance. The reason is that MongoDB can make good use of indexes only if your regular expression is a “prefix expression” – these are expressions starting with the “^” character.
 > （ 使用 `$regex` 的时候 ）

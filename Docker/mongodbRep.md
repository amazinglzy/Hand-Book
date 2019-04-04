# Build MongoDB Replica with Auth in Docker

1. 准备好Docker镜像
    
    准备`mongoKeyFile`用于认证
    ```sh
    openssl rand -base64 756 > <path-to-keyfile>
    chmod 400 <path-to-keyfile>
    ```

    **Dockerfile**
    ```sh
    FROM mongo:3.6

    ADD mongoKeyFile /var/mongodb/
    ADD entrypoints /var/mongodb/entrypoints

    EXPOSE 27017
    ```

    **mongoInitAdmin.sh**
    ```sh
    #!/bin/bash
    # Script to add admin user into mongodb, 
    # and restart the mongodb service. 
    if [ -z $MONGO_ADMIN_USER ]; then
        MONGO_ADMIN_USER=owly
    fi
    if [ -z $MONGO_ADMIN_PASSWORD ]; then
        MONGO_ADMIN_PASSWORD=101begin
    fi
    if [ -z $MONGO_BACKUP_USER ]; then
        MONGO_ADMIN_USER=mongoConnector
    fi
    if [ -z $MONGO_BACKUP_PASSWORD ]; then
        MONGO_BACKUP_PASSWORD=mongoConnector
    fi

    mkdir /var/mongodb/log
    mongod --logpath /var/mongodb/log/mongodb.log --fork
    #cmd="use admin;\
    #	db.createUser({\
    #		user:\"$MONGO_ADMIN_USER\",\
    #		pwd:\"$MONGO_ADMIN_PASSWORD\",\
    #		roles:[{role:\"userAdminAnyDatabase\", db:\"admin\"}]});
    #	exit;"
    #echo $cmd
    mongo << EOF
    use admin
    db.createUser({
        user: "$MONGO_ADMIN_USER",
        pwd: "$MONGO_ADMIN_PASSWORD",
        roles: [{role: "userAdminAnyDatabase", db: "admin"}, {role: "clusterAdmin", db: "admin"}]
    })
    db.createUser({
        user: "$MONGO_BACKUP_USER",
        pwd: "$MONGO_BACKUP_PASSWORD",
        roles: ["backup"]
    })
    exit
    EOF
    mongod --shutdown
    echo init admin user with password.
    mongod --auth --logpath /var/mongodb/log/mongodb.log --keyFile /var/mongodb/mongoKeyFile --replSet mgedata --bind_ip_all
    ```

    使用`sudo docker build -t mongo:tag .`就可以将镜像创建。

    **replBase.sh**
    ```sh
    #!/bin/bash
    mkdir /var/mongodb/log
    mongod --auth --logpath /var/mongodb/log/mongodb.log --keyFile /var/mongodb/mongoKeyFile --replSet mgedata --bind_ip_all
    ```

2. 编排容器

    **docker-compose.yml**
    ```yaml
    version: '3'
    services:
        Alice: 
            image: amazinglzy/mongo:mgedataRep
            ports: 
            - "27017:27017"
            entrypoint: /var/mongodb/entrypoints/initAdmin.sh
        Bob:
            image: amazinglzy/mongo:mgedataRep
            ports:
            - "27018:27017"
            entrypoint: /var/mongodb/entrypoints/replBase.sh
    ```
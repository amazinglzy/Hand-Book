# Docker
## 安装
```sh
sudo apt-get update

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update

sudo apt-get install docker-ce
```

## 修改 Docker 的源
```sh
# sudo vim /etc/docker/daemon.json
# 添加上以下内容，如果没有该文件就新建一个
{
  "registry-mirrors": ["https://registry.docker-cn.com"]
}
```

## 常见的用法
```sh
docker build -t friendlyname .  # Create image using this directory's Dockerfile
docker run -p 4000:80 friendlyname  # Run "friendlyname" mapping port 4000 to 80
docker run -d -p 4000:80 friendlyname         # Same thing, but in detached mode
docker container ls                                # List all running containers
docker container ls -a             # List all containers, even those not running
docker container stop <hash>           # Gracefully stop the specified container
docker container kill <hash>         # Force shutdown of the specified container
docker container rm <hash>        # Remove specified container from this machine
docker container rm $(docker container ls -a -q)         # Remove all containers
docker image ls -a                             # List all images on this machine
docker image rm <image id>            # Remove specified image from this machine
docker image rm $(docker image ls -a -q)   # Remove all images from this machine
docker login             # Log in this CLI session using your Docker credentials
docker tag <image> username/repository:tag  # Tag <image> for upload to registry
docker push username/repository:tag            # Upload tagged image to registry
docker run username/repository:tag                   # Run image from a registry
```
### 通过`dockerfile`创建`image`
```sh
sudo docker build -t owly/elasticsearch:basic .
```

### 通过已有`image`创建`container`
```sh
sudo docker run -d -p 9200:9200 --name es owly/elasticsearch:basic
```

### 停止所有的container
```sh
docker stop $(docker ps -a -q)
```

### 删除制定容器
```sh
sudo docker rm :name
```

### 运行容器
```sh
sudo docker run --name rs_server1 -p 21117:27017 -d pc/mongod:master --noprealloc --smallfiles --replSet rs1
```

### 进入容器
```sh
sudo docker exec -itd :name /bin/bash
```

## Projects
1. mge docker environment.

    ```sh
    git clone git@gitlab.com:owly/mge-docker-env.git
    ```
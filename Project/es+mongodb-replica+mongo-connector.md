# MGEDATA-SEARCH 开发文档

**requirements**

- elasticsearch=5.5.3
- kibana=5.5.3
- mongodb=3.4

## 1 Search API
| 端点                                  | HTTP方法 | 功能          |
| ----------------------------------- | ------ | ----------- |
| {host}/api/v1/search/q              | GET    | 获取全部文档      |
| {host}/api/v1/search/q?words=:words | GET    | 全文检索        |
| {host}/api/v1/search/q              | POST   | 高级检索        |
| {host}/api/v1/search/q?type=simple  | POST   | simple 高级检索 |

### 全文检索
```javascript
GET {host}/api/v1/search/q
GET {host}/api/v1/search/q?word=[word]
```
\[word\]存放查询的关键词句

### 高级检索
#### formal
```javascript
POST {host}/api/v1/search/q
{
    "query": {
        ...
    }
    "highlight": {
        ...
    }
    ...
}
```
json格式应与elasticsearch的格式一致, 比如
```javascript
POST {host}/api/v1/search/q
{
    "query": {
        "bool": {
            "must": {
                "match": {"age": 13}
            }

            "filter": {
                "term": {"name": "xx"}
            }
        }
    }
    "highlight": {
        ...
    }
}
```

#### simple
可以一条一条输入字段的限制
```javascript
POST {host}/api/v1/search/q?type=simple
{
    "query":
    [
        {"type":"must", "filter_type":"range", "name":"xxx", content:{}},
        {"type":"must_not", "filter_type":"term", "name":"xxx", content:{}},
        {"type":"should", "filter_type":"terms", "name":"xxx", content:{}},
        ...
    ]
}
```


## 2 配置 elasticsearch 用于全文搜索

### 2.0 结构组织

+ mongodb 存储数据
+ elasticsearch 用于搜索
+ mongo-connector 和 elastic2-doc-manager 用于两者之间传送数据

### 2.1 mongodb 环境

详见文档[MongoDB Manual 3.4](https://docs.mongodb.com/manual/)

- **import the public key used by the package management systems.**

  ```sh
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
  ```

  ​

- **create a list file for MongoDB.**

  **Ubuntu 12.04**

  ```sh
  echo "deb [ arch=amd64 ] http://repo.mongodb.org/apt/ubuntu precise/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list
  ```

  **Ubuntu 14.04**

  ```sh
  echo "deb [ arch=amd64 ] http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list
  ```

  **Ubuntu 16.04**

  ```sh
  echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list
  ```

  > 如果出现多次配置的Warning，可以再 Ubuntu 的 System Settings > Software & Updates > Other Software 中手动将重复的取消勾选

- **Reload local package database.**

  ```sh
  sudo apt-get update
  ```

- **Install the MongoDB packages.**

  ```sh
  sudo apt-get install -y mongodb-org
  ```

- **Run MongoDB Community Edition**

  ```sh
  sudo service mongod start

  ```

- 配置 MongoDB 副本集

  - 准备三台Linux服务器，以上述方式安装好 MongoDB

  - 配置 MongoDB

    ```sh
    # sudo vim /etc/mongod.conf
    net:
    	port: 27017
    	bindIp: 0.0.0.0

    replication:
    	replSetName: mgedb # 自己命名，这里命名mgedb
    ```

  - 在线配置

    - 每一台服务器开启 mongodb 服务

    - 选择一台电脑登陆

      ```sh
      mongo
      ```

    - 初始化副本集

      ```sh
      rs.initiate({
      	_id: "mgedb", 		# 自己设置的副本名
      	members: [ { _id: 0, host: "xx.xx.xx.xx:27017" } ]
      })
      					   # xx.xx.xx.xx 表示服务器所在局域网的地址
      rs.conf()                # 测试是否成功
      ```

    - 增加副本额外准备的服务器

      ```sh
      rs.add("xx.xx.xx.xx:27017")
      rs.add("xx.xx.xx.xx:27017")
      ```

    - 查看副本集状态

      ```sh
      rs.status()
      ```

      ​

### 2.2 elasticsearch 环境

详见文档[Elasticsearch Reference 5.5](https://www.elastic.co/guide/en/elasticsearch/reference/5.5/index.html)

- 安装 elasticsearch

  - Import the Elasticsearch PGP Key

    ```sh
    wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
    ```

  - 安装

    ```sh
    sudo apt-get install apt-transport-https

    echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-5.x.list

    sudo apt-get update && sudo apt-get install elasticsearch
    ```

  - 设置系统自启服务

    查看SysV

    ```sh
    ps -p 1
    ```

    - Running Elasticsearch with SysV **init**

      ```sh
      sudo update-rc.d elasticsearch defaults 95 10
      sudo -i service elasticsearch start

      # sudo -i service elasticsearch stop
      ```

    - Running Elasticsearch with **systemd**

      ```sh
      sudo /bin/systemctl daemon-reload
      sudo /bin/systemctl enable elasticsearch.service

      sudo systemctl start elasticsearch.service
      # sudo systemctl stop elasticsearch.service
      ```

    - 需要注意的是，可以通过如下方式查看 log

      ```sh
      sudo journalctl -f

      sudo journalctl --unit elasticsearch

      sudo journalctl --unit elasticsearch --since  "2016-10-30 18:17:16"
      ```

  - 可以通过再浏览器地址栏中输入以下地址测试是否安装成功

    ```sh
    localhost:9200
    ```

- 安装 kibana 监控 elasticsearch 运行状况

  - - Import the Elasticsearch PGP Key

      ```sh
      wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
      ```

    - 安装

      ```sh
      sudo apt-get install apt-transport-https

      echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-5.x.list

      sudo apt-get update && sudo apt-get install kibana
      ```

    - 设置系统自启服务

      查看SysV

      ```sh
      ps -p 1
      ```

      - Running Elasticsearch with SysV **init**

        ```sh
        sudo update-rc.d kibana defaults 95 10
        sudo -i service kibana start

        # sudo -i service kibana stop
        ```

      - Running Elasticsearch with **systemd**

        ```sh
        sudo /bin/systemctl daemon-reload
        sudo /bin/systemctl enable kibana.service

        sudo systemctl start kibana.service
        # sudo systemctl stop kibana.service
        ```

    - 可以通过再浏览器地址栏中输入以下地址测试是否安装成功

      ```sh
      localhost:5601
      ```
- 安装 ik 用于中文分词
    ```sh
    # cd /usr/share/elasticsearch
    sudo ./bin/elasticsearch-plugin install https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v5.5.3/elasticsearch-analysis-ik-5.5.3.zip
    ```

    新建映射模板, 使得mongo-connector同步下自动建立的index映射使用ik分词器
    ```javascript
    PUT _template/rtf
    {
      "template":   "*",
      "settings": { "number_of_shards": 1 },
      "mappings": {
        "_default_": {
          "_all": {
            "enabled": true
          },
          "dynamic_templates": [
            {
              "strings": {
                "match_mapping_type": "string",
                "mapping": {
                  "type": "text",
                  "analyzer":"ik_max_word",
                  "ignore_above": 256,
                  "fields": {
                    "keyword": {
                      "type":  "keyword"
                    }
                  }
                }
              }
            }
          ]
        }
      }
    }
    ```

### 2.3 mongo-connector 配置

- 安装 mongo-connector

  ```sh
  pip install mongo-connector[elastic5]
  ```

- 安装 elastic2-doc-manager

  ```sh
  pip install elastic2-doc-manager[elastic5]
  ```

- 基本使用

  ```sh
  mongo-connector -m localhost:27017 -t localhost:9200 -d elastic2_doc_manager
  ```

  两个地址分别表示 mongodb 的地址 和 elasticsearch 的地址，mongodb 任意一个副本的地址都可以。

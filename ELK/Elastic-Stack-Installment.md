# Installing the Elastic Stack

Environment: Ubuntu server 16.04

Content: 
1. Elasticsearch
2. X-Pack for Elasticsearch
    公钥和私钥的权限问题
    
3. Kibana
4. X-Pack for Kibana

    ```sh
    bin/x-pack/setup-passwords interactive
    ```
5. Logstash
    ```sh
    sudo -Hu logstash /usr/share/logstash/bin/logstash --path.settings=/etc/logstash -t
    ```

6. X-Pack for Logstash
7. Beats
8. Elasticsearch Hadoop

```sh
curl -XPUT -u elastic 'http://<host>:<port>/_xpack/license?acknowledge=true' -H "Content-Type: application/json" -d @license.json
curl -XPUT -u elastic 'http://<host>:<port>/_xpack/license' -H "Content-Type: application/json" -d @license.json
```
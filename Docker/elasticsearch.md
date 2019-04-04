# Build Elasticsearch with Mongo-Connector in Docker
1. 准备好Docker镜像

    Elasticsearch Dockerfile
    ```sh
    FROM openjdk:8

    RUN apt-get update && apt-get install -y apt-transport-https apt-utils
    RUN wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add -
    RUN echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-6.x.list
    RUN apt-get update && apt-get install -y elasticsearch
    EXPOSE 9200 9300

    ADD conf /etc/elasticsearch
    RUN chown -R root:elasticsearch /etc/elasticsearch
    USER elasticsearch
    ENTRYPOINT [ "/usr/share/elasticsearch/bin/elasticsearch" ]
    ```

    Kibana Dockerfile
    ```sh
    FROM openjdk:8

    RUN apt-get update && apt-get install -y apt-transport-https apt-utils
    RUN wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add -
    RUN echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-6.x.list
    RUN apt-get update && apt-get install kibana
    EXPOSE 5601

    ADD conf /etc/kibana
    RUN chown -R root:root /etc/kibana
    ENTRYPOINT [ "/usr/share/kibana/bin/kibana" ]
    ```

    Mongo-Connector Dockerfile
    ```sh
    FROM python:3.6

    WORKDIR /root

    RUN pip install mongo_connector
    RUN pip install elasticsearch

    ADD mgeDocManager /root/mgeDocManager
    ADD entry_with_config.sh /root
    RUN chmod +x /root/entry_with_config.sh
    RUN chown root:root /root/entry_with_config.sh
    RUN chown -R root:root /root/mgeDocManager

    ENTRYPOINT [ "/root/entry_with_config.sh" ]
    ```

    entry_with_config.sh
    ```sh
    #!/bin/bash
    # Must Set Environment Variable MAIN_ADDRESS 172.17.0.1:27017
    #                               DOC_MANAGER mge_doc_manager
    #                               TARGET_URL 172.17.0.1:9200
    #                               ADMIN_USER_NAME
    #                               ADMIN_USER_PASSWORD

    if [ -z $MAIN_ADDRESS ]; then
        MAIN_ADDRESS=172.17.0.1:27017
    fi

    if [ -z $DOC_MANAGER ]; then
        DOC_MANAGER=mge_doc_manager
    fi

    if [ -z $TARGET_URL ]; then
        TARGET_URL=172.17.0.1:9200
    fi

    if [ -z $ADMIN_USER_NAME ]; then
        ADMIN_USER_NAME=mongoConnector
    fi

    if [ -z $ADMIN_USER_PASSWORD ]; then
        ADMIN_USER_PASSWORD=mongoConnector
    fi

    cat << EOF > config.json
    {
    "mainAddress": "$MAIN_ADDRESS",

    "authentication": {
        "adminUsername": "$ADMIN_USER_NAME",
        "password": "$ADMIN_USER_PASSWORD"
    },

    "namespaces": {
        "test.es": "test._doc",
        "mgedata.data_content": "data_content._doc",
        "mgedata.data_field_container": "data_field_container._doc",
        "mgedata.data_field_table_row": "data_field_table_row._doc"
    },

    "docManagers": [
        {
        "docManager": "$DOC_MANAGER",
        "targetURL": "$TARGET_URL"
        }
    ]
    }
    EOF

    export PYTHONPATH=/root/mgeDocManager
    ```


# Problem
1. vm.max_map_count 65530 is too low

    + sysctl: setting key "vm.max_map_count": Read-only file system

        在宿主机上运行：
        ```sh
        sudo systemctl -w vm.max_map_count=262144
        ```

        ```sh
        # vim /etc/sysctl.conf
        vm.max_map_count=262144
        # sysctl -p
        ```

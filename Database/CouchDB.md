# CouchDB
## Installnation

```sh
echo "deb https://apache.bintray.com/couchdb-deb {distribution} main" \
    | sudo tee -a /etc/apt/sources.list

# Ubuntu 16.04 
# 将 {distribution} 替换成 xenial
echo "deb https://apache.bintray.com/couchdb-deb xenial main" \
    | sudo tee -a /etc/apt/sources.list

curl -L https://couchdb.apache.org/repo/bintray-pubkey.asc \
    | sudo apt-key add -

sudo apt-get update && sudo apt-get install couchdb
```

> admin:独上高楼
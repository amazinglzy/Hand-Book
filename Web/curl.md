## 使用 curl 模拟发送 get 请求
```sh
curl "http://www.baidu.com"  如果这里的URL指向的是一个文件或者一幅图都可以直接下载到本地

curl -i "http://www.baidu.com"  显示全部信息

curl -l "http://www.baidu.com" 只显示头部信息

curl -v "http://www.baidu.com" 显示get请求全过程解析
```

## 使用 curl 模拟发送 post 请求
```sh
curl -d "param1=value1&param2=value2" "http://www.baidu.com"
```

## json 格式的 post 请求
```sh
curl -l -H "Content-type: application/json" -X POST -d '{"phone":"13521389587","password":"test"}' http://domain/apis/users.json
```

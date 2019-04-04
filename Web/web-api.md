> web api 的定义：Web API 就是一个Web系统，通过访问URI可以与服务器完成信息交互，或者获取存放在服务器的数据信息等，这样调用者通过程序进行访问后即可机械地使用这些数据。

> **HTTP方法**
> GET: 获取信息
> POST: 新建信息
> PUT: 更新信息
> DELETE: 删除信息
> PATCH: 更新部分信息

**通过POST方法或者GET方法使用DELETE方法或者PUT方法**
```html
POST  /v1/users/123 HTTP/1.1
Host: api.example.com
X-HTTP-Method-Override: DELETE
```
或者
```sh
GET /v1/users?user=testuser & _method=PUT
```

**web api** 端点设计要注意的地方
1. 使用名词的复数形式
2. 注意所用的单词
3. 不要使用空格及需要编码的字符
4. 使用 - 来连接字符

> 使用 OAuth 2 来进行用户的认证

**JSONP**
通过 HTML 中的  标签获取API返回的数据，并使用 callback 函数来处理数据。

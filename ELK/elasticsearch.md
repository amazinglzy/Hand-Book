> _index, _type, _id 唯一确定一个文档
> 可以使用 groovy 脚本
> **PUT 和 POST 的区别**
> Both PUT and POST can be used for creating.

>You have to ask "what are you performing the action to?" to distinguish what you should be using. Let's assume you're designing an API for asking questions. If you want to use POST then you would do that to a list of questions. If you want to use PUT then you would do that to a particular question.

>Great both can be used, so which one should I use in my RESTful design:

>You do not need to support both PUT and POST.

>Which is used is left up to you. But just remember to use the right one depending on what object you are referencing in the request.

>Some considerations:

> - Do you name your URL objects you create explicitly, or let the server decide? If you name them then use PUT. If you let the server decide then use POST.
> - PUT is idempotent, so if you PUT an object twice, it has no effect. This is a nice property, so I would use PUT when possible.
> - You can update or create a resource with PUT with the same object URL
> - With POST you can have 2 requests coming in at the same time making modifications to a URL, and they may update different parts of the object.


## 一些基本的操作

**创建一个新文档**
相当与用 elasticsearch自动生成唯一的 _id
```
POST /website/blog/
{ ... }
```

自定义 _id 创建新的文档
```
PUT /website/blog/123
{ ... }
```

为了确定是完全创建了一个新的还是覆盖了一个已经存在的文档，有两种方法：
```
PUT /website/blog/123?op_type=create
{ ... }

PUT /website/blog/123/_create
{ ... }
```

**删除一个文档**
```
DELETE /website/blog/123
```

**基本筛选文档**
检查文档是否存在
```
HEAD /webiste/blog/123
```

获取整个文档
```
GET /website/blog/123
```

检索多个文档
```
POST /_mget
{
    "docs": [
        {
            "_index":"website",
            "_type":"blog",
            "_id":2
        }
        {
            "_index":"website",
            "_type":"pageviews",
            "_id": 1,
            "_source":"views"
        }
    ]
}

POST /website/blog/_mget
{
    "docs": [
        { "_id": 2 },
        { "_type": "pageviews", "_id": 1}
    ]
}

POST /website/blog/_mget
{
    "ids": ["2", "1"]
}
```

**更新文档**
更新整个文档，使用删除-新建的方式更新
```
PUT /website/blog/123
{ ... }
```

局部更新
```
PUT /website/blog/123
{
    "doc": { ... }
}
```

更新可能不存在的文档
```
POST /website/blog/1/_update
{
    ...
    "upsert": {
        "views": 1
    }
}
```

如果存在多个进程同时对一个文档进行修改，可能会发生冲突，这样会修改失败，解决方法就是修改多次
```
POST /website/pageviews/1/_update?retry_on_conflict=5
{
	"script"	:	"ctx._source.views+=1",
	"upsert":	{
		"views":	0
	}
}
```

**批量操作**
_bulk
其格式为
```
{action: {metadata}}\n
{request body }\n
{action: {metadata}}\n
{request body }\n
```
|行为|解释|
|-|-|
|create|当文档不存在时创建|
|index|创建新文档或者替换已有的文档|
|update|局部更新文档|
|delete|删除一个文档|

例如：
```
POST	/_bulk
{	"delete":	{	"_index":	"website",	"_type":	"blog",	"_id":	"123"	}}	<1>
{	"create":	{	"_index":	"website",	"_type":	"blog",	"_id":	"123"	}}
{	"title":				"My	first	blog	post"	}
{	"index":		{	"_index":	"website",	"_type":	"blog"	}}
{	"title":				"My	second	blog	post"	}
{	"update":	{	"_index":	"website",	"_type":	"blog",	"_id":	"123",	"_retry_on_conflict"	:	5 }
{	"doc"	:	{"title"	:	"My	updated	blog	post"}	}
```
注意，不能有换行，因为换行用于区分每一条操作。

## 分布式文档存储
> 提示:
> 当我们发送请求,最好的做法是循环通过所有节点请求,这样可以平衡负载。

## 搜索或查询
```
GET /_search
GET /gb/_search
GET /gb,us/_search
GET /g*,u*/_search
GET /_all/user,tweat/_search
```

+ name 字段包含 "mary" 或 "john"
+ date 晚于 2014-09-10
+ _all 字段包含 "aggregations" 或 "geo"
查询为 +name:(mary john)+date:>2014-09-10+(aggregations geo)
即
```
GET /_search?q=%2Bname%3A(mary+john)+%2Bdate%3A%3E2014-09-10+%2B(aggregations+geo)
```

**结构化查询**
```
GET /_search
{
  "query": {
    "bool": {
      "must": {"match": {"tweet": "elasticsearch"}},
      "must_not": {"match": {"name": "mary"}},
      "should": {"match": {"tweet": "full text"}}
    }
  }
}
```

match_all 查询 可以查询到所有的文档，是没有查询条件下的默认语句。
```
{
    "match_all": {}
}
```

match 查询 是一个标准查询，不管你需要全文本查询还是精确查询基本都要用到它。
```
{
    "match": {
        "tweet": "About Search"
    }
}
```

multi_match 查询 允许match查询的基础上同时搜索多个字段
```
{
    "multi_match": {
        "query": "full text search",
        "fields": ["title", "body"]
    }
}
```


**过滤**
term 过滤，用于精确匹配值
```
{	"term":	{	"age":		26		}}
{	"term":	{	"date":		"2014-09-01"	}}
{	"term":	{	"public":	true				}}
{	"term":	{	"tag":	"full_text"		}}
```
terms 过滤，可以指定多个匹配条件
```
{
	"terms":	{
		"tag":	[	"search",	"full_text",	"nosql"	]
	}
}
```
range 过滤
```
{
    "range": {
        "age": {
            "gte": 20,
            "lt": 30
        }
    }
}
```
>gt=大于,gte=大于等于,lt=小于,lte=小于等于

exits 和 missing 过滤 可以用于查找文档中是否包含指定字段或没有某个字段
```
{
    "exists": {
        "field": "title"
    }
}
```

bool 过滤
```
{
	"bool":	{
		"must":					{	"term":	{	"folder":	"inbox"	}},
		"must_not":	{
		    "term":	{	"tag":				"spam"		}
		},
		"should":	[
		    {	"term":	{	"starred":	true			}},
		    {	"term":	{	"unread":		true	}}
		]
	}
}
```

**过滤查询**
```
GET /_search
{
    "query": {
        "filtered": {
            "query": {"match_all": {}},
            "filter": {"term": {"folder": "inbox"}}
        }
    }
}
```

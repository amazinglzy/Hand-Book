# 测试MongoDB查询效率

在一种新的数据形式下，测试MongoDB 的查询效率。

**数据生成脚本**
```py
from pymongo import MongoClient
from random import randint, choice

client = MongoClient('mongodb://mge:mge@192.168.56.129:27017/test')

test = client.test
col = test.mul

list_en = []
list_zh = []

f = open('vimim.txt', 'r')
for line in f.readlines():
    ws = line.strip().split()
    if len(ws) > 0:
        list_en.append(ws[0])
        for i in range(1, len(ws)):
            list_zh.append(ws[i])

# for i in range(0, 1000000):
#     if i % 10000 == 0:
#         print('Processing...' + str(i))
#     item = []
#     for j in range(0, 100):
#         item.append({str(j): randint(0, 10000)})
#     col.insert({"p": item})

for i in range(0, 500000):
    if i % 10000 == 0:
        print('Processing...' + str(i))
    item = []
    for j in range(0, 3):
        val = ''
        for l in range(0, 10):
            is_en = randint(0, 1)
            if is_en == 0:
                val += list_en[randint(0, len(list_en) - 1)] + ' '
            else:
                val += list_zh[randint(0, len(list_zh) - 1)] + ' '
        item.append({'n': str(j), 'v': val})
    for j in range(3, 5):
        is_en = randint(0, 1)
        if is_en == 0:
            item.append({'n': str(j), 'v': choice(list_en)})
        else:
            item.append({'n': str(j), 'v': choice(list_zh)})
    for j in range(5, 10):
        item.append({'n': str(j), 'v': randint(0, 10000)})
    col.insert({"p": item})
```


**数据样例**
```json
{
	"_id" : ObjectId("5aa3c9e05b95f30030289f94"),
	"p" : [
		{
			"n" : "0",
			"v" : "绑 浅薄 牢固 节日 摘要 一零一忠狗 furious leg 素来 十字军东征 "
		},
		{
			"n" : "1",
			"v" : "手术 远足 第三 通过 come 四肢 grave probable europe washington "
		},
		{
			"n" : "2",
			"v" : "恐怖 浏览器 古巴 诈财骗局 下 meantime 过程 卷毛 impotence influence "
		},
		{
			"n" : "3",
			"v" : "proselytism"
		},
		{
			"n" : "4",
			"v" : "综合症"
		},
		{
			"n" : "5",
			"v" : 4796
		},
		{
			"n" : "6",
			"v" : 2655
		},
		{
			"n" : "7",
			"v" : 488
		},
		{
			"n" : "8",
			"v" : 5976
		},
		{
			"n" : "9",
			"v" : 2153
		}
	]
}

```

```sh
db.col.find({"p.5": 461})
db.col.find({"p.5": 461, "p.7": 9343})
# 没有使用 Index
db.col.find({"p": {"5": 461}})
# 使用了 Index
db.col.find({"p": {"5": 461, "6": 5892}})
# 没有查询结果（因为{"5": 461, "6": 5892} 只是数组元素的两个元素，没有数组包含{"5": 461, "6": 5892}这样一个元素）
db.col.find({$and: [{"p": {"5": 461}}, {"p": {"6": 5892}}]})
# 使用 Index 并完成查询
db.col.find({"p": {"1": /.*three.*/}})
# 查询不到结果
db.col.find({"p": {$elemMatch: {"1": /.*three.*/}}})
# 可以查到结果，但是没有用 Index
```

```sh
db.col.find({"p": {"n": "5", "v": 9622}})
# 能够查询
db.col.find({$and: [{"p": {"n": "5", "v": 9622}}, {"p": {"n": "0", "v": {$regex: '.*peg.*'}}}]})
# 查询不到结果
db.col.find({"p": {$elemMatch: {"n": "0", "v": /.*peg.*/}}})
# 能够查询 不能够使用 Index
db.col.find({$and: [{$and: [{"p.n": "0"},{"p.v": /.*peg.*/}]}, {$and: [{$and: [{"p.n": "7"}, {"p.v": 7877}]}]}]})
# 能够查询 能够使用 Index

db.two.find({
    "p":{
        $all: [{
                $elemMatch: {
                    "n": "6",
                    "v": 9256
                }
            }
        ]
    }
})

db.col.find({
    "p":{
        $all: [{
                $elemMatch: {
                    "n": "0",
                    "v": /.*leg.*/
                }
            },{
                $elemMatch: 
                {
                    "n": "1",
                    "v": /.*come.*/
                }
            }
        ]
    }
})
```


> ui: no index
> col: compound index
> two: two index specified
> mul: multi index

1. 对于查询
    ```sh
    {
        "p":{
            $elemMatch: {
                "n": "8",
                "v": 1234
            }
        }
    }
    ```

    | 类型      | 时间   | 是否使用 index |
    |-----------|-------| ---------------|
    | 没有index | 1714 | 否 |
    | Compound index | 25 | 是 |
    | 分开建 index |124 | 是 |
    | 直接对数组建 index | 1731 | 否 |

2. 对于查询
    ```sh
    {
        "p": {
            $elemMatch: {
                "n": "0",
                "v": /.*leg.*/
            }
        }
    }
    ```

    
    | 类型      | 时间   | 是否使用 index |
    |-----------|-------| ---------------|
    | 没有index | 2307 | 否 |
    | Compound index | 46916 | 是 |
    | 分开建 index |6240 | 是 |
    | 直接对数组建 index | 2091 | 否 |

3. 对于查询

    ```sh
    {
        "p": {
            $elemMatch: {
                "n": "8",
                "v": {
                    $in:[10, 100, 1000, 10000]
                }
            }
        }
    }
    ```
    
    | 类型      | 时间   | 是否使用 index |
    |-----------|-------| ---------------|
    | 没有index | 1816 | 否 |
    | Compound index | 106 | 是 |
    | 分开建 index |404 | 是 |
    | 直接对数组建 index | 1708 | 否 |

4. 对于查询

    ```sh
    {
        "p": {
            $all: [
                {
                    $elemMatch: {
                        "n": "0",
                        "v": /.*leg.*/
                    }
                },
                {
                    $elemMatch: {
                        "n": "8",
                        "v": 12345
                    }
                }
            ]
        }
    }
    ```

    | 类型      | 时间   | 是否使用 index |
    |-----------|-------| ---------------|
    | 没有index | 1735 | 否 |
    | Compound index | 3 | 是 |
    | 分开建 index |2 | 是 |
    | 直接对数组建 index | 1624 | 否 |

5. 对于查询

    ```sh
    {
        "p":{
            $all: [{
                    $elemMatch: {
                        "n": "0",
                        "v": /.*leg.*/
                    }
                },{
                    $elemMatch: 
                    {
                        "n": "1",
                        "v": /.*come.*/
                    }
                }
            ]
        }
    }
    ```

    | 类型      | 时间   | 是否使用 index |
    |-----------|-------| ---------------|
    | 没有index | 2183 | 否 |
    | Compound index | 67960 | 是 |
    | 分开建 index |23375 | 是 |
    | 直接对数组建 index | 2157 | 否 |

5. 对于查询

    ```sh
    {
        "p": {
            $all: [
                {
                    $elemMatch: {
                        "n": "0",
                        "v": /.*pet.*/
                    }
                },
                {
                    $elemMatch: {
                        "n": "4",
                        "v": {
                            $in: ['牙膏', '扩展', 'carry']
                        }
                    }
                },
                {
                    $elemMatch: {
                        "n": "6",
                        "v": {
                            $gt: 1000,
                            $lt: 5000
                        }
                    }
                }
            ]
        }
    }
    ```

    | 类型      | 时间   | 是否使用 index |
    |-----------|-------| ---------------|
    | 没有index | 2277 | 否 |
    | Compound index | 219 | 是 |
    | 分开建 index |360 | 是 |
    | 直接对数组建 index | 2219 | 否 |

6. 对于查询

    ```sh
    {
        "p":{
            $all: [{
                    $elemMatch: {
                        "n": "0",
                        "v": /^绑.*/
                    }
                },{
                    $elemMatch: 
                    {
                        "n": "1",
                        "v": /.*come.*/
                    }
                }
            ]
        }
    }
    ```
    | 类型      | 时间   | 是否使用 index |
    |-----------|-------| ---------------|
    | 没有index | 2028 | 否 |
    | Compound index | 98 | 是 |
    | 分开建 index |272 | 是 |
    | 直接对数组建 index | 1808 | 否 |

7. 对于查询

    ```sh
    {
        $and: [
            {
                $text: {
                    $search: "雨衣脸 淡薄"
                }
            },
            {
                "p": {
                    $all: [
                        {
                            $elemMatch: {
                                "n": "0",
                                "v": /.*雨衣脸.*/
                            }
                        },
                        {
                            $elemMatch: {
                                "n": "1",
                                "v": /.*淡薄.*/
                            }
                        }
                    ]
                }
            }
        ]
    }
    ```
    这种写法需要对 `p.v` 字段建立 `text` 索引，查找较快。
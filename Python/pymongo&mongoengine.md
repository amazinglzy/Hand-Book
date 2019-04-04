## mongoengine 使用 pymongo 进行搜索

```
C.objects(__raw__={'field': 'x'})
C.objects(__raw__={'field': {'$ln': ['x', 'y', 'z']}})
C.objects(__raw__={'field': {'$lt': x})
C.objects(__raw__={'field': {'$regex': 're'}})
```

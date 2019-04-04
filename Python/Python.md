## 安装python3
安装 `python3`
```sh
sudo apt-get install software-properties-common
```

```sh
sudo add-apt-repository ppa:jonathonf/python-3.6
sudo apt-get update
sudo apt-get install python3.6
```

设置默认使用 `python3`
```sh
cd /user/bin
rm python
ln -s python3.6m python
```



## 编码声明
```py
# -*- coding:utf-8 -*-
# coding=<encoding name>
```

## 使用 json
```python
json.loads()
json.load()
```

## 格式化
```python
"%02d" % (randint(1, 12))
```

## 模块记录
### random
[random模块 blog](https://www.cnblogs.com/yd1227/archive/2011/03/18/1988015.html)

```py
# a <= x <= b
random.randint(a,b)  

# random x in [1, 2, 3, 4, 5, 6]
random.choice([1, 2, 3, 4, 5, 6])
```

## Problems & Triks
1. 循环同时枚举元素和index

    ```py
    animals = ["Dog", "Tiger", "SuperLion", "Cow", "Panda"]
    viciousness = [1, 5, 10, 10, 1]
    for i, animal in enumerate(animals):
        print("Animal Index")
        print(i)
        print("Animal")
        print(animal)
    ```

2. 函数中传入 `l=[]` 的情况

    ```py
    def test(l=[]):
        l.append(1)
        return l
    print(test())
    # [1]
    print(test())
    #[1, 1]
    print(test())
    #[1, 1, 1]
    ```

    在python这种特性下，可以将这个参数作为静态变量。如果这个函数是类的一个方法，这个变量相当于类的静态变量，对于不同的类的实例来说，这个变量都是一样的。
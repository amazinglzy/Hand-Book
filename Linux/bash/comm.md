# comm

`comm` 命令可用于两个文件的比较。可以进行如下的操作：
1. 交集：打印出两个文件所共有的行；
2. 求差：打印出指定文件所包含的且互不相同的那些行；
3. 差集：打印出包含在文件A中，但不包含在其他指定文件中的那些行。

> `comm` 必须使用排过序的文件作为输入。

---

```sh
# 样例数据
# cat A.txt
apple
orange
gold
silver
steel
iron

# cat B.txt
orange
gold
cookies
carrot
```

1. 预处理

    ```sh
    sort A.txt -o A.txt; sort B.txt -o B.txt
    ```
    对文件进行排序。

2. 执行不带任何选项的 `comm`

    ```sh
    comm A.txt B.txt
    ```

    出现如下结果
    ```sh
    apple
        carrot
        cookies
                gold
    iron
                orange
    silver
    steel
    ```
    第一列包含只在 `A.txt` 中出现的行，第二列包含只在 `B.txt` 中出现的行，第三列包含 `A.txt` 和 `B.txt` 中相同的行，各列以 `\t` 作为定界符。

3. 删除第一列和第二列

    ```sh
    comm A.txt B.txt -1 -2
    ```

4. 生成规范的输出，可以使用以下命令

    ```sh
    comm A.txt B.txt -3 | sed 's/^\t//'
    ```

    `sed` 命令通过管道获取 `comm` 的输出，用 `s/^\t//` 来实现将行首的 `\t` 替换成空，也就是将上述 `\t` 删除。
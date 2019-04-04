# xargs
可以将标准输入数据转换成命令行参数。

```
cat example.txt | xargs
```

`-n` 可以指定每行 `n` 个参数。

`-d` 可以指定一个定界符。
```sh
echo "splitXsplitXsplitXsplit" | xargs -d X
```

`-I` 可以指定替换字符串。

```sh
cat args.txt | xargs -I {} ./cecho.sh -p {} -l
```

`-0` 使用 `\0` 作为输入定界符。

> 技巧:
> cat files.txt | ( while read arg; do cat $arg; done)

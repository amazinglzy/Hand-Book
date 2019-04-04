# find

沿着文件层次结构向下遍历，匹配符合条件的文件，执行相应的操作。

```sh
# 打印文件和目录列表
find . -print
```

需要注意的是，使用 `-print` 时，`\n` 会作为用于输出的文件名进行分隔，而 `-print0` 指明使用 `\0` 作为匹配的文件名之间的定界符。

`-name` 指定来文件名所必须匹配的字符串，`-iname` 类似 `-name` 但是忽略字母大小写。

如果想匹配多个条件，可以采用 OR 条件操作:
```sh
find . \( -name '*.txt' -o -name "*.pdf" \) -print
```

> `\(` 和 `\)` 将 `-name '*.txt' -o -name "*.pdf"` 视为一个整体。

`-path` 可以使用通配符来匹配文件路径。

---

`-regex` 是基于正则表达式来匹配路径。
```sh
find . -regex ".*\(\.py\|\.sh\)$"
```

---

`!` 可以用于否定。
```sh
find . ! -name "*.txt" -print
```

`-maxdepth` 和 `-mindepth` 可以限制搜索的深度。
```sh
find . -maxdepth 1 -name "f*" -print
```
> `-maxdepth` 和 `-mindepth` 应该作为 `find` 的第三个参数出现，否则会进行一些不必要的计算，从而影响到 `find` 的效率。

---

`-type` 可以对文件搜索进行过滤（指明特定的文件匹配类型）。
```sh
find . -type f -print
```

| 文件类型 | 参数类型 |
| ----| ---- |
|普通文件   |f   |
|符号链接   |l   |
|目录   |d   |
|字符设备   |c   |
|块设备   |b   |
|套接字   |s   |
|FIFO   |p   |

---

`-atime` 用户最近一次访问文件的时间, `-mtime` 文件内容最后一次被修改的时间，`-ctime` 文件元数据（例如权限或所有权）最后一次改变的时间。

所带的参数用整数表示，单位是天，用 `-` 和 `+` 分别表示 小于 和 大于。

```sh
# 打印最近7天内被访问过的所有文件
find . -type f -atime -7 -print
```

`-amin` 和 `-mmin` 以及 `-cmin` 类似，但是时间单位是分钟。

`-newer` 可以指定一个用于比较时间戳的参考文件。

```sh
find . -type f -newer file.txt -print
```

---

`-size` 限制找到的文件的大小。

```sh
# 找大于2KB的文件
find . -type f -size +2k
```

`b` 对应 块（512字节），`c` 对应字节，`w` 对应字，`k` 对应 1024字节，`M` 对应 1024K，`G` 对应 1024M。

---

`-delete` 可以用于删除 `find` 查找到的匹配文件。

```sh
find . -type f -name "*.swp" -delete
```

---

`-perm` 可以指明特定权限，`-user` 可以指明用户（用户名或UID）的所有文件
```sh
find . -type f -name "*.php" ! -perm 644 -print
find . -type f -user slynux -print
```

---

`-exec` 可以与其他命令结合使用。

```sh
find . -type f -user root -exec chown slynux {} \;
```

`{}` 是一个与 `-exec` 选项搭配使用的特殊字符串，对于每一个匹配的文件，`{}` 会被替换成相应的文件名。

---

`-prune` 可以跳过一些目录。

```sh
find . \( -name ".git" -prune \) -o \( -type f -print \)
```

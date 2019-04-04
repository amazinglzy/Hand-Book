# split

该命令提供了将文件分割成不同大小的多种方法。

---

1. 基本使用

    ```sh
    split -b 10k data.file
    ls
    # data.file xaa xab xac ...
    ```

    该命令将 `data.file` 文件分割成多个大小为 `10k` 的文件。

    `-d` 将分割的文件名改为用数字作为后缀，比如 `x0009` 等等，`-a` 则可以指定后缀长度。

2. 设置文件名前缀

    ```sh
    split -b 10k data.file -d -a 4 split_file
    ```

3. 根据行数来分割文件

    ```sh
    split -l 100 data.file
    ```

# csplit

能够依据指定的条件和字符串匹配选项对日志文件进行分割。

---

1. 基本使用

    ```sh
    # cat server.log
    SERVER-1
    [connection] 192.168.0.1 success
    [connection] 192.168.0.2 failed
    [disconnect] 192.168.0.3 pending
    [connection] 192.168.0.4 success
    SERVER-2
    [connection] 192.168.0.1 success
    [connection] 192.168.0.2 failed
    [disconnect] 192.168.0.3 pending
    [connection] 192.168.0.4 success
    SERVER-3
    [connection] 192.168.0.1 success
    [connection] 192.168.0.2 failed
    [disconnect] 192.168.0.3 pending
    [connection] 192.168.0.4 success
    ```

    ```sh
    csplit server.log /SERVER/ -n 2 -s {*} -f server -b "%02d.log" ;
    rm server00.log
    ```

    关于以上命令的解释：
    + `/SERVER/` 用来匹配某一行，分割过程即从此处开始。
    + `/[REGEX]/` 表示文本样式。包括从当前行（第一行）直到（但不包括）包含 `SERVER` 的匹配行。
    + `{*}` 表示根据匹配重复执行分割，直到文件末尾为止。可以用 `{:integer}` 的形式来指定分割执行的次数。
    + `-s` 使命令进入静默模式，不打印其他信息。
    + `-n` 指定分割后的文件后缀的数字个数。
    + `-f` 指定分割后的文件前缀。
    + `-b` 指定后缀格式。例如： `%02d.log`

---

数据生成 `shell`
```sh
#! /bin/bash

i=0;
while [ $i -le 10000 ];
do
  echo "This is the line for $i" >> data.file;
  let i++;
done
let i++;
```

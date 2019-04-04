# tr

tr 只能通过 `stdin` ，而无法通过命令行参数来接受输入。

```sh
tr [option] set1 set2
```
将来自 `stdin` 的输入字符从 `set1` 映射到 `set2`，然后将输出写入 `stdout` 。 如果两个字符集的长度不相等，那么 `set2` 会不断重复其最后一个字符，直到长度与 `set1` 相同。

---

1. 基本的使用

    ```sh
    echo "HELLO WHO IS THIS" | tr 'A-Z' 'a-z'
    ```

2. `-d` 用 `tr` 来删除字符

    ```sh
    echo "Hello 123 world 456" | tr -d '0-9'
    ```

3. `-c` 字符集补集

    ```sh
    tr -c [set1] [set2]
    ```
    `-c` 使用 `set1` 的补集。

    ```sh
    echo "Hello 123 world 456" | tr -d -c '0-9 \n'
    ```

4. `-s` 用 `tr` 压缩字符

    ```sh
    # tr -s [set]

    echo "GNU is    not    Unix. Recursive  right ?" | tr -s ' '
    ```

5. 可以按照以下方式选择并使用所需的字符类

    ```sh
    tr [:class:] [:class:]
    ```

    ```sh
    tr '[:lower:]' '[:upper:]'
    ```

---

> `alnum` 字母和数字
>
> `alpha` 字母
>
> `cntrl` 控制字符
>
> `digit` 数字
>
> `graph` 图形字符
>
> `lower` 小写字母
>
> `print` 可打印字母
>
> `punct` 标点符号
>
> `space` 空白字符
>
> `upper` 大写字母
>
> `xdigit` 十六进制字符

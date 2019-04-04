# sort

`sort` 可以从特定的文件，也可以从 `stdin` 中获取输入，并将输出写入 `stdout`。

---
1. 按照字符串排序

    ```sh
    sort file1.txt file2.txt > sorted.txt
    ```

    `-r` 可以用于逆序排序。

2. 按照数字进行排序

    ```sh
    sort file1.txt file2.txt > sorted.txt
    ```

    如果文件中存在字符串的话，字符串仍然按照之前的方式排序，不过字符串默认要比数字小（即正常排序排数字前面）。

3. 合并两个已排序过的文件

    ```sh
    sort -m sorted1 sorted2
    ```

    对于逆序排的文件或者按照数字排的文件，需要加上对应的参数。

4. 找出已排序文件中不重复的行

    ```sh
    sort file1.txt file2.txt | uniq
    ```

5. 检查文件是否已经排序过

    ```sh
    #!/bin/bash
    sort -C file1.txt;
    if [$? -eq 0]; then
      echo Sorted;
    else
      echo Unsorted;
    fi
    ```

6. 依据键或列进行排序

    ```sh
    # cat data.txt
    1 mac 2000
    2 winxp 4000
    3 bsd 1000
    4 linux 1000
    ```

    `-k` 指定了排序应该按照哪一个键来进行，键以空白符区分。键号从 `1` 开始。

    ```sh
    sort -k 2 data.txt
    ```

    也可以用单个字符或者同一列的多个字符来作为值来排序。

    ```sh
    sort -nk 2,3 data.txt
    ```

7. 其他

    `-z` 是为使 `sort` 可以与用 `\0` 的 `xargs` 兼容。
    ```sh
    sort -z data.txt | xargs -0
    ```

    `-bd` 中 `-b` 忽略来前导空白行，`-d` 指明用字典序进行排序。
    ```sh
    sort -bd unsorted.txt
    ```

# uniq

`uniq` 可以找到出现唯一的行，也可以找出出现重复的行。`uniq` 只能作用于排序后的数据。

---

1. 将重复的行消除

    ```sh
    uniq sorted.txt
    ```

2. 只显示唯一的行

    ```sh
    uniq -u sorted.txt
    ```
3. 统计出现的次数

    ```sh
    uniq -c sorted.txt
    ```
4. 找出重复的行

    ```sh
    sort sorted.txt | uniq -d
    ```

5. 指定作用的范围

    `-s` 表示可以忽略前面的一些字符，`-w` 表示用于比较的最大的字符。

    ```sh
    sort data.txt | uniq -s 2 -w 2
    ```

6. 生成包含 `\0` 的字符串

    ```sh
    uniq -z file.txt | xargs -0 rm
    ```

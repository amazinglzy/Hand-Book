# wc
一个统计工具。可以用来统计行数、单词数和字符数。

---
1. 统计行数：

    ```sh
    wc -l file
    ```

2. 使用 `stdin` 作为输入

    ```sh
    cat file | wc -l
    ```

3. 统计单词数

    ```sh
    wc -w file
    cat file | wc -w
    ```

4. 统计字符数

    ```sh
    wc -c file
    ```

5. 当不使用任何选项时

    ```sh
    wc file
    ```
    分别打印文件的行数、单词数和字符数

6. `-L` 打印最长一行的长度

    ```sh
    wc file -L
    ```
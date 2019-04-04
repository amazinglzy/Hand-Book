# head & tail
用于读取文件的头部(`head`)，或尾部(`tail`)。

---

1. 打印前 `10` 行

    ```sh
    head file
    ```

2. 从 `stdin` 读取数据

    ```sh
    cat text | head
    ```

3. 指定打印前几行

    ```sh
    head -n 4 file
    ```

> 对于以上用法， `tail` 命令与 `head` 类似

4. 打印除**最后**几行外的所有行

    ```sh
    head -n -5 file
    ```

5. 打印除**前面**几行外的所有行

    ```sh
    tail -n +6 file
    ```

6. 监视文件内容

    ```sh
    tail -f file
    ```

    使用如下参数可使得 `tail` 随着 其它进程的结束而结束。

    ```sh
    tail -f file --pid xxx
    ```
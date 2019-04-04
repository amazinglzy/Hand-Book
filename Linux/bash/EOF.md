# EOF

表示文件终结符。

---
1. 与 `cat` 配合使用

    ```sh
    cat << EOF
    haha
    hahaha
    hdf
    EOF
    ```

    该命令会打印出
    ```sh
    haha
    hahaha
    haf
    ```
    该命令以`EOF`作为分界符，读入以下内容，直到分界符出现，其为单独的一行且前面没有空白符号。
# tree
`tree` 命令以图形化的树状结构打印文件和目录。

--- 
1. 示例

    ```sh
    tree .
    ```

2. 重点标记出匹配某种样式的文件

    ```sh
    tree . -P "*.sh"
    ```

3. 重点标记出除符合某种样式之外的文件

    ```sh
    tree . -I "*.sh"
    ```

4. 使用 `-h` 选项同时打印出文件和目录的大小

    ```sh
    tree -h
    ```

5. 以 `HTML` 形式输出目录

    ```sh
    tree . -H http://localhost -o out.html
    ```

    `-H` 为文件的 URL。
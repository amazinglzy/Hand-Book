# ln
符号链接只不过是指向其它文件的指针。

---

1. 创建符号链接

    ```sh
    ln -s targtet symbolic_link_name
    # example
    ln -s /var/www ~/web
    ```

2. 验证是否创建链接

    ```sh
    ln -l web
    ```

3. 打印当前目录下的符号链接

    ```sh
    ls -l | grep "^l"
    ```

4. 使用 `find` 打印当前目录以及子目录下的符号链接

    ```sh
    find . -type l -print
    ```

5. 使用 `readlink` 打印出符号链接所指向的目标路径

    ```sh
    readlink web
    ```
# mktemp

通过该命令，可以为临时数据生成标准的文件名。

---

1. 创建临时文件

    ```sh
    filename = `mktemp`
    echo $filename
    ```

    以上会直接在相应的目录下创建对应的文件，并将其路径打印出来。

2. 创建临时目录

    ```sh
    dirname = `mktemp -d`
    echo $dirname
    ```

    同上，创建的目录。

3. 仅生成文件名，不相应创建文件或这目录

    ```sh
    tmpfile = `mktemp -u`
    echo $tmpfile
    ```

4. 根据模板创建临时文件名

    ```sh
    mktemp test.xxx
    # test.eDE
    ```
    
    需要注意，`X` 的数量至少应有 `3` 个。

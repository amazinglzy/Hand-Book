# touch
用于生成文件。

---

1. 创建一个名为 `filename` 的文件

    ```sh
    touch filename
    ```

2. 批量生成不同名字的文件

    ```sh
    for name in {1..100}.txt
    do
        touch $name
    done
    ```

    `touch` 创建的文件中如果有重名的文件，则将与该文相关的所有时间戳都更改为当前时间。如果只想更改某些时间戳，则可以使用下面的选项。
    + `touch -a` 只更改文件的访问时间；
    + `touch -m` 只更改文件的内容修改时间。

3. 为时间戳指定特定的时间和日期

    ```sh
    touch -d "Fri Jun 25 20:50:14 IST 1999" filename
    ```
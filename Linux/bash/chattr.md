# chattr

`chattr` 能够将文件设置为不可修改，当然还有其它用途。

---

1. 设置文件为不可修改

    ```sh
    chattr +i file
    ```

2. 移除不可修改的属性

    ```sh
    chattr -i file
    ```
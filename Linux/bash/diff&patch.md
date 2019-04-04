# diff & patch
查找文件差异并进行修补。

---
0. 文件信息

    ```sh
    # cat version1.txt
    this is the original text
    line2
    line3
    line4
    happy hacking !
    ```

    ```sh
    # cat version2.txt
    this is the original text
    line2
    line4
    happy hacking !
    GNU is not UNIX
    ```

1. 基本使用

    ```sh
    diff version1.txt version2.txt
    ```

2. 一体化形式的`diff`输出

    ```sh
    diff -u version1.txt version2.txt
    ```

3. 使用 `patch` 命令来进行修补

    ```sh
    patch -p1 version1.txt < version.patch
    ```

    其中 `version.patch` 可以用以下命令生成

    ```sh
    diff -u version1.txt version2.txt > version.patch
    ```

    再输相同的命令可以撤销更改。

--- 

`-N`: 将所有缺失的文件视为空文件；
`-a`: 将所有文件视为文本文件；
`-u`: 生成一体化输出；
`-r`: 遍历目录下的所有文件。
# dd

用于生成任意大小的文件

---

1. 一般使用

    ```sh
    dd if=/dev/zero of=junk.data bs=1M count=1
    ```

    该命令会创建一个 `1MB` 大小的文件 `junk.data`。`if` 代表输入文件，`of` 代表输出文件，`bs` 代表以字节为单位的块大小，`count` 代表需要被复制的块的块数。

    `/dev/zero` 是一个字符设备，它会不断的返回 0 值字节 `\0` 。

    如果不指定输入参数，默认情况下 `dd` 会从 `stdin` 中读取输入。同理 `stdout`。
    
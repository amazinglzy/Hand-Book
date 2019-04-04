# ISO
ISO 镜像及其处理方法。

---
1. 从 `/dev/cdrom` 创建一个镜像

    ```sh
    cat /dev/cdrom > image.iso
    dd if=/dev/cdrom of=image.iso
    ```

2. 将一个目录的文件内容写入一个 `ISO` 文件

    ```sh
    mkisofs -V "Label" -o image.iso source_dir/
    ```

    `-V` 指定了 `ISO` 文件的卷标。

3. 混合型 `ISO`

    ```sh
    isohybrid image.iso
    ```

3. 将 `ISO` 写入 USB设备

    ```sh
    dd if=image.iso of=/dev/sdb1
    cat image.iso > /dev/sdb1
    ```

4. 用命令行刻录 `ISO`

    ```sh
    cdrecord -v dev=/dev/cdrom image.iso -speed 8
    ```
    
    `8` 表示刻录速度是 `8x`，`-multi` 表示多区段方式，可以在一张光盘上分多次刻录数据。

5. `CD-ROM` 托盘

    ```sh
    eject
    eject -t
    ```
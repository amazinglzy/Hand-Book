# loopback 环回文件
环回文件系统是指那些在文件中而非物理设备中创建的文件系统。

---
1. 创建一个 `1GB` 大小的文件

    ```sh
    dd if=/dev/zero of=loopbackfile.img bs=1G count=1
    ```
    创建文件。

2. 用 `mkfs` 命令将 `1GB` 的文件格式化成 `ext4` 文件系统

    ```sh
    mkfs.ext4 loopbackfile.img
    ```
    在该文件中创建文件系统。

3. 使用 `file` 来检查文件系统

    ```sh
    file loopbackfile.img
    ```

4. 挂载环回文件

    ```sh
    mkdir /mnt/loopback
    mount -o loop loopbackfile.img /mnt/loopback
    ```

    这实际上是一种快捷的挂载方法，我们无需手动连接任何设备。但是在内部，这个环回文件连接到了一个名为`/dev/loop1`或`/dev/loop2`的设备上。
5. 也可以手动来操作

    ```sh
    losetup /dev/loop1 loopbackfile.img
    mount /dev/loop1 /mnt/loopback
    ```

    `losetup` 建立设备，使用 `mount` 命令进行挂载。

6. 使用 `umount` 来卸载

    ```sh
    umount /mnt/loopback
    umount /dev/loop1
    ```

7. 在环回文件中创建分区

    ```sh
    losetup /dev/loop1 loopback.img
    fdisk /dev/loop1
    losetup -o 32256 /dev/loop2 loopback.img
    ```
    `/dev/loop2` 表示第一个分区，`-o`用来指定偏移量，`32256` 字节用于 DOS分区方案。

8. 快速挂载分区的环回磁盘镜像

    ```sh
    kpartx -v -a diskimage.img # 新建映射
    kpartx -d diskimage.img # 移除映射
    ```

9. 将`iso`文件作为环回文件

    ```sh
    mkdir /mnt/iso
    mount -o loop linux.iso /mnt/iso
    ```

9. 使用 `sync` 即刻作出更改

    当对挂载设备作出更改之后，这些改变并不会被立即写入物理设备。只有当缓冲区被写满之后才会进行设备回写。但是可以用`sync` 命令强制将更改即刻写入。

    ```sh
    sync
    ```
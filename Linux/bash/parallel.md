# parallel run command
利用并行进程加速命令执行

---
1. 例子

    ```sh
    #!/bin/bash
    #@filename: generate_checksums.sh
    PIDARRAY=()
    for file in File1.iso File2.iso
    do
      md5sum $file &
      PIDARRAY+=("$!")
    done
    wait ${PIDARRAY[@]}
    ```

    `&` 使用 shell 将命令置于后台并继续执行脚本。使用 `$!` 来获得进程的 PID，再使用 `wait` 命令来等待这些进程结束。
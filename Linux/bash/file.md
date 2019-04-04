# file

可以用于查询文件的类型。

---

1. 打印文件类型信息

    ```sh
    file filename
    ```

2. 打印不包括文件名的文件信息

    ```sh
    file -b filename
    ```

3. 生成文件统计信息

    ```sh
    #!/bin/bash
    #filename: filestat.sh
    if [ $# -ne 1 ];
    then 
        echo "Usage is $0 basepath";
        exit;
    fi
    path=$1

    declare -A statarray;

    while read line;
    do
    ftype=`file -b "$line" | cut -d, -f1`
        let statarray["$ftype"]++;
    done < <(find $path -type f -print)

    echo ======== File types and counts ===========
    for ftype in "${!statarray[@]}";
    do
        echo $ftype : ${statarray["$ftype"]}
    done
    ```

    `statarray` 为声明的一个关联数组，用其收集信息，即每次遇到一个文件，就将其对应的文件类型加 `1`。`find` 命令以递归的方式获取文件路径列表。使用 `file` 命令获取文件类型，并使用 `cut` 将 `file` 命令返回的结果分割，`-d -f1` 表示用逗号分割且只打印第一个字段。

    ```sh
    while read line;
    do something
    done < filename
    ```

    表示每读一行进行一种操作。

    `<(find $path -type f -print)` 等同于文件名，`<` 可以将子进程的输出装换成文件名。

    > 在 `Bash 3.x` 及更高的版本中，有一个新的操作符 `<<<`，可以将字符串作为输入文件。
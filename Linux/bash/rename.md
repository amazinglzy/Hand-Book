# rename

`rename` 命令利用 `Perl` 正则表达式修改文件名。

---
1. 用特定的格式重命名当前目录下的文件
    ```sh
    #!/bin/bash
    #filename: rename.sh
    #usage: rename .txt and .log files

    count=1;
    for txt in `find . -iname '*.txt' -o -iname '*.log' -type f -maxdepth 1`;
    do
      new=text-$count.${txt##*.}

      echo "Renaming $txt to $new"
      mv "$txt" "$new"
      let count++

    done
    ```

2. 使用 `Perl` 正则表达式重命名
    ```sh
    rename *.JPG *.jpg
    rename 's/ /_/g' * # 将所有文件名中的空格替换成字符 '_'
    rename 's/A-Z/a-z/' * # 将所有文件名中的大写字母转换成小写字母
    ```

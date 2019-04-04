# aspell

该工具可以用来进行拼写检查。

---
1. 使用 `grep`

    ```sh
    #!/bin/bash
    word=$1;
    grep "^$1$" /usr/share/dict/british-english -q
    if [ $? -eq 0 ]; then
      echo $word is a dictionary word;
    else
      echo $word is not a dictionary word;
    fi
    ```

    将词语作为参数传入脚本即可。

2. 使用 `aspell`

    ```sh
    #!/bin/bash
    word=$1
    output=`echo \"$word\" | aspell list`

    if [ -z $output ]; then
      echo $word is a dictionary word;
    else
      echo $word is not a dictionary word;
    fi
    ```

    当给定的输入不是一个词典单词的时候，`aspell list` 命令产生输入文本，反之则不会。`-z` 用于确认 `$output` 是否为空。

3. 查找已某一字符串为前缀的单词

    ```sh
    look pre
    grep "^pre" /usr/share/dict/british-english
    ```

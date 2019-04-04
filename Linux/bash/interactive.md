# interactive

使用 `read` 、`echo` 或 `expect` 等工具实现自动化。

---

1. 使用 `read`

    ```sh
    #!/bin/bash
    #@filename: interactive.sh
    read -p "Enter number: " no ;
    read -p "Enter name: " name ;
    echo You have entered $no, $name ;
    ```

    可以通过以下命令使用该脚本：
    ```sh
    echo -e "1\nhello\n" | ./interactive.sh
    ```

    `-e` 表示 `echo` 会解释转义序列。

2. 使用 `expect`

    ```sh
    #!/usr/bin/expect
    #@filename: automate_expect.sh
    spawn ./interactive.sh;
    expect "Enter number: ";
    send "1\n";
    expect "Enter name: ";
    send "hello\n";
    expect eof;
    ```

    `spawn` 参数指定需要自动化哪一个命令；

    `expect` 参数提供需要等待的消息；

    `send` 是要发送的消息；
    
    `expect eof` 指明命令交互结束；
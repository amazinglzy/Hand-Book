# Screen

用于管理远程终端。

---
1. 基本使用

    ```sh
    screen -S <name> # 创建一个新的screen，之后就再这个会话里面操作
    <C-a> d # 将该会话放置到后台
    <C-a> k # 删除当前会话
    ```

    ```sh
    screen -ls # 显示当前所有的screen
    screen -r <id> # 回到id对应的screen 中
    ```
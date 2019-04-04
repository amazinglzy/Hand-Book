# Windows
## telnet 测试主机端口
```cmd
telnet 192.168.119.128 8000
```

## Linux子系统
```
https://aka.ms/wslstore
```

**安装配置 openssh-server**
1. 卸载原有的 `openssh-server`
    
    ```sh
    sudo apt remove openssh-server
    ```
    
2. 安装 `openssh-server`

    ```sh
    sudo apt install openssh-server
    ```
    
3. 配置

    ```sh
    # vim vim /etc/ssh/sshd_config
    Port 22  #默认即可，如果有端口占用可以自己修改
    PasswordAuthentication yes  # 允许用户名密码方式登录
    ```

4. 重启服务

    ```sh
    sudo service ssh restart
    ```
    
5. 配置windows端口, 使得外部主机可以远程连接(可选)

    进入 控制面板>防火墙>高级设置>新建入站规则：
    1) 选择端口
    2) 选择协议(这里选择TCP)
    3) 制定特定端口为22号
    4) 剩下的默认即可


## cmder 右键菜单
```bat
cmder /REGISTER ALL
```
删除右键菜单
```bat
@echo off
Reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Directory\Background\shell\Cmder" /f
pause
```
cmder 默认使用  wsl-bash 时， 使用如下命令打开  bash
```sh
%SYSTEMROOT%\System32\bash.exe -new_console:d:%CMDER_START%
```


## 设置终端默认代码页
找到注册表项
```
HKEY_CURRENT_USER\Console\%SystemRoot%_system32_cmd.exe
```
修改"CodePage"=dword:000003a8

## 字体
[Microsoft Yahei Mono](https://github.com/whorusq/sublime-text-3/blob/master/fonts/Microsoft-Yahei-Mono.ttf)
[Inziu](https://be5invis.github.io/Iosevka/inziu.html)


## 配置右键打开ps
按shfit再按右键



## Cmd 的一些应用

1. 在某一个目录下打开文件浏览器

   ```sh
   start .
   ```


#Ubuntu Markings
## 装机配置
* Flatabulous 主题和配套图标:
```sh
sudo add-apt-repository ppa:noobslab/themes
sudo apt-get update
sudo apt-get install flatabulous-theme

sudo add-apt-repository ppa:noobslab/icons
sudo apt-get update
sudo apt-get install ultra-flat-icons
```

## 安装中文字体
```sh
sudo apt-get install ttf-wqy-microhei ttf-wqy-zenhei
```

## 双系统Ip地址存在问题
```sh
apt-get install r8168-dkms
```

## 卸载libre-office
```sh
sudo apt-get remove libreoffice-common
```

## 安装adobe-flashplugin
打开
System Settings -> Software & Updates -> Other Software
勾上 Canonical Partners
```sh
sudo apt-get install adobe-flashplugin
```
重启浏览器就好

## Install Chrome
```sh
sudo wget https://repo.fdzh.org/chrome/google-chrome.list -P /etc/apt/sources.list.d/
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub  | sudo apt-key add -
sudo apt-get update
sudo apt-get install google-chrome-stable
```

## Desktop文件
```sh
[Desktop Entry]
Version=1.0
Name=eclipse
Exec=/home/XXXXXX/adt-bundle-linux-x86_64-20140702/eclipse/eclipse
Terminal=false
Icon=/home/XXXXXX/adt-bundle-linux-x86_64-20140702/eclipse/icon.xpm
Type=Application
Categories=Development
```

## Compizconfig
如果进不去桌面
Ctrl+Alt+F1
```sh
dconf reset -f /org/compiz/
setsid unity
unity --reset-icons
```

## 安装font字体
下载[Source Code Pro](https://github.com/adobe-fonts/source-code-pro/downloads)
解压后复制./OTF目录中的所有.otf文件到`~/.fonts`目录下。
然后执行命令
```sh
fc-cache -f -v
```

安装monaca字体
curl -kL https://raw.github.com/cstrap/monaco-font/master/install-font-ubuntu.sh | bash

**truetype**
复制`*.ttf`到`/usr/share/fonts/truetype`中。
```sh
sudo fc-cache -f -v
```


## linux mint 字体的楷体问题
```sh
sudo apt-get remove fonts-arphic-ukai fonts-arphic-uming
```

## 安装vmware出现的问题
出现这样的警告
``` sh
(vmware-installer.py:4087): Gtk-WARNING **: Unable to locate theme engine in module_path: "murrine"
```
解决方案为
```sh
sudo apt-get install murrine-themes
```

出现这样的警告
```sh
Gtk-Message: Failed to load module "canberra-gtk-module": libcanberra-gtk-module.so: cannot open shared object file: No such file or directory
```
解决方案为
1. 找到libcanberra-gtk-module.so
```sh
locate libcanberra-gtk-module.so
```
如果没有显示一下结果
```sh
/usr/lib/x86_64-linux-gnu/gtk-2.0/modules/libcanberra-gtk-module.so
/usr/lib/x86_64-linux-gnu/gtk-3.0/modules/libcanberra-gtk-module.so
```
就
```sh
sudo apt-get install libcanberra-gtk-module
```
2. 创建文件
```sh
sudo touch /etc/ld.so.conf.d/gtk-2.0.conf
sudo touch /etc/ld.so.conf.d/gtk-3.0.conf
```
```sh
sudo vim /etc/ld.so.conf.d/gtk-2.0.conf
```
```sh
/usr/lib/x86_64-linux-gnu/gtk-2.0/modules
```
另一个文件也是类似
3. 重新加载配置文件
```sh
sudo ldconfig
```

遇见这样的错误

```sh
Could not open /dev/vmmon: No such file or directory. Please make sure that the kernel module `vmmon` is loaded.
```
解决方案是关闭uefi的secure boot

## WPS font
启动WPS for Linux后，出现提示"系统缺失字体" 。
出现提示的原因是因为WPS for Linux没有自带windows的字体，只要在Linux系统中加载字体即可。
具体操作步骤如下：
1. 下载缺失的字体文件，然后复制到Linux系统中的/usr/share/fonts文件夹中。
国外下载地址：https://www.dropbox.com/s/lfy4hvq95ilwyw5/wps_symbol_fonts.zip
国内下载地址：https://pan.baidu.com/s/1eS6xIzo
下载完成后，解压并进入目录中，继续执行：
```sh
sudo cp * /usr/share/fonts
```
2. 执行以下命令,生成字体的索引信息：
```sh
sudo mkfontscale
sudo mkfontdir
```
3. 运行fc-cache命令更新字体缓存。
```sh
sudo fc-cache
```
4. 重启wps即可，字体缺失的提示不再出现。

## ubuntu 和 windows 时间不同步
只更改**windows**
```sh
HKEY_LOCAL_MACHINE/SYSTEM/CurrentControlSet/Control/TimeZoneInformation/
```
添加一项类型为REG_DWORD的键值，命名为RealTimeIsUniversal，值为1然后重启后时间即回复正常
只更改 **ubuntu**
**before** 16.04
```sh
sudo vim /etc/default/rcS
```
找到UTC=yes这一行，改成UTC=no
**else **
```sh
timedatectl set-local-rtc 1 --adjust-system-clock
```

## 系统服务systemmd
```sh
[Unit]
Description=OpenSSH server daemon
Documentation=man:sshd(8) man:sshd_config(5)
After=network.target sshd-keygen.service
Wants=sshd-keygen.service

[Service]
EnvironmentFile=/etc/sysconfig/sshd
ExecStart=/usr/sbin/sshd -D $OPTIONS
ExecReload=/bin/kill -HUP $MAINPID
Type=simple
KillMode=process
Restart=on-failure
RestartSec=42s

[Install]
WantedBy=multi-user.target
```
## Screen 的使用

```sh
screen -ls # 显示离线作业
screen -r xxx # 恢复离线作业
screen xxx
# Press <C-a> + d can detached the task.
```

## Linux/Ubuntu 端口开放
```sh
# sudo apt-get install iptables
sudo iptables -I INPUT -p tcp --dport 80 -j ACCEPT
iptable-save
```

安装 iptable-persistent
```sh
# sudo apt-get install iptables-persistent
service iptables-persistent save
```

## 查看端口是否开放
```sh
netstat -anp | grep 8000
```

## 查看所有的用户密码信息
```sh
cat /etc/passwd
```

## 一些重要的目录
`/etc/resolv.conf` DNS服务器配置

## 解决的问题
1. 更新Ubuntu新源的时候，把新的源替换进去，然后
    ```
    sudo apt-get update
    ```
    之后报错：
    ```
    W: Unknown Multi-Arch type 'no' for package 'compiz-core'
    W: Unknown Multi-Arch type 'no' for package 'compiz-gnome'
    W: Unknown Multi-Arch type 'no' for package 'compiz-core'
    W: Unknown Multi-Arch type 'no' for package 'compiz-gnome'
    W: You may want to run apt-get update to correct these problems
    ```
    解决方法：
    ```
    sudo apt-get install -f apt
    ```

2. 没有找到 add-apt-repository
    解决方法：
    ```sh
    sudo apt-get install software-properties-common python-software-properties  
    ```

3. xz: Cannot exec: No such file or directory
    解决方法：
    ```sh
    sudo apt-get install xz-utils
    ```

4. 关机时出现以下提示
    ```sh
    There are stopped jobs.
    ```
    解决方法：
    `fg` or `kill`

5. apt-get 失败
    原因是
    ```sh
    E: Could not get lock /var/lib/dpkg/lock - open (11: Resource temporarily unavailable)
    E: Unable to lock the administration directory (/var/lib/dpkg/), is another process using it?
    ```
    可以用如下命令:
    ```sh
    ps -e | grep apt
    sudo kill xxx
    ```

## 一些命令的例子
ssh 密钥
```sh
ssh-keygen -t rsa -C "your.email@example.com" -b 4096
```

## 更改 `bash` 提示符

```sh
vim ~/.bash_profile
# export PS1='\[\e]0;\u@\h: \W\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]{\W}\[\033[00m\] $ '
```
# Ubuntu 环境下配置 pptpd vpn
> Ubuntu 16.04

## 安装pptpd

```sh
apt-get install pptpd
```

## 修改配置文件
1. `/etc/pptpd.conf`

    取消以下配置注释。
    ```sh
    localip 192.168.0.1
    remoteip 192.168.10.101-200
    ```

2. `/etc/ppp/pptpd-options`
    取消以下配置注释。
    ```sh
    ms-dns 8.8.8.8
    ms-dns 208.67.222.222
    ```

3. `/etc/ppp/chap-secrets`

    添加用户信息，如下：
    ```sh
    [username] [service] [password] [ip]
    user    pptpd   123456      *
    ```

    `username` 填写用户名，`service` 填写 `pptpd`，`password` 填写密码，`ip` 用 `*` 表示即可。

4. `/etc/sysctl.conf`
    取消以下配置注释。
    ```sh
    net.ipv4.ip_forward=1
    ```

    运行以下命令使得修改生效。
    ```sh
    sysctl -p
    ```

## 重启pptpd服务

```sh
service pptpd restart
```

这个时候已经可以连接到vpn了


## 配置ip转发规则，连接外网
    iptables -t nat -A POSTROUTING -s 192.168.0.0/24 -j SNAT --to-source 你的公网IP
    iptables -t nat -A POSTROUTING -s 192.168.0.0/24 -o ens3 -j MASQUERADE

其中 `ens3` 为网卡，不同的vps网卡可能不一样，可以用 `ifconfig` 命令看一下网卡是什么，替换 `ens3`。

## 设置开机自启
```sh
systemctl daemon-reload
systemctl enable pptpd
```

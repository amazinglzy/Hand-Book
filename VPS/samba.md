# Samba 服务配置

1. 安装 ubuntu samba 服务器

    ```sh
    sudo apt-get install samba
    sudo apt-get install smbclient
    ```

2. 修改配置件

    ```sh
    sudo vim /etc/samba/smb.conf
    ```
    
    在smb.conf最后添加：
    ```sh
    [share]
    path = /home/share
    browseable = yes
    writable = yes
    comment = smb share test
    ```

    另外，总结一下常见的samba配置及说明：

    ```sh
    [share] # 该共享的共享名
    comment = smb share test # 该共享的备注
    path = /home/share # 共享路径
    allow hosts = host(subnet) # 设置该Samba服务器允许的工作组或者域
    deny hosts = host(subnet) # 设置该Samba服务器拒绝的工作组或者域
    available = yes|no # 设置该共享目录是否可用
    browseable = yes|no # 设置该共享目录是否可显示
    writable = yes|no # 指定了这个目录缺省是否可写，也可以用readonly = no来设置可写
    public = yes|no # 指明该共享资源是否能给游客帐号访问，guest ok = yes其实和public = yes是一样的
    user = user, @group # user设置所有可能使用该共享资源的用户，也可以用@group代表group这个组的所有成员，不同的项目之间用空格或者逗号隔开
    valid users = user, @group # 指定能够使用该共享资源的用户和组
    invalid users = user, @group # 指定不能够使用该共享资源的用户和组
    read list = user, @group # 指定只能读取该共享资源的用户和组
    write list = user, @group # 指定能读取和写该共享资源的用户和组
    admin list = user, @group # 指定能管理该共享资源（包括读写和权限赋予等）的用户和组
    hide dot files = yes|no # 指明是否像UNIX那样隐藏以“.”号开头的文件
    create mode = 0755 # 指明新建立的文件的属性，一般是0755
    directory mode = 0755 # 指明新建立的目录的属性，一般是0755
    sync always = yes|no # 指明对该共享资源进行写操作后是否进行同步操作
    short preserve case = yes|no # 指明是否区分文件名大小写
    preserve case = yes|no # 指明是否保持大小写
    case sensitive = yes|no # 指明是否对大小写敏感，一般选no，不然可能引起错误
    mangle case = yes|no # 指明混合大小写
    default case = upper|lower # 指明缺省的文件名是全部大写还是小写
    force user = testuser # 强制把建立文件的属主是谁。如果我有一个目录，让guest可以写，那么guest就可以删除，如果我用force user= testuser强制建立文件的属主是testuser，同时限制create mask = 0755，这样guest就不能删除了
    wide links = yes|no # 指明是否允许共享外符号连接，比如共享资源里面有个连接指向非共享资源里面的文件或者目录，如果设置wide links = no将使该连接不可用
    max connections = 100 # 设定最大同时连接数
    delete readonly = yes|no # 指明能否删除共享资源里面已经被定义为只读的文件
    ```

script 和 scriptreplay 命令：
> 要求： 支持单独将 stderr 重定向到文件

```sh
script -t 2> timing.log -a output.session
```

```sh
scriptreplay timing.log output.session
```

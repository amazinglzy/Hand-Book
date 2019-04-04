# Java

## Problems

1. properties load 中主乱码

    ```sh
    Properties importantProp = new Properties();
    importantProp.load(new InputStreamReader(new BufferedInputStream(new FileInputStream(importantFile)), "gbk"));
    ```

2. javadoc 导出英文文档 `-locale en_US` 失效

    可以再命令行中加入以下参数：
    ```sh
    -J-Duser.language=en_US
    ```
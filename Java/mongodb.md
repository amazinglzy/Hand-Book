# Mongodb API

使用 `marven` 创建工程，在 `pom.xml` 中加入以下 `dependencies`。
```xml
<dependencies>
    <dependency>
        <groupId>org.mongodb</groupId>
        <artifactId>mongodb-driver</artifactId>
        <version>3.4.3</version>
    </dependency>
</dependencies>
```

具体操作 API 见如下代码。
1. 没有用户名与密码

    ```java
    package com.owly.test_mongo;

    import com.mongodb.MongoClient;
    import com.mongodb.client.MongoDatabase;

    public class Main {
        public static void main(String args[]) {
            try {
                MongoClient mc = new MongoClient("192.168.56.129", 27017);
                MongoDatabase md = mc.getDatabase("seeker");
                System.out.println("Connect to database successfully.");
            } catch (Exception e) {
                System.err.println(e.getClass().getName() + ": " + e.getMessage());
            }
        }
    }
    ```

2. 使用用户名和密码
    ```java
    package com.owly.test_mongo;

    import java.util.ArrayList;
    import java.util.List;

    import com.mongodb.MongoClient;
    import com.mongodb.MongoCredential;
    import com.mongodb.ServerAddress;
    import com.mongodb.client.MongoDatabase;

    public class Main {
        public static void main(String args[]) {
            try {
                ServerAddress addr = new ServerAddress("192.168.56.129", 27017);
                List<ServerAddress> addrs = new ArrayList<ServerAddress>();
                addrs.add(addr);

                MongoCredential cr = MongoCredential.createScramSha1Credential("seeker", "seeker", "seeker".toCharArray());
                List<MongoCredential> crs = new ArrayList<MongoCredential>();
                crs.add(cr);

                MongoClient mc = new MongoClient(addrs, crs);
                MongoDatabase md = mc.getDatabase("seeker");
                md.createCollection("h");
                System.out.println("Connect to database successfully.");
            } catch (Exception e) {
                System.err.println(e.getClass().getName() + ": " + e.getMessage());
            }
        }
    }
    ```
**JetBrains授权服务器地址**
```
http://idea.imsxm.com
```

# 语法
## 字符串转数字
```javascript
parseInt("1234blue"); //returns 1234
parseInt("0xA"); //returns 10
parseInt("22.5"); //returns 22
parseInt("blue"); //returns NaN

parseInt("AF", 16); //returns 175
parseInt("10", 2); //returns 2
parseInt("10", 8); //returns 8
parseInt("10", 10); //returns 10

parseInt("010"); //returns 8
parseInt("010", 8); //returns 8
parseInt("010", 10); //returns 10

parseFloat("1234blue"); //returns 1234.0
parseFloat("0xA"); //returns NaN
parseFloat("22.5"); //returns 22.5
parseFloat("22.34.5"); //returns 22.34
parseFloat("0908"); //returns 908
parseFloat("blue"); //returns NaN
```

或者强制类型转换
```js
Number(false) 0
Number(true) 1
Number(undefined) NaN
Number(null) 0
Number( "5.5 ") 5.5
Number( "56 ") 56
Number( "5.6.7 ") NaN
Number(new Object()) NaN
Number(100) 100
```

利用js变量弱类型转换
```javascript
var str= '012.345 ';
var x = str-0;
x = x*1;
```
取小数点后两位
```javascript
var num =2.446242342;
num = num.toFixed(2); // 输出结果为 2.45
```

操作json
```
myJsonObj.newObj="TEST2";
//或者
myJsonObj["newObj"]="TEST2";
alert(myJsonObj.newObj);
```

输出json数据
```javascript
alert(JSON.stringify(q, null, 4));
```

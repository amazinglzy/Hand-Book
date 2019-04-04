# Vue

- v-on 监听事件
    ```html
    <div id="app-5">
      <p>{{ message }}</p>
      <button v-on:click="reverseMessage">逆转消息</button>
    </div>


    <script>
        var app5 = new Vue({
          el: '#app-5',
          data: {
            message: 'Hello Vue.js!'
          },
          methods: {
            reverseMessage: function () {
              this.message = this.message.split('').reverse().join('')
            }
          }
        })
    </script>
    ```

- v-mode 实现表单输入和应用状态之间的双向绑定
    ```html
    <div id="app-6">
      <p>{{ message }}</p>
      <input v-model="message">
    </div>

    <script>
        var app6 = new Vue({
          el: '#app-6',
          data: {
            message: 'Hello Vue!'
          }
        })
    </script>
    ```

# element ui
[element ui 文档](http://element-cn.eleme.io/#/zh-CN)

## 布局
row 布满屏幕 值为 24

## 单选框
```html
<!DOCTYPE html>
<html>

    <head>
        <meta charset="UTF-8">
        <!-- 引入样式 -->
        <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
        <!-- 先引入 Vue -->
        <script src="https://unpkg.com/vue/dist/vue.js"></script>
        <!-- 引入组件库 -->
        <script src="https://unpkg.com/element-ui/lib/index.js"></script>
    </head>

    <body>
        <div id="app">
            <template>
                <el-radio v-model="a" label="1">备选项</el-radio>
                <el-radio v-model="a" label="2">备选项</el-radio>
                <el-radio v-model="a" label="3">备选项</el-radio>
            </template>
        </div>

        <div id="button">
            <el-button @click="alert_a">按钮</el-button>
        </div>
    </body>

    <script src="js/main.js"></script>

</html>
```

```javascript
var data = {a: '1'};

var Main = {
    data() {
        return data;
    }
}
var Ctor = Vue.extend(Main)
new Ctor().$mount('#app')

var button = new Vue({
    methods: {
        alert_a: function(event) {
            alert("Hello" + data.a);
            if (event) {
                alert(event.target.tagName);
            }
        }
    }
})
button.$mount('#button')
```

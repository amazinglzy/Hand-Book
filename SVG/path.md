# Path

## moveto, lineto 和 closepath

```html
<svg id="svg" viewBox="0 0 250 250" xmlns="http://www.w3.org/2000/svg">
  <g style="stroke: black; fill: none;">
    <path d="M 10 10 L 100 10" /></path>
    <path d="M 10, 20 L 100, 20 L 100, 50"></path>
    <path d="M 30 60 L 10, 60 L 40 42.68 M 60, 60 L 90 60 L 60, 42.68"></path>
    <path d="M 40 60 L 10 60 L 40 42.68 Z"></path>
  </g>
</svg>
```

`M` 对应 `moveto`，`M` 后面有两个数，表示将画笔移动到该位置上，`L` 表示从当前位置画一条线到其后面两个数表示的位置上。

`Z` 表示 `closepath`，即从当前位置连一条到起点的线，且相比不用 `closepath` ，`closepath` 在起点和终点的连接处是连续的。

如果使用小写字母来表示 `moveto` 和 `lineto` ，则之后的跟着的两个数表示相对坐标。

比如：
```html
<svg id="svg" viewBox="0 0 250 250" xmlns="http://www.w3.org/2000/svg">
  <g style="stroke: black; fill: none;">
    <path d="M 10 10 l 10 0 l 0 20 m 20 10 l 15 -5" style="stroke: black"></path>
  </g>
</svg>
```

如果使用小写 `m` 启动路径，那么它的坐标将会被解析成绝对路径。

## 水平和垂直lineto命令
| 简写形式 | 等价的冗长形式 | 效果|
| ------ | ----- | ---  |
|`H 20`   |`L 20 current_y`   | 绘制一条到绝对位置 `(20, current_y)` 的线 |
|`h 20`   |`l 20 0`   | 绘制一条到 `(current_x + 20, current_x)` 的线  |
|`V 20`   |`L current_x 20`   | 绘制一条到绝对位置 `(current_x, 20)` 的线  |
|`v 20`   |`l 0 20`   | 绘制一条到 `(current_x, current_y + 20)` 的线 |

多次连续的 `lineto` 操作还可以写成这样的形式：
```html
<svg id="svg" viewBox="0 0 250 250" xmlns="http://www.w3.org/2000/svg">
  <g style="stroke: black; fill: none;">
    <path d="M 10 10 l 10 0 0 20 10 20" style="stroke: black"></path>
  </g>
</svg>
```

## 椭圆弧

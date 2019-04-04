# winjs

**使用方式**
对于一个 `div` 标签，增加两个属性，一个是 `data-win-control` 表示控件的构造器（即控件的类型），另一个是 `data-win-options` 表示该控件的属性及方法。

在 `HTML` 文件中使用上述方式申明过后，在 `js` 文件中加入 `WinJS.UI.processAll()`，运行完之后就可以看到效果了，之后可以通过 `document.getElemntById("xxx").winControl.xx` 的形式访问该控件的属性及方法。

> 其中方法需要用 WinJS.UI.eventHandler 来修饰。
> ```js
> homeClicked: WinJS.UI.eventHandler(function (ev) {
>     document.getElementById("app").classList.add("show-home");
>     document.getElementById("app").classList.remove("show-trail");
> })
> ```

**绑定**
将一个 `HTML` 对象与一个 `js` 对象绑定，当 `js` 对象变化时，`HTML` 也随着变化，这是单方向的，也就是说当 `HTML` 变化时，`js` 对象不随着变化。
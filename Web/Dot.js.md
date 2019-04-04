# Dot.js
**example**

+ interpolation
```javascript
<div>Hi {{=it.name}}!</div>
<div>{{=it.age || ''}}</div>
```

+ evaluation
```javascript
{{ for(var prop in it) { }}
<div>{{=prop}}</div>
{{ } }}
```

+ conditionals
```javascript
{{? it.name }}
<div>Oh, I love your name, {{=it.name}}!</div>
{{?? it.age === 0}}
<div>Guess nobody named you yet!</div>
{{??}}
You are {{=it.age}} and still don't have a name?
{{?}}
```


**sample**
```javascript
var Templates = {
  meta: '<div id="meta-option-{{=it.id}}" class="row-fluid">' +
    '<div class="col-md-2">' +
    '<select>' +
    '<option value="value">a</option>' +
    '<option value="value">b</option>' +
    '<option value="value">c</option>' +
    '</select>' +
    '</div>' +
    '<div class="col-md-5">' +
    '<input type="text">' +
    '</div>' +
    '<div class="col-md-1">{% trans \'in\' %}</div>' +
    '<div class="col-md-3">' +
    '<select>' +
    '<option value="value">Choose...</option>' +
    '<option value="value">a</option>' +
    '<option value="value">b</option>' +
    '<option value="value">c</option>' +
    '</select>' +
    '</div>' +
    '<div class="col-md-1">' +
    '<button class="btn btn-default" onclick="destroy_self({{=it.id}})">Button</button>' +
    '</div>' +
    '</div>'
}
Object.freeze(Templates);
var compiledTemplateMeta = doT.template(Templates.meta);

var meta_id = 100000;
$("#add-meta").click(function() {
  $("#metas").append(compiledTemplateMeta({
    "id": meta_id
  }));
  meta_id++;
});

function destroy_self(id) {
  document.getElementById("metas").removeChild(document.getElementById("meta-option-" + id));
}

```

# jupyter

## Problems
1. set fonts
    
    修改 `~/.jupyter/custom/custom.css`，加入以下内容。
    ```css
    .CodeMirror pre, .CodeMirror-dialog, .CodeMirror-dialog .CodeMirror-search-field, .terminal-app .terminal {
        font-family: YOUR-FAV-FONT;
        font-size: 12pt;
    }
    ```
# [VS Code](https://code.visualstudio.com/)

Note: I have Atom Keymap on, as I came to VScode from Atom and decided it would take too long to learn VScodes keybindings.

[26 Miraculous VS Code Tools for JavaScript Developers in 2019](https://dev.to/jsmanifest/26-miraculous-vs-code-tools-for-javascript-developers-in-2019-50gg)

[Tips to use VSCode more efficiently](https://dev.to/selrond/tips-to-use-vscode-more-efficiently-3h6p)

## [Keyboard shortcuts](/everyday_shortcuts.md#VSCode)

### Key combos / chords not working

#### Quick Switch Window Issue

Doh!!

>No set key combo, have added `cmd + s + w` for my own set up.
>
>Can also access by going to the command palette `cmd + shift + p` and typing "quick".
>
>You can switch windows using "cmd + `", but not if the window is minimised, so using the above to maxmise windows.

Did the above and then when I tried to do `cmd + s` it was coming up with this:

![cmd + s key chord](cmdschord.png)

Took me awhile to figure out why that was happening but is because I added a key chord combo that started with `cmd + s`

Removed the key binding - `cmd + s + w` and now `cmd + s` is working fine!

## Markdown

[markdownlint](https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint)

[Build an Amazing Markdown Editor Using Visual Studio Code and Pandoc](https://thisdavej.com/build-an-amazing-markdown-editor-using-visual-studio-code-and-pandoc/)

> Markdown Snippets
> In your Markdown document, try pressing Ctrl+Space, and VS Code will provide you with a context sensitive list of Markdown commands that can be used. For example, you can press Ctrl+Space, type “link”, and press Enter to insert a hyperlink. You can add the hyperlink text, press Tab, and enter the URL. The Tab key is your friend with many of these snippets.

- link

[text](https://link)

- image

![alt](https://link)

## Emmet - built into VSCode

### [Emmet](https://emmet.io/)

[Emmet in Visual Studio Code](https://code.visualstudio.com/docs/editor/emmet)

```html
<!-- This will expand into -->
ul.li*5

<!-- this -->
<ul>
  <li></li>
  <li></li>
  <li></li>
  <li></li>
  <li></li>
</ul>
```

## Using `a` in explorer to create a new file not working, brings up filter instead

`"workbench.list.automaticKeyboardNavigation": false` - have this as false

[How to disable file filtering in VS Code Sidebar / Explorer?](https://superuser.com/questions/1417361/how-to-disable-file-filtering-in-vs-code-sidebar-explorer)

# January / February / March 2021 Mistakes, Improvements, Learning and Stuff

## Getting VS Code to be default editor for git stuff

Working with someone else that does not have this set up. Think need to have:

```bash
# .zshrc
export EDITOR="code"

# .gitconfig
git config --global core.editor "code --wait"
```

## Logical expressions

>I wouldnt change it but i guess whenever i see something thats like
>
>```js
>if logical expression
>  return logical expression
>
>else
>  return false
>```
>
>You can usually change the structure of it to be a single expression for example this one could be
>
>```js
>return !this.things && user && otherUser.groupIds.some(groupId => user.groupIds.includes(groupId))
>```

## white space

<https://developer.mozilla.org/en-US/docs/Web/CSS/white-space>

Had an issue where we weren't getting multiple lines showing as multiple lines in a Vue JS file. Code was this:

```html
<span class="text-body-2">
  {{ comment.message }}
</span>
```

By adding `white-space: pre-line` to the span, made the mutiple lines display (as in newlines), but added a heap of space to the top

```html
<span class="text-body-2 white-line-pre-space">
  {{ comment.message }}
</span>
```

```css
.white-space-pre-line {
  white-space: pre-line;
}
```

What we realised is that you need to have the span on one line, so could do:

```html
<span class="text-body-2 white-line-pre-space">{{ comment.message }}</span>
```

but this could get long with needing more classes for other things, so we can use the `v-text` directive:

```html
<span class="text-body-2 white-space-pre-line" v-text="comment.message"/>
```

<https://vuejs.org/v2/api/#v-text)>

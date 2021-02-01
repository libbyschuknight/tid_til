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

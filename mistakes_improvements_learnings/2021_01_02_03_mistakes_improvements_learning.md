# January / February / March 2021 Mistakes, Improvements, Learning and Stuff

## Getting VS Code to be default editor for git stuff

Working with someone else that does not have this set up. Think need to have:

```bash
# .zshrc
export EDITOR="code"

# .gitconfig
git config --global core.editor "code --wait"
```

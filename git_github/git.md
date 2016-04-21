# Git

### Useful Resources
[Getting Started](https://www.atlassian.com/git/tutorials/setting-up-a-repository) - have come across this again and again and it has always been useful.

##### git clean
Quite often I have found that I have had to get rid of untracked files in git and have discovered that git clean is something that you can use.

```bash
git clean -n # performs a dry run, will show you what will be removed
git clean -f # actually removes files
```

##### git revert / reset
This has been useful when I have be zealot like with merging in master to my branch and then discovering that a change someone else has made gives me problems, liking breaking tests. So, I have used git revert to go back to my last commit.

```bash
git revert 3333333333 # commit number
```

Actually, while writing this I have realized I actually did a git reset.

```bash
git reset 3333333333 # commit number
```
Which probably wasn't the best option for me and a git revert would have been more approrpoate.

##### searching commits

```bash
git log --all --grep="#til"
```


##### tags - deleting

If you have pushed a tag and then released that you had the wrong number, you can do this:
```bash
git tag -d v1.0
git push origin :refs/tags/v1.0
```
from [How do I remove or delete a tag from a Git repo?](https://confluence.atlassian.com/bitbucket/how-do-i-remove-or-delete-a-tag-from-a-git-repo-282175551.html), even though it is on a BitBUcket page, it works for GitHub too (I guess as it is in git).


### remotes

Check what what remotes are on a repo:

- `git branch -a` => shows branches and remotes including `gem_fury`

- `git branch -r` => just shows remotes


### `git add <file1> <file2>`

I'm not sure why it has taken me a long time to click onto this, it maybe because I have always added EVERYTHING before adding, committing and pushing. Which has gotten me into some tricky spots!
So,

`git add .`

adds everything.

But you can add one file at a time

`git add <file`>

or two or more files

`git add <file1> <file2>`

Perhaps also as I am using OhMyZsh and being using the git [cheatsheet](https://github.com/robbyrussell/oh-my-zsh/wiki/Cheatsheet#git) I have taken the easy/lazy road of just always adding everything.
I had better start using `ga` (shortcut for `git add`) when wanting to not add all files.

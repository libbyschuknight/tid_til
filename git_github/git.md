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

### Checking out a branches `tag` / version

```bash
git checkout 4.4.0
```
Instead of a branch name you will see the first few digits of the tags commit shard.
You will get something like this:

```bash
Note: checking out '4.4.0'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by performing another checkout.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -b with the checkout command again. Example:

  git checkout -b <new-branch-name>

HEAD is now at 3768438... Tag version 4.4.0
```
Make a new branch so any changes you make can be kept:
```bash
git branch -d feature/participant_roles_facade
```
Apply anything you have stashed - `git stash apply`

(see [Gem Stuff](gems/gem_stuff.md) for example of when used)


### `git log` plus variations
I use [Oh My Zsh](https://github.com/robbyrussell/oh-my-zsh) and `zsh` instead of `bash`.
I use the [cheatsheet](https://github.com/robbyrussell/oh-my-zsh/wiki/Cheatsheet) as well, which has [a lot of `git`](https://github.com/robbyrussell/oh-my-zsh/wiki/Cheatsheet#git) aliases set up.

One that I have just found useful is:
```bash
#alias     #command
glg	      git log --stat --max-count = 10
```
This shows the files that have been committed, which can be useful if the commit message hasn't been written that well!

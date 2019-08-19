# Git

## Useful Resources

[Getting Started - atlassian](https://www.atlassian.com/git/tutorials/setting-up-a-repository) - have come across this again and again and it has always been useful.

[git - the simple guide](http://rogerdudler.github.io/git-guide/)

[New Developer? You should’ve learned Git yesterday.](https://codeburst.io/number-one-piece-of-advice-for-new-developers-ddd08abc8bfa)

[Little Things I Like to Do with Git](https://csswizardry.com/2017/05/little-things-i-like-to-do-with-git/)

[Introducing GitFlow](https://datasift.github.io/gitflow/IntroducingGitFlow.html)

[A successful Git branching model](http://nvie.com/posts/a-successful-git-branching-model/)

[Markdown Tables Generator Facebook](http://www.tablesgenerator.com/markdown_tables) - useful for getting lines right for a table.

[Markdown Guide](https://www.markdownguide.org/)

- [Extended Syntax](https://www.markdownguide.org/extended-syntax)

[Oh shit, git!](https://ohshitgit.com/)

### git commits

[DEVELOPER TIP: KEEP YOUR COMMITS “ATOMIC”](https://www.freshconsulting.com/atomic-commits/)

[How to Write a Git Commit Message](http://chris.beams.io/posts/git-commit/)

[TELLING STORIES THROUGH YOUR COMMITS](http://blog.mocoso.co.uk/talks/2015/01/12/telling-stories-through-your-commits/``)

[Git Tutorial: 10 Common Git Problems and How to Fix Them](https://www.codementor.io/citizen428/git-tutorial-10-common-git-problems-and-how-to-fix-them-aajv0katd)

  >**The seven rules of a great git commit message**
  >
  >Keep in mind: This has all been said before.
  >
  >- Separate subject from body with a blank line
  >- Limit the subject line to 50 characters
  >- Capitalise the subject line
  >- Do not end the subject line with a period
  >- Use the imperative mood in the subject line
  >- Wrap the body at 72 characters
  >- Use the body to explain what and why vs. how

## Setting up git with gitlab

Good instructions on gitlab to follow. Had issues with ssh-keys and it was asking me each time I pushed for my passphrase.
To solve this did `ssh-add -K`

## Using gitlab (work) and github (personal)

Another good article
[Multiple SSH keys for different accounts on Github or Gitlab](https://coderwall.com/p/7smjkq/multiple-ssh-keys-for-different-accounts-on-github-or-gitlab)

Good article - [SSH Keys with Multiple GitHub Accounts](https://medium.com/@trionkidnapper/ssh-keys-with-multiple-github-accounts-c67db56f191e)

```bash
ssh-keygen -t rsa -b 4096 -C “your_email@example.com”

eval "$(ssh-agent -s)"

ssh-add ~/.ssh/id_rsa_github

pbcopy < ~/.ssh/id_rsa_github.pub
```

Add key to github

create a ssh config file with

```bash
Host github.com
HostName github.com
PreferredAuthentications publickey
IdentityFile ~/.ssh/id_rsa_github
```

And it worked. (hopefully gitlab still works!)

Hmmm, gitlab doesn't still work, did `ssh-add -A` and reloaded zsh, think it will stop working again. Need to find long term solution.

`ssh -T git@github.com`

`ssh -T git@git.fluxfederation.com`

## Amending a commit

If you have made some changes and just want to add them to the last commit you made.

Remember to `git add .` the changes

```bash
git commit --amend  # this will allow you to also change the commit message

git commit -a
```

if you want to add files or changes without editing the message

```bash
git commit --amend --no-edit
```

## git fetch

Rather than pulling down a branch, which does a `fetch` and a `merge`, I have stared doing:

```bash
git fetch origin <branch_name>

git checkout <branch_name>
```

In some cases pulling can cause problems. Will add why when I come across it again!

## git branch

List branches by committer date instead of alphabetically:

`git branch --sort=-committerdate`

## git clean

Quite often I have found that I have had to get rid of untracked files in git and have discovered that git clean is something that you can use.

```bash
git clean -n # performs a dry run, will show you what will be removed
git clean -f # actually removes files
```

## git revert / reset

This has been useful when I have be zealot like with merging in master to my branch and then discovering that a change someone else has made gives me problems, like breaking tests. So, I have used git revert to go back to my last commit.

```bash
git revert 3333333333 # commit number
```

Actually, while writing this I have realized I actually did a table.

```bash
git reset 3333333333 # commit number

# or

git reset --hard master # if want to change branch development to be the same as master (this is if you already have a branch development)
```

Which probably wasn't the best option for me and a git revert would have been more appropriate.

Wanted to go back a few commits that had already been pushed up. So reset to commit and then did a force push to branch.

```bash
git reset --hard <commit>

git push -f <remote> <branch>

e.g.
git push --force origin bugfix/squash_it
```

Issue had with local repo:

- did a `git pull branch`, then `git merge master`
- resolved conflicts that came up
- some how had one file that had all of its code missing, it was the most recent file
- to fix did:
    `git pull -f origin branch`
    `git reset --hard origin/branch`

## cancelling a merge that has conflicts - abort

`git merge --abort`  if there has been conflicts

[How to: Cancel a Git merge](https://nathanhoad.net/how-to-git-cancel-merge/)

There are heaps of ways to do it in git but since Git version 1.7.4 you can do this

https://www.git-scm.com/docs/git-merge/1.7.4


## searching commits

```bash
git log --all --grep="#til"
```


## Deleting

### Deleting tags

If you have pushed a tag and then released that you had the wrong number, you can do this:
```bash
git tag -d v1.0
git push origin :refs/tags/v1.0
```
from [How do I remove or delete a tag from a Git repo?](https://confluence.atlassian.com/bitbucket/how-do-i-remove-or-delete-a-tag-from-a-git-repo-282175551.html), even though it is on a BitBUcket page, it works for GitHub too (I guess as it is in git).


### Deleteing multiple branches at once


```bash
# a grep showing what branches this will be
$ git branch | grep -E 'ci-*'
  ci-2949
  ci-3219

# then can do
$ git branch -D `git branch | grep -E 'ci-*'`
Deleted branch ci-2949 (was 8e0aa94780).
Deleted branch ci-3219 (was 7cefdc4239).
```
Bound to be lots of other ways to delete branches and different combinations of branches.

Another suggestion:

```bash
git branch --merged | egrep -v "(^\*|master|prod)" | xargs git branch -D
```


### fetch /checkout

```bash
git fetch --tags

git checkout <tag_number>
```

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

UPPATE to this is that I am now using the Git / Github integration with Atom https://github.atom.io/, which is great and makes it much easier I think to stage files and parts of files.

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
glg        git log --stat --max-count = 10
```

This shows the files that have been committed, which can be useful if the commit message hasn't been written that well!

Show the diff on commits:

```bash
# all commits - show the diff
 git log -p

# limit number of commits - e.g. first 2
 git log -p -2
```

### git stash

Add a name when you are stashing:

```bash
git stash save useful name here
```

how to see what you have stashed
```bash
git stash list
git stash show -p # this shows the diff
git stash show -p stash@{3}
```

http://stackoverflow.com/questions/3573623/is-it-possible-to-preview-stash-contents-in-git

And then to put back into the branch the stash you want:

`git stash apply stash@{3}`

`apply` keeps the stash, `pop` takes it of the stack (gets rid of it)

To get rid of a stash:

`git stash drop`  removes top one
`git stash drop stash@{3}` specific one

[Cleaning up your stash](https://www.atlassian.com/git/tutorials/git-stash#cleaning-up-your-stash)

`git stash clear` to remove all stashes


Stash untacked files:
`git stash --include-untracked`
`git stash -u`
>Adding the -u option (or --include-untracked) tells git stash to also stash your untracked files:
https://www.atlassian.com/git/tutorials/git-stash#stashing-your-work


## Error when trying to apply a stash
Early I had an error when upon searching the suggestion was to do this:
`Normally closing git program and re open will fix this issue` or `rm -f ./.git/index.lock`

https://stackoverflow.com/questions/38004148/another-git-process-seems-to-be-running-in-this-repository

I tried the second suggestion.

Then when I tried to apply a stash got this:

```bash
error: Your local changes to the following files would be overwritten by merge:
	spec/features/generate_invoices_spec.rb
Please commit your changes or stash them before you merge.
Aborting
fatal: Unable to create '/Users/libby/Code/payments/.git/MERGE_RR.lock': File exists.

Another git process seems to be running in this repository, e.g.
an editor opened by 'git commit'. Please make sure all processes
are terminated then try again. If it still fails, a git process
may have crashed in this repository earlier:
remove the file manually to continue.
```

Re-read over the above stack overflow answer and closed terminal window, re-opened and the `git stash apply` worked fine!

Had this again, found same stack overflow question, did this `rm -f .git/index.lock` and it fixed the problem.

### git rebase

```bash
feature/first_page_form

git rebase feature/form

git push --force origin feature/first_page_join_form_MVP
```

[Getting solid at Git rebase vs. merge](https://medium.com/@porteneuve/getting-solid-at-git-rebase-vs-merge-4fa1a48c53aa#.9yty645zl)

[The Golden Rule of Rebasing](https://www.atlassian.com/git/tutorials/merging-vs-rebasing#the-golden-rule-of-rebasing)

[Git Interactive Rebase, Squash, Amend and Other Ways of Rewriting History](https://robots.thoughtbot.com/git-interactive-rebase-squash-amend-rewriting-history)

[Interactive Rebase](https://robots.thoughtbot.com/git-interactive-rebase-squash-amend-rewriting-history#interactive-rebase)

#### git rebase -i (--interactive)

[Beginner’s Guide to Interactive Rebasing](https://hackernoon.com/beginners-guide-to-interactive-rebasing-346a3f9c3a6d)

```
commit sha123456
Author: Libby Schumacher-Knight
Date:   Tue Jun 12 15:01:43 2018 +1200

    WIP Something a rather

    Comments, comments comments

commit sha9876543
Author: Libby Schumacher-Knight
Date:   Mon Jun 11 11:20:01 2018 +1200

    WIP Othe commit here

    More comments more comments

commit shaabcdefg
Merge: cfc7d565435b3b ea4d3eb96542
Author: Misty
Date:   Tue Jun 12 14:30:41 2018 +1200

    Merge branch '123' into 'master'

```

I want to remove the `WIP`'s at the start of my 2 commit messages. To do this I can use:

`git rebase -i` by using the commit before the ones I want to change.

`git rebase -i sha123456`

This will then give me the option to say what I want to do with each commit - in this case just wanted to reword the commit messages.
Have a look at <https://robots.thoughtbot.com/git-interactive-rebase-squash-amend-rewriting-history#interactive-rebase> for what to do next.

### git reset

When have mucked up a merge or something badly and need to reset the branch. Or in this case want to reset the uat branch locally to what is on github.

```bash
git checkout uat

git fetch origin uat

git reset --hard origin/uat
```

#### git reset --soft HEAD^

<http://stackoverflow.com/questions/12481639/remove-files-from-git-commit>

When you have made a commit and then realise there are heaps of files in it that shouldn't be!

`git reset --soft HEAD^`

Then reset the unwanted files in order to leave them out from the commit:

`git reset HEAD path/to/unwanted_file`

`git reset HEAD test/`    # remove all the files under test that didn't want to add

Now commit again, you can even re-use the same commit message:

`git commit -c ORIG_HEAD`

#### git reset --soft HEAD~1 - remove the last commit

[How can I undo the last commit?](https://www.git-tower.com/learn/git/faq/undo-last-commit)

>In these cases, the "reset" command is your best friend:
>
>`$ git reset --soft HEAD~1`
>
>If you don't want to keep these changes, simply use the --hard flag. Be sure to only do this when you're sure you don't need these changes anymore.
>
>`$ git reset --hard HEAD~1`


## Find most recent branches

Can’t remember what branches are most recently active in a repo without using Github?
Use `git branch --sort=-authordate`
and the most recently changed branches will be listed at the top.
Thanks @ootovak

## Adding a remote to a local repo

Needed to do this when I created a Rails app but then realised I hadn't used postgres or taken out test unit and turbolinks. I had already created a github repo so there was already a remote.
I deleted my first repo locally and then create new app, then added the remote.

`git remote add origin git@github.com:libbyschuknight/go_surf.git`

`git remote -v` # this shows you the remotes e.g.

```bash
git remote -v
origin git@github.com:libbyschuknight/tid_til.git (fetch)
origin git@github.com:libbyschuknight/tid_til.git (push)
```

## Go back to previous branch - quickly

```bash
git checkout -
```

## Issue with pushing to github

Started working in a repo I haven't been in for ages and when pushing kept getting this:

`Enter passphrase for key '/Users/libby/.ssh/id_rsa':`

enter password and all is good with that world...until next time, need to repeat.

So, have tried doing

`ssh-add`,

this gives `Enter passphrase for /Users/libby/.ssh/id_rsa:`,

enter password and then:

`Identity added: /Users/libby/.ssh/id_rsa (/Users/libby/.ssh/id_rsa)`

Hoping this has fixed it!

## `git cherry-pick`

Make sure you are on the branch you want to add the commit to:

```bash
git cherry-pick <commit-hash>
```

## `git cherry-pick` from one local repo to another

Had cloned straight from the Ruby NZ www repo (dir: branch) and made changes in a branch:

`~/Projects/open_source/www: resolve-register_of_ruby_companies`

Found out (before I tried to push anything) I should have forked the repo, added a branch to my fork and then made a pull request.

So, I needed to be able to copy the commits from

`~/Projects/open_source/www: resolve-register_of_ruby_companies`

to the forked repo I had made:

`~/Projects/open_source/forked/www: gh-pages`

Found this [~/Git cherry-pick from another repository](http://bendetat.com/git-cherry-pick-from-another-repository.html)

First things first is making the `~/Projects/open_source/www: resolve-register_of_ruby_companies` a local remote in the `~/Projects/open_source/forked/www: gh-pages`.

```bash
~/Projects/open_source/forked/www: gh-pages                      # working copy
~/Projects/open_source/www: resolve-register_of_ruby_companies   #copy with the commit I need
```


```bash
~/Projects/open_source/forked/www: gh-pages>$ git remote add localcopy ../../www
```

```bash
$ git remote -v

localcopy ../../www (fetch)
localcopy ../../www (push)
origin git@github.com:libbyschuknight/www.git (fetch)
origin git@github.com:libbyschuknight/www.git (push)
```

Then doing `git fetch localcopy` gave this:

```bash
remote: Counting objects: 29, done.
remote: Compressing objects: 100% (27/27), done.
remote: Total 29 (delta 19), reused 3 (delta 0)
Unpacking objects: 100% (29/29), done.
From ../../www
 * [new branch]      gh-pages                -> localcopy/gh-pages
 * [new branch]      register-of-companies   -> localcopy/register-of-companies
 * [new branch]      resolve-register_of_ruby_companies -> localcopy/resolve-register_of_ruby_companies
 ```

Then was able to `cherry-pick` which commits I wanted to move from one to the other.

## `git config`

Had issue with using the zsh command `gcmsg`, which is `git commit -v`, it would open atom but in the terminal kept coming up with
`Aborting commit due to empty commit message.`

Quick searched showed I needed to set the config to wait:
`git config --global core.editor "atom --wait"`

Now, working all good!

## `git push --force or --force-with-lease`

[--force considered harmful; understanding git's --force-with-lease](https://developer.atlassian.com/blog/2015/04/force-with-lease/)

[Force-with-lease: an alternative to force push](http://weiqingtoh.github.io/force-with-lease/)

[Force push with care](https://robots.thoughtbot.com/git-push-force-with-lease)

## [OhMyZsh](http://ohmyz.sh/)

I use [Oh My Zsh](https://github.com/robbyrussell/oh-my-zsh) and `zsh` instead of `bash`.
I use the [cheatsheet](https://github.com/robbyrussell/oh-my-zsh/wiki/Cheatsheet) as well, which has [a lot of `git`](https://github.com/robbyrussell/oh-my-zsh/wiki/Cheatsheet#git) aliases set up.

One I have just discovered that is very useful:

```
gwip	     git add -A; git ls-files --deleted -z | xargs -r0 git rm; git commit -m "--wip--"
gunwip	   git log -n 1 | grep -q -c "--wip--" && git reset HEAD~1
```

## .gitignore
https://git-scm.com/docs/gitignore

https://www.atlassian.com/git/tutorials/saving-changes/gitignore


If want to ignore `node_modules` folder

```
node_modules/
```

## exclude from git (not git ignore)

Add to `.git/info/exclude`

e.g. if you want to have a local folder but not have it in git or in the `gitignore` file

`local/*`

[Exclude files from git without committing changes to .gitignore 🙅](https://hackernoon.com/exclude-files-from-git-without-committing-changes-to-gitignore-986fa712e78d)

## git squash

[Auto-squashing Git Commits](https://robots.thoughtbot.com/autosquashing-git-commits)


## git-rerere

Records conflict changes you have made so you don't have to do them again.

https://git-scm.com/docs/git-rerere

[Fix conflicts only once with git rerere](https://medium.com/@porteneuve/fix-conflicts-only-once-with-git-rerere-7d116b2cec67)

## `git prune`

<https://git-scm.com/docs/git-prune>

<https://www.atlassian.com/git/tutorials/git-prune>

>The git prune command is an internal housekeeping utility that cleans up unreachable or "orphaned" Git objects. Unreachable objects are those that are inaccessible by any refs. Any commit that cannot be accessed through a branch or tag is considered unreachable.

Used this after I was doing a pull on the master branch for the huge monolith at work, where it came up with this message:

```bash
From git....
 * branch                    master     -> FETCH_HEAD
Auto packing the repository in background for optimum performance.
See "git help gc" for manual housekeeping.
error: The last gc run reported the following. Please correct the root cause
and remove .git/gc.log.
Automatic cleanup will not be performed until the file is removed.

warning: There are too many unreachable loose objects; run 'git prune' to remove them.
```

Seemed to do the trick. Had asked in slack and another suggestion was:

```bash
git prune --dry-run # to see what would be deleted

# run this from time to time to delete all merged branches locally other than ones with master and prod in name
git branch --merged | egrep -v "(^\*|master|prod)" | xargs git branch -D
```

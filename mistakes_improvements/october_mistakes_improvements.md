# October Mistakes & Improvements

### git config

Had issue with using the zsh command `gcmsg`, which is `git commit -v`, it would open atom but in the terminal kept coming up with
`Aborting commit due to empty commit message.`

Quick searched showed I needed to set the config to wait:
`git config --global core.editor "atom --wait"`

Now, working all good!

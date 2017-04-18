# Server and Rack type stuff

Issue with running `shotgun`

```bash
bundle exec shotgun
bundler: failed to load command: shotgun (/Users/libby/.rbenv/versions/2.2.3/bin/shotgun)
LoadError: cannot load such file -- rack/commonlogger
  /Users/libby/.rbenv/versions/2.2.3/lib/ruby/gems/2.2.0/gems/shotgun-0.9.1/bin/shotgun:112:in `require'
  /Users/libby/.rbenv/versions/2.2.3/lib/ruby/gems/2.2.0/gems/shotgun-0.9.1/bin/shotgun:112:in `<top (required)>'
  /Users/libby/.rbenv/versions/2.2.3/bin/shotgun:23:in `load'
  /Users/libby/.rbenv/versions/2.2.3/bin/shotgun:23:in `<top (required)>'
```

This was an issue with `rack` being upgraded and `shotgun` not playing nicely with it.
The issue - https://github.com/rtomayko/shotgun/issues/62
The PR - https://github.com/rtomayko/shotgun/pull/61

Immediate solution until the PR is/was merged into the master branch of the Shotgun repo.
In Gemfile
```ruby
gem "rack", "< 2" # TODO: upgrade to Rack 2 once issue fixed https://github.com/rtomayko/shotgun/pull/61
```

## Tail the logs on a server
To see what is happening on a production log you can do this:
(if you are in the `log` folder)

```bash
tails -f production.log
```
use `ctrl + c` to get out of the log


# DevOps

## AWS

### Troubleshooting a failed opsworks deploy (from Flick)

1. Repeat the deploy (a deploy can fail for various network related reasons, if it fails twice in a row, then it's probably not that)
2. Does the deploy appear in Opsworks as failed?
  1. Check the deploy log for errors
  2. If the error is about a missing git ref for a branch that has been deleted then edit the config for the affected app to point back to master
3. SSH into the app server and run `ps -ef | grep puma` to check if the puma process is running for your app
  1. If the puma process is not running, or it is running but the process start date does not match the last deploy, then you can stop it: `/xxx/www/APP_NAME/shared/scripts/puma stop` and then start it again `/xxx/www/APP_NAME/shared/scripts/puma start`
  2. Or, you could do a clean restart by going to the current folder for your app `cd /xxx/www/APP_NAME/current`, then `../../shared/scripts/puma clean-restart`.
4. Check the puma error log in `/xxx/www/APP_NAME/current/log/puma.stderr.log`


## Remote server stuff

Ruthessly copied from Flick Electrics How to Tech Team repo (with appropriate changes made)

### SSH

#### Remote host identification has changed

The following warning is a reasonably common occurrence that stems from the way
our infrastructure is managed.

```
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
Someone could be eavesdropping on you right now (man-in-the-middle attack)!
It is also possible that a host key has just been changed.
The fingerprint for the ECDSA key sent by the remote host is
SHA256:axn974984yxxxxxxm2hxp9qm9yc9w3r9mcw09urxw8Y.
Please contact your system administrator.
Add correct host key in /home/user/.ssh/known_hosts to get rid of this message.
Offending ECDSA key in /home/user/.ssh/known_hosts:17
ECDSA host key for uat-bastion.company.co has changed and you have requested strict checking.
```

### Why it happens

This can happen when you try to connect to a machine at a specific address and
that machine is a different one than what you last connected to. For example:

You've previously connected to `bastion.company.co` (our jump server, the
border between our private network on Amazon and the rest of the internet)

Now, if we have to replace the instance that `bastion.company.co` points to
(for example to update it), it will have a different fingerprint and will throw
this error when we try to connect to it.

This is a security measure built into SSH to help prevent someone malicious
from redirecting traffic to `bastion.company.co` through some other computer
in order to learn some valuable information (the referenced man-in-the-middle
attack).

### What to do

First of all, check with the team to make sure this is expected (someone may
have swapped out the instance).

If there's nothing suspicious going on (quantifying suspicious here is hard),
then you can move on to addressing the warning.

The warning includes a line number for the offending fingerprint:

```
Offending ECDSA key in /home/user/.ssh/known_hosts:17
```

The simplest way to get past this is to open `~/.ssh/known_hosts` in your text
editor, delete that line, save and re-attempt the connection.

If you want to make doubly sure that nothing suspicious is happening on your
machine specifically, you can go one step further and ask a teammate who is
able to SSH into the host successfully to give you their copy of the server's
fingerprint, and replace the offending line in your `known_hosts` file with
their line.

Thanks to Greg for writing this up! 😀

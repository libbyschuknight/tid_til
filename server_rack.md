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

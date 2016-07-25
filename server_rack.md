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

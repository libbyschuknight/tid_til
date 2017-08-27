# Computer / Terminal / brew / gem problems


#### readline problem
When doing `rails console` got this error:

```bash
/Users/SchuKnight/.rbenv/versions/2.3.1/lib/ruby/2.3.0/irb/completion.rb:10:in 'require': dlopen(/Users/SchuKnight/.rbenv/versions/2.3.1/lib/ruby/2.3.0/x86_64-darwin15/readline.bundle, 9): Library not loaded: /usr/local/opt/readline/lib/libreadline.6.dylib (LoadError)
  Referenced from: /Users/SchuKnight/.rbenv/versions/2.3.1/lib/ruby/2.3.0/x86_64-darwin15/readline.bundle
  Reason: image not found - /Users/SchuKnight/.rbenv/versions/2.3.1/lib/ruby/2.3.0/x86_64-darwin15/readline.bundle
```

Think I came across this issue at work and I think I solved with this github issue question / answer:
https://github.com/rails/rails/issues/26658

"works for me:
`ln -s /usr/local/opt/readline/lib/libreadline.7.0.dylib /usr/local/opt/readline/lib/libreadline.6.dylib`"

However, this time I found this:
https://stackoverflow.com/questions/16756287/cannot-execute-rails-console-due-to-an-error-with-readline

And it was the answer with this that worked:

```bash
$ rbenv uninstall 2.3.1
$ rbenv install 2.3.1
$ cd /path/to/my/app
$ bundle
```

I had, before this issue, installed `ruby 2.3.1` and when I tried to do `rails new app` it gave me this error:

```bash
$rails
rbenv: rails: command not found

The 'rails' command exists in these Ruby versions:
  2.3.1
```
So had to firstly install bundler and then rails:

```bash
gem install bundler
# and remember to do:
rbenv rehash
gem install rails
rbenv rehash
```
Early I had also updated `ruby-build & rbenv`

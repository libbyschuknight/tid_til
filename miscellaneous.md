# Stuff that doesn't yet fit somewhere else

##### Pry
When using `pry`, you can type `ENV` and it will show all the environment variables! Yay!

```
=> {"ADDRESSFINDER_CLEANSING_KEY"=>"XXXXX",
 "ADDRESSFINDER_CLEANSING_SECRET"=>"XXXXX",
 "AWS_ACCESS_KEY_ID"=>"XXXXX",
 "AWS_REGION"=>"XXXXXX",
 "AWS_SECRET_ACCESS_KEY"=>"XXXXXX",
 "Apple_PubSub_Socket_Render"=>"/private/tmp/com.apple.launchd.zBbBBbxFLf/Render",
 "BUNDLE_BIN_PATH"=>"/Users/libby/.rbenv/versions/2.2.3/lib/ruby/gems/2.2.0/gems/bundler-1.11.2/exe/bundle",
 "BUNDLE_GEMFILE"=>"/Users/libby/Code/customer_app/Gemfile",
 "BUNDLE_ORIG_MANPATH"=>
  "/Users/libby/.XXXXXXXXX",
....
 "API_HOST"=>"https://uat.XXXXXXX",
 ```

This was important as I though I was running something in localhost but it was actually still connected to UAT.

##### Trello
[How To Format Your Text in Trello](http://help.trello.com/article/821-using-markdown-in-trello)
[Keybaord Shortcuts](https://trello.com/shortcuts)


##### Aliases

Been working in Sequel gem a lot and got tired of doing `bundle exec irb` then when in irb `require "./config/environment.rb"`.
Learnt that you can do this `bundle exec irb -r ./config/environment.rb"`, which I have added as an alias called `sequelc` - sequel console!

##### Multiple Codebases
When working with multiple codebases that work together, remember:
- update where gems are pointing to, e.g. if you are working with local changes to a gem, have both apps pointing at your local version of the gem.
- when running App1, which makes calls to App2 (api), remember to change the environment variable to hit local App2 - e.g API_HOST = http://localhost:3000.
- look for errors in the server output of both apps
- when working in different branches of the same app and making changes to the database in one of those branches, when you change to another branch, changes to the structure/schema of the database DOES NOT change, you will need to do `rake db:migrate` or `rake db:reset`
- remember also that you will need to run `rake db:test:prepare`!!


##### Google Chrome
**Useful Keyboard Shortcuts:**
- `Cmd + L` to focus on address bar

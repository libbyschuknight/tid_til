# Stuff that doesn't yet fit somewhere else

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

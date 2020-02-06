# January 2020 Mistakes, Improvements, Learning and Stuff

First month at Storypark!!

## New Computer Setup and SP repo setups

### Finding computers local IP address

<https://en.wikipedia.org/wiki/Ifconfig>

```bash
ifconfig
# got a long list of things

ifconfig | grep inet
# used to narrow it down

>
  inet 127.0.0.1 netmask 0xff000000
  inet6 ::1 prefixlen 128
  inet6 fe80::1%lo0 prefixlen 64 scopeid 0x1
  inet6 fe80::aede:48ff:fe00:1122%en5 prefixlen 64 scopeid 0x4
  inet6 fe80::c13:e5d9:2903:b57d%en0 prefixlen 64 secured scopeid 0x6
  inet 192.168.1.19 netmask 0xffffff00 broadcast 192.168.1.255
  inet6 fe80::fcf5:8aff:fe13:4d08%awdl0 prefixlen 64 scopeid 0x8
  inet6 fe80::fcf5:8aff:fe13:4d08%llw0 prefixlen 64 scopeid 0x9
  inet6 fe80::7e58:d1c6:e4f3:f22f%utun0 prefixlen 64 scopeid 0xf
  inet6 fe80::7379:be3d:3948:ddff%utun1 prefixlen 64 scopeid 0x10
  inet6 fe80::298d:1af6:fab:75be%utun2 prefixlen 64 scopeid 0x11
  inet6 fe80::be35:c94d:bb71:e422%utun3 prefixlen 64 scopeid 0x12
```

This line `inet 192.168.1.19 netmask 0xffffff00 broadcast 192.168.1.255` is where we can find it - `192.168.1.19`.

Also can be found under `Systems Preferences -> Network -> Advanced -> TCP/IP -> IPv4 Address`

#### Needed to change for home as well!!

Started working from home and ran the server locally and was getting this error:

```bash
12:01:29 zencoder.1 | /Users/libby/.gem/ruby/2.6.3/bin/zencoder_fetcher:23:in `<main>'
12:01:29 zencoder.1 | I require zencoder but it's not installed.  Please install by typing 'gem install zencoder-fetcher'.
12:01:30 zencoder.1 | exited with code 1
```

But that gem I had already installed. I was confused. Was just having a look around at some files and landed on the `.env` for the repo and at the top of this file is:

```bash
# Set these using your machine's settings
HOSTNAME=192.168.1.19:3000
LOCAL_IP=192.168.1.19
```

This got me to thinking and had a look at my IP address now and it was different so have added this:

```bash
# Set these using your machine's settings
# Work settings
# HOSTNAME=192.168.1.19:3000
# LOCAL_IP=192.168.1.19

# Home settings
HOSTNAME=192.168.1.67:3000
LOCAL_IP=192.168.1.67
```

Will just have to remember to change it!

### yarn / gyp errors

Needed to use `yarn` within a project. xcode command line tools should have worked but there seems to be issues with xcode, gyp and catalina.

<https://github.com/nodejs/node-gyp/issues/1927>

I had a look at this <https://github.com/nodejs/node-gyp/blob/master/macOS_Catalina.md> and had a quick chat with colleague and decided to install the full xcode app.
It could actualy be useful to have. And now things are working fine.

### Enviornment varaibles

Second rails app I needed to get working in a monorepo.

When I first went into the `dir` it came up with:

```bash
cd families
direnv: loading .envrc
./.envrc: line 2: export: `education.': not a valid identifier
./.envrc: line 2: export: `OAuth,': not a valid identifier
./.envrc: line 2: export: `following:': not a valid identifier
direnv: error exit status 1
```

<https://github.com/direnv/direnv>

> direnv is an extension for your shell. It augments existing shells with a new feature that can load and unload environment variables depending on the current directory.

This probably should have got me thinking!

Did some stuff like `bundle install` and `db:create` When tried to do `rake db:migrate db:seed`, came up with this error:

```bash
rake aborted!
TypeError: no implicit conversion of nil into String
/Users/libby/.gem/ruby/2.6.3/gems/aws-sdk-core-2.2.1/lib/aws-sdk-core/signers/v4.rb:96:in `+'
/Users/libby/.gem/ruby/2.6.3/gems/aws-sdk-core-2.2.1/lib/aws-sdk-core/signers/v4.rb:96:in `signature'
/Users/libby/.gem/ruby/2.6.3/gems/aws-sdk-core-2.2.1/lib/aws-sdk-core/signers/v4.rb:79:in `presigned_url'
/Users/libby/.gem/ruby/2.6.3/gems/aws-sdk-core-2.2.1/lib/aws-sdk-core/s3/presigner.rb:97:in `block in sign_but_dont_send'
/Users/libby/.gem/ruby/2.6.3/gems/aws-sdk-core-2.2.1/lib/aws-sdk-core/plugins/s3_request_signer.rb:87:in `call'
/Users/libby/.gem/ruby/2.6.3/gems/aws-sdk-core-2.2.1/lib/aws-sdk-core/xml/error_handler.rb:8:in `call'
/Users/libby/.gem/ruby/2.6.3/gems/aws-sdk-core-2.2.1/lib/aws-sdk-core/plugins/s3_request_signer.rb:64:in `call'
/Users/libby/.gem/ruby/2.6.3/gems/aws-sdk-core-2.2.1/lib/aws-sdk-core/plugins/s3_redirects.rb:15:in `call'
/Users/libby/.gem/ruby/2.6.3/gems/aws-sdk-core-2.2.1/lib/aws-sdk-core/plugins/retry_errors.rb:87:in `call'
/Users/libby/.gem/ruby/2.6.3/gems/aws-sdk-core-2.2.1/lib/aws-sdk-core/plugins/s3_md5s.rb:33:in `call'
/Users/libby/.gem/ruby/2.6.3/gems/aws-sdk-core-2.2.1/lib/aws-sdk-core/plugins/s3_expect_100_continue.rb:21:in `call'
/Users/libby/.gem/ruby/2.6.3/gems/aws-sdk-core-2.2.1/lib/aws-sdk-core/plugins/s3_bucket_dns.rb:31:in `call'
/Users/libby/.gem/ruby/2.6.3/gems/aws-sdk-core-2.2.1/lib/aws-sdk-core/rest/handler.rb:7:in `call'
/Users/libby/.gem/ruby/2.6.3/gems/aws-sdk-core-2.2.1/lib/aws-sdk-core/plugins/user_agent.rb:12:in `call'
/Users/libby/.gem/ruby/2.6.3/gems/aws-sdk-core-2.2.1/lib/seahorse/client/plugins/endpoint.rb:41:in `call'
/Users/libby/.gem/ruby/2.6.3/gems/aws-sdk-core-2.2.1/lib/aws-sdk-core/plugins/param_validator.rb:21:in `call'
/Users/libby/.gem/ruby/2.6.3/gems/aws-sdk-core-2.2.1/lib/seahorse/client/plugins/raise_response_errors.rb:14:in `call'
/Users/libby/.gem/ruby/2.6.3/gems/aws-sdk-core-2.2.1/lib/aws-sdk-core/plugins/s3_sse_cpk.rb:18:in `call'
/Users/libby/.gem/ruby/2.6.3/gems/aws-sdk-core-2.2.1/lib/aws-sdk-core/plugins/param_converter.rb:20:in `call'
/Users/libby/.gem/ruby/2.6.3/gems/aws-sdk-core-2.2.1/lib/seahorse/client/plugins/response_target.rb:21:in `call'
/Users/libby/.gem/ruby/2.6.3/gems/aws-sdk-core-2.2.1/lib/seahorse/client/request.rb:70:in `send_request'
/Users/libby/.gem/ruby/2.6.3/gems/aws-sdk-core-2.2.1/lib/aws-sdk-core/s3/presigner.rb:51:in `presigned_url'
/Users/libby/.gem/ruby/2.6.3/gems/aws-sdk-resources-2.2.1/lib/aws-sdk-resources/services/s3/object.rb:169:in `presigned_url'
/Users/libby/storypark/storyjar/families/app/models/artwork_pack.rb:36:in `signed_url'
/Users/libby/storypark/storyjar/families/app/services/artwork_pack/create_sections.rb:14:in `call'
/Users/libby/storypark/storyjar/families/app/services/service.rb:10:in `call'
/Users/libby/storypark/storyjar/families/app/models/artwork_pack.rb:40:in `create_sections'
/Users/libby/storypark/storyjar/families/db/seeds.rb:149:in `block (2 levels) in <top (required)>'
/Users/libby/.gem/ruby/2.6.3/gems/activerecord-4.2.11/lib/active_record/core.rb:283:in `initialize'
/Users/libby/.gem/ruby/2.6.3/gems/activerecord-4.2.11/lib/active_record/inheritance.rb:61:in `new'
/Users/libby/.gem/ruby/2.6.3/gems/activerecord-4.2.11/lib/active_record/inheritance.rb:61:in `new'
/Users/libby/.gem/ruby/2.6.3/gems/activerecord-4.2.11/lib/active_record/persistence.rb:50:in `create!'
/Users/libby/.gem/ruby/2.6.3/gems/activerecord-4.2.11/lib/active_record/relation.rb:151:in `block in create!'
/Users/libby/.gem/ruby/2.6.3/gems/activerecord-4.2.11/lib/active_record/relation.rb:302:in `scoping'
/Users/libby/.gem/ruby/2.6.3/gems/activerecord-4.2.11/lib/active_record/relation.rb:151:in `create!'
/Users/libby/.gem/ruby/2.6.3/gems/activerecord-4.2.11/lib/active_record/relation.rb:159:in `first_or_create!'
/Users/libby/storypark/storyjar/families/db/seeds.rb:145:in `block in <top (required)>'
/Users/libby/storypark/storyjar/families/db/seeds.rb:143:in `each'
/Users/libby/storypark/storyjar/families/db/seeds.rb:143:in `each_with_index'
/Users/libby/storypark/storyjar/families/db/seeds.rb:143:in `<top (required)>'
/Users/libby/.gem/ruby/2.6.3/gems/activesupport-4.2.11/lib/active_support/dependencies.rb:268:in `load'
/Users/libby/.gem/ruby/2.6.3/gems/activesupport-4.2.11/lib/active_support/dependencies.rb:268:in `block in load'
/Users/libby/.gem/ruby/2.6.3/gems/activesupport-4.2.11/lib/active_support/dependencies.rb:240:in `load_dependency'
/Users/libby/.gem/ruby/2.6.3/gems/activesupport-4.2.11/lib/active_support/dependencies.rb:268:in `load'
/Users/libby/.gem/ruby/2.6.3/gems/railties-4.2.11/lib/rails/engine.rb:547:in `load_seed'
/Users/libby/.gem/ruby/2.6.3/gems/activerecord-4.2.11/lib/active_record/tasks/database_tasks.rb:253:in `load_seed'
/Users/libby/.gem/ruby/2.6.3/gems/activerecord-4.2.11/lib/active_record/railties/databases.rake:173:in `block (2 levels) in <top (required)>'
/Users/libby/.gem/ruby/2.6.3/gems/rake-13.0.0/exe/rake:27:in `<top (required)>'
/Users/libby/.gem/ruby/2.6.3/gems/bundler-1.17.3/lib/bundler/cli/exec.rb:74:in `load'
/Users/libby/.gem/ruby/2.6.3/gems/bundler-1.17.3/lib/bundler/cli/exec.rb:74:in `kernel_load'
/Users/libby/.gem/ruby/2.6.3/gems/bundler-1.17.3/lib/bundler/cli/exec.rb:28:in `run'
/Users/libby/.gem/ruby/2.6.3/gems/bundler-1.17.3/lib/bundler/cli.rb:463:in `exec'
/Users/libby/.gem/ruby/2.6.3/gems/bundler-1.17.3/lib/bundler/vendor/thor/lib/thor/command.rb:27:in `run'
/Users/libby/.gem/ruby/2.6.3/gems/bundler-1.17.3/lib/bundler/vendor/thor/lib/thor/invocation.rb:126:in `invoke_command'
/Users/libby/.gem/ruby/2.6.3/gems/bundler-1.17.3/lib/bundler/vendor/thor/lib/thor.rb:387:in `dispatch'
/Users/libby/.gem/ruby/2.6.3/gems/bundler-1.17.3/lib/bundler/cli.rb:27:in `dispatch'
/Users/libby/.gem/ruby/2.6.3/gems/bundler-1.17.3/lib/bundler/vendor/thor/lib/thor/base.rb:466:in `start'
/Users/libby/.gem/ruby/2.6.3/gems/bundler-1.17.3/lib/bundler/cli.rb:18:in `start'
/Users/libby/.gem/ruby/2.6.3/gems/bundler-1.17.3/exe/bundle:30:in `block in <top (required)>'
/Users/libby/.gem/ruby/2.6.3/gems/bundler-1.17.3/lib/bundler/friendly_errors.rb:124:in `with_friendly_errors'
/Users/libby/.gem/ruby/2.6.3/gems/bundler-1.17.3/exe/bundle:22:in `<top (required)>'
/Users/libby/.gem/ruby/2.6.3/bin/bundle:23:in `load'
/Users/libby/.gem/ruby/2.6.3/bin/bundle:23:in `<main>'
Tasks: TOP => db:seed
(See full trace by running task with --trace)
```

Asked others, they thought I hadn't updated my `.env` file. Which I thought I had. Updated that. Didn't work. And have realised with seeing this when I opened up a new tab:

```bash
direnv: loading .envrc
direnv: export +AWS_ACCESS_KEY_ID +AWS_REGION +AWS_SECRET_ACCESS_KEY +GOOGLE_APPLICATION_CREDENTIALS +HTTP_AUTH_PASSWORD +INTERCOM_ANDROID_SECRET +INTERCOM_IOS_SECRET +INTER_ID +INTER_KEY +PARSE_APP_ID +PARSE_REST_KEY +S3_PATH +STORYPARK_KEY +STORYPARK_SECRET +STORYPARK_URL +YOUTUBE_TOKEN +ZENCODER_API_KEY
```

that I had reloaded the tab! Doh!! Actually went out of and back into the folder.

## Local development

Apps are run with `foreman`, currently can't getting `binding.pry` working when using this.

Workaround at the moment is to just run `rails s`, to get it working with the host set do `bundle exec rails s -b 0.0.0.0`.

The other things won't be running, but you can see what would be by looking at the `Procfile.dev` or just running the server with `foreman` and see what starts up.

Assets weren't loading. In the `Procfile.dev` it has this `./bin/webpack-dev-server` for webpack. Run this and then `rails s` and then the assets should load.

## Embedded coffeescript

<https://github.com/sstephenson/eco>






TODO

elastic beanstalk

- ec 2 instances

pry
show-source
show-source user.beta_options

Printing out `params` in Rails server, have to do `params.permit!` now, then you can use `params`

If ou did and just tried `params` then get this error `<ActionController::Parameters {"controller"=>"editor/stories", "action"=>"new"} permitted: false>`

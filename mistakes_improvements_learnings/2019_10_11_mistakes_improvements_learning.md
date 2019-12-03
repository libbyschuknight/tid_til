# October & November 2019 Mistakes, Improvements, Learning and Stuff

My mac at home needs to be updated. It is still on Sierra. I was doing some updating and upgrading of brew things and after when I tried to use irb, the arrow keys and using keys like `ctrl + a` had stopped working.

After some googling and trying to upgrade ruby-build and readline things, I searched in the work slack and got to this stack overflow post - <https://stackoverflow.com/questions/54261455/library-not-loaded-usr-local-opt-readline-lib-libreadline-7-dylib>.

Tried this:

```bash
cd /usr/local/opt/readline/lib
ln -s libreadline.8.dylib libreadline.7.dylib
```

And now keys are working when in irb! Yay!

## Gem versions

At work we have a core app which uses our admin pattern library gem. The APL gem has different versions.
I had everything working last week, so the page on the local server was working, and the integration test (using cucumbers and page object model) was working fine too!!

Come this week and the core app branch was out of date with master and the APL gem branch was out of date with master, so rebased them. Then I think I did something silly with the APL gem version in the core app.

We can do any of these:

```ruby
gem 'admin_pattern_library', :pgem => 'admin_pattern_library', :tag => 'v0.29.0' # point at a release, usually most recent
gem 'admin_pattern_library', :pgem => 'admin_pattern_library', :branch => 'deploy-apl-282' # point at a feature branch deploy branch
gem 'admin_pattern_library', :path => '../admin_pattern_library' # point at the gem locally, on computer
```

We think what happened was that I thought it was pointing to the gem that had a certain version that has `apl_fields_for` in it but it was actually not. Doh!

## [Sequel Pro](https://www.sequelpro.com/)

Good tool to use to figure out DB stuff.

Set it to local host, click connect, then choose a DB.

![sequel pro](sequel-pro.png)

## Run JS script in Chrome console

[Running a JavaScript file in Chrome](https://stackoverflow.com/questions/31186089/running-a-javascript-file-in-chrome)

>Have you tried to make a js snippet in chrome? You can find the snippets in Chrome Dev Tools -> Sources -> Snippets -> New -> Run.

## Upgrading to Catalina

1. Did the install thing

2. install xcode - `xcode-select --install`

3. `brew update`

4. `brew outdated` and upgrade all that are out of date

  - got stuck on updating zsh stuff, killed processes

  - ran `brew upgrade zsh` and said it was all installed.

5. Updated PS repo, ran migrations

## mysql lock timeout issue

Was getting this error:

```bash
Mysql2::Error::TimeoutError: Lock wait timeout exceeded; try restarting transaction: DELETE FROM `prices` /*application:Flux*/ (ActiveRecord::LockWaitTimeout)
```

When running a cucumber feature test.

Colleague suggested I did this `bundle exec rails db:test:nuke` with this doing:

```ruby
require 'fileutils'

namespace :db do
  namespace :test do
    desc "Nuke the test database and recreate it"
    task :nuke do
      if Rails.env.test?
        FileUtils.copy("db/test_structure.sql", "db/structure.sql")
        begin
          Rake::Task["db:drop"].invoke
          Rake::Task["db:create"].invoke
          Rake::Task["db:structure:load"].invoke
          Rake::Task["db:migrate"].invoke
        ensure
          FileUtils.rm("db/structure.sql")
        end
      else
        # TODO: remove DISABLE_DATABASE_ENVIRONMENT_CHECK after migration to Rails 5 is completed
        system("RAILS_ENV=test DISABLE_DATABASE_ENVIRONMENT_CHECK=1 RERUN_BUNDLER_SETUP=1 bundle exec rake db:test:nuke")
      end
    end
  end
end
```

It, however, got stuck  doing the `db` taks. We then killed it and stop and started MariaDB:

```bash
brew services stop mariadb

brew services start mariadb
```

Then run the `nuke` command again and the db tasks worked.

Arghhhh! But then it stopped working again and the `nuke` command wouldn't work.

Asked in work slack:

>Afternoon all! I was getting this area a couple of hours ago when I was running a feature spec
>
>`Mysql2::Error::TimeoutError: Lock wait timeout exceeded; try restarting transaction: DELETE FROM `prices` /*application:Flux*/ (ActiveRecord::LockWaitTimeout)`.
>
>We sorted it by doing first trying au be rails db:test:nuke, which seemed to get stuck on the db drop, then we did:
>
>```bash
>brew services stop mariadb
>brew services start mariadb
>au be rails db:test:nuke
>```
>
>Then the tests ran again and it was good in the world.
>However, it then broke again and it gets stuck on the db nuke. And stopping and starting >mariadb doesn't seem to make any difference. Any ideas anyone?
>
>EF
>Check if you are not running two instances of mysql.
>
>libby:fluxy:  4 minutes ago
>I had this
>
>```bash
>$ brew services list
>Name         Status  User  Plist
>chromedriver stopped
>mariadb      started libby /Users/libby/Library/LaunchAgents/homebrew.mxcl.mariadb.plist
>mariadb@10.3 started libby /Users/libby/Library/LaunchAgents/homebrew.mxcl.mariadb@10.3.plist
>postgresql   started libby /Users/libby/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
>verm         started libby /Users/libby/Library/LaunchAgents/homebrew.mxcl.verm.plist
>```
>
>then stopped the mariadb's
>
>Now get
>
>```bash
>Name         Status  User  Plist
>chromedriver stopped
>mariadb      stopped
>mariadb@10.3 stopped
>postgresql   started libby /Users/libby/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
>verm         started libby /Users/libby/Library/LaunchAgents/homebrew.mxcl.verm.plist
>```
>
>I think before I just stopped the mariadb one.
>Do I need to start mariadb or mariadb@10.3 before running au be rails db:test:nuke again?
>(did start `mariadb10.3)
>
>libby:fluxy:  1 minute ago
>Oh yay it is working now! Was what you said Erik, thanks. probably should remove mariadb? and just have mariadb10.3.

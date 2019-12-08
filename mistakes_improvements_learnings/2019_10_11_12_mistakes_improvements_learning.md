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

## More DB issues!<!--   -->

Arhhhhh! I'm getting this table doesn't exist error again but for a different table (after pulling down master)
RETAILER=psuk COUNTRY=uk bundle exec rails db:migrate db:test:prepare
== 20190910035711 RemoveDefaultEmailFromFieldServiceContractor: migrating =====
-- remove_column(:field_service_contractors, :default_recipient_address, :string)
rails aborted!
StandardError: An error has occurred, all later migrations canceled:
Mysql2::Error: Table 'core_development_psuk.field_service_contractors' doesn't exist: ALTER TABLE `field_service_contractors` DROP COLUMN `default_recipient_address` /*application:Flux*/
/Users/libby/flux/powershop/db/migrate/20190910035711_remove_default_email_from_field_service_contractor.rb:3:in `change'
bin/rails:4:in `<main>'
Caused by:
ActiveRecord::StatementInvalid: Mysql2::Error: Table 'core_development_psuk.field_service_contractors' doesn't exist: ALTER TABLE `field_service_contractors` DROP COLUMN `default_recipient_address` /*application:Flux*/
/Users/libby/flux/powershop/db/migrate/20190910035711_remove_default_email_from_field_service_contractor.rb:3:in `change'
bin/rails:4:in `<main>'
Caused by:
Mysql2::Error: Table 'core_development_psuk.field_service_contractors' doesn't exist
/Users/libby/flux/powershop/db/migrate/20190910035711_remove_default_email_from_field_service_contractor.rb:3:in `change'
bin/rails:4:in `<main>'
Tasks: TOP => db:migrate
have tried droppping
RETAILER=psuk COUNTRY=uk bundle exec rails db:drop
Mysql2::Error: Error dropping database (can't rmdir './core_development_psuk', errno: 66 "Directory not empty"): DROP DATABASE IF EXISTS `core_development_psuk` /*application:Flux*/
Couldn't drop database 'core_development_psuk'
rails aborted!
ActiveRecord::StatementInvalid: Mysql2::Error: Error dropping database (can't rmdir './core_development_psuk', errno: 66 "Directory not empty"): DROP DATABASE IF EXISTS `core_development_psuk` /*application:Flux*/
bin/rails:4:in `<main>'
Caused by:
Mysql2::Error: Error dropping database (can't rmdir './core_development_psuk', errno: 66 "Directory not empty")
bin/rails:4:in `<main>'
Tasks: TOP => db:drop:_unsafe
if I try and drop within mysql
 mysql -h localhost -u root
MariaDB [(none)]> drop database core_development_psuk;
get
ERROR 1010 (HY000): Error dropping database (can't rmdir './core_development_psuk', errno: 66 "Directory not empty")
Anyone got any ideas? Is there a way I can get rid of everything and start from scratch? ta


Colleagues suggestion:

you can start from scratch by deleting your MariaDB database data directory
sudo rm -rf /var/lib/mysql
to recreate the data directory
mysql_install_db --datadir=/var/lib/mysql
then you should be able to db:create db:migrate

Following is the steps I have followed:

Delete the `mysql` folder whre the MariaDB database data directory is:

```bash
sudo rm -rf /usr/local/var/mysql # remove the mysql folder on the mac

# had this in it
# /usr/local/var/mysql
$ ls

Libbys-MacBook-Pro-slow.log  core_development_psnz        mysql
Libbys-MacBook-Pro.local.err core_development_psuk        performance_schema
Libbys-MacBook-Pro.local.pid core_test                    playground
aria_log.00000001            ib_buffer_pool               playground_test
aria_log_control             ib_logfile0                  powershop_development_uk
binlog.index                 ib_logfile1                  powershop_test
blueprint_development        ibdata1                      tc.log
blueprint_test               ibtmp1                       test
core_development_psau        multi-master.info
```

The `/usr/local/var/mysql` folder no longer exists.

Recreate the data directory

```bash
mysql_install_db --datadir=/usr/local/var/mysql
```

Got this message output having running the above, not sure if need to do all of it.

```bash
Installing MariaDB/MySQL system tables in '/usr/local/var/mysql' ...
OK

To start mysqld at boot time you have to copy
support-files/mysql.server to the right place for your system


PLEASE REMEMBER TO SET A PASSWORD FOR THE MariaDB root USER !
To do so, start the server, then issue the following commands:

'/usr/local/Cellar/mariadb@10.3/10.3.20_1/bin/mysqladmin' -u root password 'new-password'
'/usr/local/Cellar/mariadb@10.3/10.3.20_1/bin/mysqladmin' -u root -h Libbys-MacBook-Pro.local password 'new-password'

Alternatively you can run:
'/usr/local/Cellar/mariadb@10.3/10.3.20_1/bin/mysql_secure_installation'

which will also give you the option of removing the test
databases and anonymous user created by default.  This is
strongly recommended for production servers.

See the MariaDB Knowledgebase at http://mariadb.com/kb or the
MySQL manual for more instructions.

You can start the MariaDB daemon with:
cd '/usr/local/Cellar/mariadb@10.3/10.3.20_1' ; /usr/local/Cellar/mariadb@10.3/10.3.20_1/bin/mysqld_safe --datadir='/usr/local/var/mysql'

You can test the MariaDB daemon with mysql-test-run.pl
cd '/usr/local/Cellar/mariadb@10.3/10.3.20_1/mysql-test' ; perl mysql-test-run.pl

Please report any problems at http://mariadb.org/jira

The latest information about MariaDB is available at http://mariadb.org/.
You can find additional information about the MySQL part at:
http://dev.mysql.com
Consider joining MariaDB's strong and vibrant community:
https://mariadb.org/get-involved/
```

Didn't do any of the above but did run a `setup script` that was specific to Flux. Which does some brew stuff, mariaDB set up stuff, verm stuff, SSl stuff, Ruby setup stuff, database setup stuff.

Then started creating the databases:

```bash
RETAILER=psnz COUNTRY=nz SCHEMA=db/test_structure.sql bundle exec rails db:create db:structure:load
```

Didn't work, got this:

```bash
Mysql2::Error: Can't create database 'core_development_psnz' (errno: 2 "No such file or directory")
```

```bash
# using `--trace`
** Invoke db:create (first_time)
** Invoke db:load_config (first_time)
** Invoke environment (first_time)
** Execute environment
** Execute db:load_config
** Execute db:create
Mysql2::Error: Can't create database 'core_development_psnz' (errno: 2 "No such file or directory"): CREATE DATABASE `core_development_psnz` DEFAULT COLLATE `utf8_general_ci` /*application:Flux*/
Couldn't create 'core_development_psnz' database. Please check your configuration.
```

Tried these:

```bash
'/usr/local/Cellar/mariadb@10.3/10.3.20_1/bin/mysqladmin' -u root password 'new-password'
'/usr/local/Cellar/mariadb@10.3/10.3.20_1/bin/mysqladmin' -u root -h Libbys-MacBook-Pro.local password 'new-password'
```

and now get:

```bash
> psnz nz be rails db:create --trace

** Invoke db:create (first_time)
** Invoke db:load_config (first_time)
** Invoke environment (first_time)
** Execute environment
** Execute db:load_config
** Execute db:create
Access denied for user 'root'@'localhost' (using password: NO)
Couldn't create 'core_development_psnz' database. Please check your configuration.
```

Can't figure out how to change the password for the root user.

Done these two steps again:

```bash
sudo rm -rf /usr/local/var/mysql

mysql_install_db --datadir=/usr/local/var/mysql
```

error!!

```bash
psnz nz be rails db:create --trace
** Invoke db:create (first_time)
** Invoke db:load_config (first_time)
** Invoke environment (first_time)
** Execute environment
** Execute db:load_config
** Execute db:create
Access denied for user 'root'@'localhost' (using password: NO)
Couldn't create 'core_development_psnz' database. Please check your configuration.
rails aborted!
Mysql2::Error::ConnectionError: Access denied for user 'root'@'localhost' (using password: NO)
```

Uninstalled mariadb:

```bash
brew uninstall mariadb
brew uninstall mariadb@10.3
```

Removed the `mysql` folder again.

Then ran the work setup script that will install and setup mariadb@10.3.

But no go, still get `Access denied for user 'root'@'localhost' (using password: NO)` and it won't create anything :(


```bash
sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/usr/local/var/mysql
```

Doesn't change anything, same error.

Okay. Think have got it sorted!! fingers crossed!!

Was having an issue with the `mysql` password, which I think was clashing somehow with the password set to blank in the PS codebase `database.yml` file.

What I have done which seems to have worked is:

- made sure that in the `database.yml` file that nothing was set for the password
- to change the mysql password (which I had set when following the output from this command `mysql_install_db --datadir=/usr/local/var/mysql` see above)
  - followed this <https://gist.github.com/zubaer-ahammed/c81c9a0e37adc1cb9a6cdc61c4190f52,> actual steps I did were:

    > Make sure you have Stopped MySQL first (above).
    Stop `mariadb@10.3` and therefore `mysql` - `brew services stop mariadb@10.3`

    >Run the server in safe mode with privilege bypass: sudo mysqld_safe --skip-grant-tables
    `sudo mysqld_safe --skip-grant-tables`

    >In a new window connect to the database, set a new password and flush the permissions & quit: mysql -u root
    This was tripping me up as I would do this and then it would give me a `ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/tmp/mysql.sock' (2)` error.

    What I did was start `mariadb@10.3` - `brew services start mariadb@10.3`.

    I don't think `mysql -u root` worked, think `mysql -u root -p` got me into `mariadb`

    >For MySQL 5.7+ use:
    Checked which version of MySql `mariadb@10.3 uses and think I was right in choosing this.

    >UPDATE mysql.user SET authentication_string=PASSWORD("rootpass") WHERE User='root';
    `UPDATE mysql.user SET authentication_string=PASSWORD("") WHERE User='root';

    >Now flush privileges:
    >FLUSH PRIVILEGES;
    `FLUSH PRIVILEGES;`

    >Restart MySQL server.
    Think `mariadb@10.3` was already running but if not do `brew services start mariadb@10.3`

Then `RETAILER=psnz COUNTRY=nz bundle exec lib/db_refresh.rb`.

I think this was also an issue, previously I had been running `COUNTRY=nz bundle exec lib/db_refresh.rb` as I hadn't caught up with the fact that we needed to add the retailer flag now.

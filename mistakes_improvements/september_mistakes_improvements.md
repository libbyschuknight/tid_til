# September Mistakes & Improvements

#### Issue with failed build on Travis

Updated `nokogiri`, worked fine locally, but failed on Travis with this error:

```shell
Gem::Ext::BuildError: ERROR: Failed to build gem native extension.
current directory:
/home/travis/build/FlickElectric/customer_app/vendor/bundle/ruby/2.2.0/gems/nokogiri-1.8.0/ext/nokogiri
/home/travis/.rvm/rubies/ruby-2.2.4/bin/ruby -r
./siteconf20170907-5464-1dsxymo.rb extconf.rb
checking if the C compiler accepts ... yes
Building nokogiri using packaged libraries.
*** extconf.rb failed ***
Could not create Makefile due to some reason, probably lack of necessary
libraries and/or headers.  Check the mkmf.log file for more details.  You may
need configuration options.
Provided configuration options:
	--with-opt-dir
	--without-opt-dir
	--with-opt-include
	--without-opt-include=${opt-dir}/include
	--with-opt-lib
	--without-opt-lib=${opt-dir}/lib
	--with-make-prog
	--without-make-prog
	--srcdir=.
	--curdir
	--ruby=/home/travis/.rvm/rubies/ruby-2.2.4/bin/$(RUBY_BASE_NAME)
	--help
	--clean
	--use-system-libraries
/home/travis/.rvm/rubies/ruby-2.2.4/lib/ruby/site_ruby/2.2.0/rubygems/dependency.rb:310:in
'to_specs': Could not find 'mini_portile2' (~> 2.2.0) - did find:
[mini_portile2-2.1.0] (Gem::MissingSpecVersionError)
Checked in
'GEM_PATH=/home/travis/build/FlickElectric/customer_app/vendor/bundle/ruby/2.2.0',
execute `gem env` for more information
from
/home/travis/.rvm/rubies/ruby-2.2.4/lib/ruby/site_ruby/2.2.0/rubygems/dependency.rb:320:in
'to_spec'
from
/home/travis/.rvm/rubies/ruby-2.2.4/lib/ruby/site_ruby/2.2.0/rubygems/core_ext/kernel_gem.rb:65:in
'gem'
  from extconf.rb:460:in '<main>'`
```

Did notice this

```shell
'to_specs': Could not find 'mini_portile2' (~> 2.2.0) - did find:
[mini_portile2-2.1.0] (Gem::MissingSpecVersionError)
```

But didn't pay much attention to it.'

Asked for help on Ruby slack and got this reply:

>might need to `bundle update mini_portile2` - https://rubygems.org/gems/nokogiri/versions/1.8.0 depends on version `~> 2.2.0`, but it looks like according to that stack trace `2.1.0` is in your Gemfile.lock

And that was it, updated `mini_portile2` and all was good in the world!!


#### Issue with AWS error

```
14:03:15 web.1  | Aws::SQS::Errors::InvalidClientTokenId - The security token included in the request is invalid.:
```

There were AWS credentials in the `.env` file and I added my to the `.env.development`, still got some error.

Asked a collegue and I said I thought I had come cross this error before, we searched slack for `InvalidClientTokenId` and wouldn't you know it, found this:

>So FYI for everyone else, wasn’t my creds that were wrong, in the `.env.test` there were other AWS creds that were wrong! Solving meant replacing test creds with mine, which meant at present the VCR recording has my creds in. Which I will remove before pushing anything to github and I will revert the creds in  `.env.test` '

In this case it was the other creds in the `.env` file that were the probably.


### RSpec test error

When get this error:

```shell
$ bundle exec rake db:test:prepare

rake aborted!
NoMethodError: undefined method `+' for nil:NilClass
/Users/libby/code/customer_app/config/environment.rb:5:in `<top (required)>'
/Users/libby/.rbenv/versions/2.2.3/bin/bundle:23:in `load'
/Users/libby/.rbenv/versions/2.2.3/bin/bundle:23:in `<main>'
Tasks: TOP => db:test:prepare => environment
(See full trace by running task with --trace)
```

Was fixed by adding in a `.env.development` file.

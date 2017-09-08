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

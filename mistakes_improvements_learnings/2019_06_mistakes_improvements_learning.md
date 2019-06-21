# June 2019 Mistakes, Improvements, Learning and Stuff

## `bundle` / `bundler` issues!!

Did a `bundle install` and some how it decdied to update the `BUNDLED WITH` bit in `Gemfile.lock`  from `1.17.1` to `1.17.3`. However, for this app we need to keep it at `1.17.1`. So then I started looking into what I needed to do to have it bundle with `1.17.1`.

I should have been able to uninstall the `1.17.3` version and the have it work with the `.1.17.1` version.

I think I should have also been able to have run this `bundle _1.17.1_ install` and it should have run it with that version, but this wasn't working either. After discussion and help from colleagues we decided to re-install the ruby version.

I am using `rbenv` and the version is `2.4.5`. So uninstalled it, have ran `rbenv install 2.4.5` but it has hung on
`ruby-build: use readline from homebrew`

A google tells me that `readline` has been a problem - https://github.com/rbenv/ruby-build/issues/1064

Tried reinstalling `rbenv` but it was already up to date.

Trying this

```bash
RUBY_CONFIGURE_OPTS=--with-readline-dir="$(brew --prefix readline)" rbenv install 2.4.5
```
Hmmm but this seems to not be working for me..... it seems to be hanging as well. This didn't even get to the `ruby-build: use readline from homebrew` line, which `rbenv install 2.4.5` does.

Trying `rbenv install 2.4.5` again.

May try uninstalling `rbenv` and `ruby-build` and then trying again. This is one suggest in the above issue. Or at least re-installing `rbenv`.

Tried "`gem pristine --all` to rebuild all your native extensions, including those which depend on the GNU readline library. should fix it" but as I had uninstalled the ruby version, it couldn't do that.

So uninstalled and reinstalled `rbenv` and did `rbenv install 2.4.5` again and it is at `ruby-build: use readline from homebrew` again.......

Trying this `brew reinstall readline`... it re-installed.

Trying `rbenv install 2.4.5` again....nope still hadn't got any further after 20 mins.

Trying this again `RUBY_CONFIGURE_OPTS=--with-readline-dir="$(brew --prefix readline)" rbenv install 2.4.5`

So it turns out that I was just not waiting long enough for `rbenv` to do its install thing. I think with anti virus software we now have on our computers it takes extra long to get stuff installed.

It took about half an hour to install using `rbenv install 2.4.5`.

Rest of the fix was then just specifying bundler version when i did `gem install bundler -v 1.17.1`.

## Cario issue

Then had an issue when running `bundle install` on the master branch:

```bash
Using pkg-config 1.2.8
Fetching cairo 1.15.10
Installing cairo 1.15.10 with native extensions
Gem::Ext::BuildError: ERROR: Failed to build gem native extension.
    current directory: /Users/libby/.rbenv/versions/2.4.5/lib/ruby/gems/2.4.0/gems/cairo-1.15.10/ext/cairo
/Users/libby/.rbenv/versions/2.4.5/bin/ruby -r ./siteconf20190605-56681-oixss6.rb extconf.rb
checking for GCC... yes
checking for Win32 OS... no
checking for cairo version (>= 1.2.0)... yes
*** extconf.rb failed ***
Could not create Makefile due to some reason, ...

An error occurred while installing cairo (1.15.10), and Bundler cannot continue.
Make sure that `gem install cairo -v '1.15.10' --source 'https://rubygems.org/'` succeeds before bundling.

In Gemfile:
  rsvg2 was resolved to 3.2.1, which depends on
    cairo-gobject was resolved to 3.2.1, which depends on
      cairo
```

Searched on company slack and other people have had this. Suggested fix was:

```bash
export PKG_CONFIG_PATH=/usr/local/Cellar/libffi/3.2.1/lib/pkgconfig/
gem install cairo -v '1.15.10' --source 'https://rubygems.org/'
```

## `bundle update` issue

With a gem we have, to update it in our main rails up, we need to do `bundle update --conservative admin_pattern_library` so that only the sha of the gem gets updated.

This rails app uses `bundler 1.17.1`, however 2 plus is that up to date version for `bundler` and every time I run `bundle update --conservative admin_pattern_library`, which I haven't need to do often, it also updates the `bundler` version and I forget to check my change properly and push and then everything stops working!!!

So to fix, I had to undo commit and disgard changes in the `Gemfile && Gemfile.lock` and then I figured out that I can do `bundle _1.17.1_ update --conservative admin_pattern_library`, which will keep the `bundler` version at `1.17.1` and not update it to `2.x.x`. Yay!

## `jQuery.ajax` call

http://api.jquery.com/jquery.ajax/

An old javascript page is using this `.ajax` call:

```js
Application.updateEstimates = function() {
  function postAjax(url, data) {
    return jQuery.ajax({
      method: "POST", // Modern jQuery
      type: "POST",   // Ancient jQuery
      data: data,
      url: url,
      beforeSend: setCsrfHeader
    });
  }

  // Registers a single click event on the container that gets rendered by react-rails.
  // That container can only be clicked once it actually has any content inside which is our
  // way to ensure that the input field of the React component has rendered.
  const DateWrapper = document.querySelector('[data-id="date-wrapper"]');

  if (DateWrapper) {
    var url = DateWrapper.dataset.url;

    jQuery('#estimate-spinner').show();

    var data = jQuery('#date-form').serialize();

    postAjax(url, data)
      .complete(function() { jQuery('#estimate-spinner').hide(); });
  }
};
```

This is then doing stuff on a Rails page and is it working within Rails-React.

http://api.jquery.com/Ajax_Events/ -  see here for what `.complete` does.


## https issue

```
Mixed Content: The page at 'https://schuknight.com/js-memory-cards/' was loaded over HTTPS, but requested an insecure script 'http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js'. This request has been blocked; the content must be served over HTTPS.
```

solution:
https://stackoverflow.com/questions/18251128/why-am-i-suddenly-getting-a-blocked-loading-mixed-active-content-issue-in-fire

Update the `http` part of url to `https`.

## `npm` error - `node`, `yarn`

Just using `nvm`!!!

https://github.com/nvm-sh/nvm

## Handy tip about reversing the order of WordPress blog posts

I wanted to share all of my blog posts about my journay at EDA. I have tagged them all - https://schuknight.wordpress.com/category/eda/, but this is most recent to least. I thought it would make more sense to have least recent (oldest) to most recent (newest).

https://en.support.wordpress.com/show-your-posts-in-chronological-order/

And you can by adding `?order=asc`, to the end of a url - https://schuknight.wordpress.com/category/eda/?order=asc

Handy!!

## MYSQL issues, again

Was getting this error:

```bash
> psau au SCHEMA=db/test_structure.sql bundle exec rails db:create db:structure:load

Can't connect to local MySQL server through socket '/tmp/mysql.sock' (38)
Couldn't create 'powershop_development_au' database. Please check your configuration.
rails aborted!
Mysql2::Error::ConnectionError: Can't connect to local MySQL server through socket '/tmp/mysql.sock' (38)
bin/rails:4:in `<main>'
Tasks: TOP => db:create
(See full trace by running task with --trace)
```

Tried a number of things particular to work, running our script setup file, which seems to have worked fine. And then lots of suggestions by others who have come across the problem in our slack channel.

BUT was heading down the wrong rabbit hole!

Got help from colleague and we did this:

- uninstalled mysql-client / mariadb
- ran `./script/setup.sh` again (script for work to get stuff set up)
- did kitchen sync (setting up of database data) but got this error:

```
Kitchen Sync
dyld: Library not loaded: /usr/local/opt/mysql-client/lib/libmysqlclient.20.dylib
  Referenced from: /usr/local/bin/ks_mysql
  Reason: image not found
Connection closed
Connection closed
Connection closed
Connection closed
Kitchen Syncing failed.
/Users/libby/flux/powershop/lib/partial_sync/runner.rb:73:in `run_ks': PartialSync::Runner::SystemCommandError (PartialSync::Runner::SystemCommandError)
	from /Users/libby/flux/powershop/lib/partial_sync/runner.rb:13:in `build_table_structure'
	from lib/db_refresh.rb:78:in `<main>'`
```
as it turns out, I hadn't yet re-installed `mysql-client` doh! `brew instasll mysql-client`

- now kitchen sync works beautifully!!

## CSS figuring out!! Use 100% for height

[use 100% height - Natours](../html_css_sass_etc/notes_adv_css_sass_udemy_course.md##issue-with-height-of-feature-boxes)


## VoiceOver User Guide (mac)

https://help.apple.com/voiceover/mac/10.14/

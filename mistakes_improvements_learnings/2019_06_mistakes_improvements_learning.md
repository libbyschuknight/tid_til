# June 2019 Mistakes, Improvements, Learning and Stuff

## `bundle` / `bundler` issues!!

Did a `bundle install` and some how it decdied to update the `BUNDLED WITH` bit in `Gemfile.lock`  from `1.17.1` to `1.17.3`. However, for this app we need to keep it at `1.17.1`. So then I started looking into what I needed to do to have it bundle with `1.17.1`.

I should have been able to uninstall the `1.17.3` version and the have it work with the `.1.17.1` version.

I think I should ahve also been able to have run this `bundle _1.17.1_ install` and it should have run it with that version, but this wasn't working either. After discussion and help from collegnues we decided to re-install the ruby version.

I am using `rbenv` and the version is `2.4.5`. So uninbstalled it, have ran `rbenv install 2.4.5` but it has hung on
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

Rest of the fix was then just specifying bundler verisign when i did `gem install bundler -v 1.17.1`.

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

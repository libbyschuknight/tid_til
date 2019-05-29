# May 2019 Mistakes, Improvements, Learning and Stuff

## Changing to using `yarn`

With our gem that we have been developing, we did start with using `npm` but due to issues with the locking down of dependecies we have changed to using `yarn`.

Using `yarn` allows us to do this
```json
"resolutions": {
  "node-sass/node-gyp/tar": "4.4.8"
}
```
Which is pinning down a version of a sub-dependency. When we were using `npm` we did this by editing the package-lock.json file, which is really bad practice.

So, to get started:

```bash
yarn install
# like bundle install
# could just use `yarn`
```

Within the gem for viewing the Storybook pages:

```bash
yarn start

# which does this:
$ run-p storybook build:dev:watch
$ start-storybook -s ./public -p 6006 --ci
$ yarn build:dev --watch
$ webpack --config webpack.dev.js --watch
```

Is building and starting the Storybook stuff, then building the dev build and getting webpack to watch. So that means that I will have the dev build and it will be watched for any changes to the code so I shouldn't have to reload the Storybook pages.


## React - `oneOfType`

Having the right brackets!!

```js
// This is missing the [], got an error that was hard to figure out
optionalUnion: PropTypes.oneOfType(
  PropTypes.string,
  PropTypes.number,
  PropTypes.instanceOf(Message)
),


// An object that could be one of many types
optionalUnion: PropTypes.oneOfType([
  PropTypes.string,
  PropTypes.number,
  PropTypes.instanceOf(Message)
]),
```

And then with this

```js
const disableEnableDatesPropTypes = PropTypes.oneOfType([
  PropTypes.arrayOf(PropTypes.func),
  PropTypes.arrayOf(datePropTypes),
  PropTypes.arrayOf(
    PropTypes.shape({
      from: datePropTypes,
      to: datePropTypes,
    }),
  ),
]);

// ...

DateStuff.defaultProps = {
  disableDates:       [], // had this has `null` but because it is expecting an error it was getting a slice error
};
```


## Another myqsl issue

Had pulled down latest master branch, went to do the migrations etc

```bash
au be rails db:migrate db:test:prepare
```
Got this error:

```bash
rails aborted!
Mysql2::Error::ConnectionError: Can't connect to local MySQL server through socket '/tmp/mysql.sock' (2)
bin/rails:4:in `<main>'
Tasks: TOP => db:migrate
(See full trace by running task with --trace)
```

ran

```bash
./script/setup.sh
```

Got these errors:

```bash
Installing rbenv
Error: ruby-build 20190423 already installed
Installing ruby-build has failed!
Using verm
Using ghostscript
Installing librsvg
Error: openssl 1.0.2r already installed
Installing openssl has failed!
Installing mariadb@10.3
Installing chromedriver
Homebrew Bundle failed! 2 Brewfile dependencies failed to install.
Since it said that ruby-build and openssl were already installed did rbenv reash -  https://github.com/rbenv/rbenv#rbenv-rehash
and then run the script set up again and then everything worked
```

Since it said that ruby-build and openssl were already installed did rbenv reash -  https://github.com/rbenv/rbenv#rbenv-rehash
and then run the script set up again and then everything worked.


## yarn, rails and building assets

Was trying to get a change working from gem into the rails app we have. We are now using `yarn` for the building of the gem assets.

I hadn't done a `yarn build` for awhile so this was way my rails app wasn't picking up the changes.

We debugged this by using the `.dev` version of the gem in the rails app, as we could see that the dates were being passed into the react component but the component wasn't doing what it was suppose to be doing.

## `bundle update`

Working with a rails app and a gem that using in this app. Needed to make changes to the gem and then test in the rails app. There were no changes to the rails app.
Needed to get the gem changes working in the rails app, in a deploy branch. So the rails app has in the gemfile:

```gemfile
GIT
  remote: git@git.xxx.com:powergems/apl-gem.git
  revision: 2ec871eeac7557d941d03bf1f63b8008d0b2805e
  branch: deploy-branch-a
  specs:
    apl-gem (0.1.0)
      rails (~> 5.2.2)
      react-rails (~> 2.4.7)
```

So it is pointing to a certain remote, branch and commit. I needed the commit to change. I needed up update the gem but only this gem, not the other gems in this rails app.

The answer is:

```bash
bundle update apl-gem --conservative
```

https://bundler.io/man/bundle-update.1.html

>`--conservative`
>Use bundle install conservative update behavior and do not allow shared dependencies to be updated.


[A Guide to Update Gems with bundle update: Tips and tricks to master bundle update by following incremental, controlled and safe steps](https://medium.com/cedarcode/reduce-fear-of-bundle-update-with-this-4-step-process-e021e8808c48)

>### Step 2 — Update “Non-production” gems
>`$ bundle update --conservative --group test development`
>
>Bundler’s --conservative option prevents updates in any “Production” gem that is also a dependency of a“Non-production” gem.

[Updating Gems cheat sheet: Using Bundler’s advanced features](https://medium.com/cedarcode/updating-gems-cheat-sheet-346d5666a181)


## Chromedriver issues with cucumbers

Got this error

`unable to connect to chromedriver 127.0.0.1:9515 (Selenium::WebDriver::Error::WebDriverError)`

Suggestions from collegues when other people had same issue (from Slack):

>what does `which chromedriver` get you?

give me this:
`/Users/libby/.rbenv/shims/chromedriver`

> if you have `.rbenv/shims/chromedriver`, you may need to `gem uninstall chromedriver-helper`

>also, `rm .rbenv/shims/chromedriver`, and run `which chromedriver` again - it should point to a different one, and from then your cukes will work

Removed `.rbenv/shims/chromedriver`` but didn't uninstall the gem.

Restarted terminal and getting this again:

```bash
$ which chromedriver
/Users/libby/.rbenv/shims/chromedriver
```

```bash
$ chromedriver -v
ChromeDriver 75.0.3770.8 (681f24ea911fe754973dda2fdc6d2a2e159dd300-refs/branch-heads/3770@{#40})
```

But my version of Chrome is `Version 74.0.3729.169 (Official Build) (64-bit)`, so it seems ChromeDriver is using a newer version then what Chrome is it.

What I have done:

`gem uninstall chromedriver-helper`

restarted the terminal

```bash
$ which chromedriver
/usr/local/bin/chromedriver
```

```bash
$ chromedriver -v
ChromeDriver 74.0.3729.6 (255758eccf3d244491b8a1317aa76e1ce10d57e9-refs/branch-heads/3729@{#29})
```

My cucumber test is now working!! Yay!

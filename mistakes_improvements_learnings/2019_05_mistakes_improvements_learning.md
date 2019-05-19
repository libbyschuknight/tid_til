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

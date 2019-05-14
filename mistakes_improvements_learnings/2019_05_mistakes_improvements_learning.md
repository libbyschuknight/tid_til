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

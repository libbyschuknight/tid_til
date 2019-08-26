# APL commands

(work gem)

## Setup Commands

```bash
bin/setup
yarn install
yarn build
yarn watch # will build assets if changes are made ??
```

## Tests and Linting

```bash
bundle exec rspec
bundle exec rubocop
yarn test
yarn lint
```

### Turn on watching of tests

This will run tests when any changes have been made.

```bash
yarn watch:test
```

## Start Storybook

```bash
yarn start
```

# Core / Flux app

To install APL gem:

```
bundle _1.17.3_ update --conservative admin_pattern_library
```

Flagging version of `bundler` to make sure that uses correct version and doesn't update to a newer version I have on my computer

## Set the development version of React for localhost

To see the development React version in localhost, in `app/assets/javascripts/admin.js` change `//= require admin_pattern_library` to be `//= require admin_pattern_library.dev`.
So, add `.dev` to the end.

You may also need to do:
- `yarn build` in the APL gem repo
- `au bundle exec rails assets:clobber` in the core app repo
- then restart the server and you should be able to see the full react components in the React console

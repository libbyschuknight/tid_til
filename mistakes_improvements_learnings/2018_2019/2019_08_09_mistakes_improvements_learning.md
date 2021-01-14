# August & September 2019 Mistakes, Improvements, Learning and Stuff

## Cucumber vs POM

Updating code with new components from new pattern library that don't work with Cucumber steps.

<!-- add notes!!! -->

## npm audit

On GitLab CI for our pattern library gem, which has node packages in it, we run `yarn audit` via the `.gitlab-ci.yml` file

```yaml
node:
  image: node:10
  stage: test
  except:
    - tags
    - schedules
    - /^deploy-.*$/
  script:
    - node -v
    - yarn -v
    - yarn install --frozen-lockfile
    - yarn build
    - yarn audit
    - yarn check-license
    - yarn test
    - yarn lint:js
    - yarn lint:scss

node-audit:
  image: node:10
  stage: test
  only:
    - schedules
  script:
    - node -v
    - yarn -v
    - yarn audit
```

When `yarn audit` fails, we get a slack message in our team channel:

>apl-audit-failure APP 04:19
>powergems/admin_pattern_library: Pipeline #48034 of branch master failed in 00:33

![audit-fix-slack-message](audit-fix-slack-message.png)

The most recent failure was this - <https://www.npmjs.com/advisories/1118>.

The steps I took to get this fixed:

- locally made sure had up to date code
- run `yarn audit` locally, which gives this output

  ```bash
  $ yarn audit

  yarn audit v1.16.0
  ┌───────────────┬──────────────────────────────────────────────────────────────┐
  │ critical      │ Arbitrary Code Execution                                     │
  ├───────────────┼──────────────────────────────────────────────────────────────┤
  │ Package       │ eslint-utils                                                 │
  ├───────────────┼──────────────────────────────────────────────────────────────┤
  │ Patched in    │ >=1.4.1                                                      │
  ├───────────────┼──────────────────────────────────────────────────────────────┤
  │ Dependency of │ eslint                                                       │
  ├───────────────┼──────────────────────────────────────────────────────────────┤
  │ Path          │ eslint > eslint-utils                                        │
  ├───────────────┼──────────────────────────────────────────────────────────────┤
  │ More info     │ https://www.npmjs.com/advisories/1118                        │
  └───────────────┴──────────────────────────────────────────────────────────────┘
  1 vulnerabilities found - Packages audited: 924842
  Severity: 1 Critical
  ✨  Done in 2.81s.
  ```

  You can see that the packages that is affect (`eslint-utils`), is as dependency for `eslint`.
  So `eslint` needs to be updated.

- ran `yarn upgrade eslint`

  ```bash
  $ yarn upgrade eslint

  yarn upgrade v1.16.0
  [1/4] 🔍  Resolving packages...
  [2/4] 🚚  Fetching packages...
  [3/4] 🔗  Linking dependencies...
  [4/4] 🔨  Rebuilding all packages...
  success Saved lockfile.
  success Saved 40 new dependencies.
  info Direct dependencies
  └─ eslint@5.16.0
  info All dependencies
  ...
  ├─ eslint-utils@1.4.2
  ├─ eslint@5.16.0
  ...
  ✨  Done in 23.13s.
  ```

  It updated a bunch of stuff including `eslint-utils`

- checked with `yarn audit`

  ```bash
  $ yarn audit

  yarn audit v1.16.0
  0 vulnerabilities found - Packages audited: 924843
  ✨  Done in 2.06s.
  ```

- checked that `yarn lint` still worked
  (`"lint": "run-s lint:*",`)

  ```bash
  $ yarn lint

  yarn run v1.16.0
  $ run-s lint:*
  $ eslint '**/*.{js,jsx}'
  $ stylelint '**/*.scss'
  ✨  Done in 12.00s.
  ```

- make changes re version of the gem
- the [gem release process](/gems/release_steps.md)

## Updating feature steps to use POMs and what to do with steps that are used in other places

I ended up doing this in a cucumber step file (`premium_providers_step.rb`):

```ruby

# Used in: core/features/admin_premium_shopper_product_creation.feature
Given(/^I click the (Back to )?Premium Providers link$/) do |back_to|
  step("I click the \"#{back_to}#{premium_providers_label}\" link")
end

def premium_providers_label
  PremiumProvider.model_name.human.pluralize
end


Then(/^I should see the Premium Provider label$/) do
  step("I should see \"#{premium_provider_label}\"")
end

Given(/^I click the (New|Edit) Premium Provider link$/) do |action|
  step("I click the \"#{action} #{premium_provider_label}\" link")
end

def premium_provider_label
  PremiumProvider.model_name.human
end

# ####

# All other steps were using POMs and only used in one feature file
```

Code review suggeted this:

>I think they are unnecessary per-step (esp. because they may be used elsewhere and therefore become out-of-date quickly), but fine for them to stay.
>Something you could do is move them into specific steps that relate to the feature e.g.
>
>- admin/premium_shopper_product_steps.rb
>- provider_steps.rb (or maybe rename provider.feature to premium_provider.feature)

Great idea. Have done. And it all works!!

## Error running `npm run compile:sass` AGAIN!

- got this again on work computer after an update for an `npm audit fix`
- <https://github.com/libbyschuknight/natours-site/commit/73f7580330f3dd928af792d2ba7a0367c0fbafaf>

```bash
npm run compile:sass

> natours-site@1.0.0 compile:sass /Users/libby/own/natours-site
> node-sass sass/main.scss css/style.css -w

/Users/libby/own/natours-site/node_modules/node-sass/lib/binding.js:13
      throw new Error(errors.unsupportedEnvironment());
      ^

Error: Node Sass does not yet support your current environment: OS X 64-bit with Unsupported runtime (72)
```

Found this article this time - [How to fix “Error: Node Sass does not yet support your current environment: OS X 64-bit with Unsupported runtime (57)”](https://medium.com/@proustibat/how-to-fix-error-node-sass-does-not-yet-support-your-current-environment-os-x-64-bit-with-c1b3298e4af0)

It says to do the same thing, run `npm rebuild node-sass`, which I have done once and got this error:

```bash
../../nan/nan_object_wrap.h:24:25: error: no member named 'IsNearDeath' in
      'Nan::Persistent<v8::Object, v8::NonCopyablePersistentTraits<v8::Object> >'
    assert(persistent().IsNearDeath());
           ~~~~~~~~~~~~ ^
/usr/include/assert.h:93:25: note: expanded from macro 'assert'
    (__builtin_expect(!(e), 0) ? __assert_rtn(__func__, __FILE__, __LINE__, #e) : (void)0)
                        ^
In file included from ../src/binding.cpp:1:
In file included from ../../nan/nan.h:2722:
../../nan/nan_object_wrap.h:127:26: error: no member named 'IsNearDeath' in
      'Nan::Persistent<v8::Object, v8::NonCopyablePersistentTraits<v8::Object> >'
    assert(wrap->handle_.IsNearDeath());
           ~~~~~~~~~~~~~ ^
/usr/include/assert.h:93:25: note: expanded from macro 'assert'
    (__builtin_expect(!(e), 0) ? __assert_rtn(__func__, __FILE__, __LINE__, #e) : (void)0)
                        ^
2 errors generated.
make: *** [Release/obj.target/binding/src/binding.o] Error 1
gyp ERR! build error
gyp ERR! stack Error: `make` failed with exit code: 2
gyp ERR! stack     at ChildProcess.onExit (/Users/libby/own/natours-site/node_modules/node-gyp/lib/build.js:262:23)
gyp ERR! stack     at ChildProcess.emit (events.js:200:13)
gyp ERR! stack     at Process.ChildProcess._handle.onexit (internal/child_process.js:272:12)
gyp ERR! System Darwin 17.7.0
gyp ERR! command "/Users/libby/.nvm/versions/node/v12.4.0/bin/node" "/Users/libby/own/natours-site/node_modules/node-gyp/bin/node-gyp.js" "rebuild" "--verbose" "--libsass_ext=" "--libsass_cflags=" "--libsass_ldflags=" "--libsass_library="
gyp ERR! cwd /Users/libby/own/natours-site/node_modules/node-sass
gyp ERR! node -v v12.4.0
gyp ERR! node-gyp -v v3.8.0
gyp ERR! not ok
Build failed with error code: 1
npm ERR! code ELIFECYCLE
npm ERR! errno 1
npm ERR! node-sass@4.11.0 postinstall: `node scripts/build.js`
npm ERR! Exit status 1
npm ERR!
npm ERR! Failed at the node-sass@4.11.0 postinstall script.
```

Trying it again, just in case 🤞. 😭

Searched for some stuff and found:

-<https://github.com/microsoft/PartsUnlimited/issues/134>

which lead me to

-<https://stackoverflow.com/questions/34202617/how-to-update-all-node-js-modules-automatically>

Then I searched for `npm update` and got to:

-<https://docs.npmjs.com/updating-packages-downloaded-from-the-registry>

Did `npm outdated` and got:

```bash
Package    Current  Wanted  Latest  Location
node-sass   4.11.0  4.12.0  4.12.0  natours-site
```

Ran `npm update node-sass`, which was successful. Ran `npm run compile:sass` again and ... it seems to be working!!

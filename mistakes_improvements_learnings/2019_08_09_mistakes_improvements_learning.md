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
- final the [gem release process](/gems/release_steps.md)
- final the [gem release process](/gems/release_steps.md#-Release-process-for-APL-gem---for-my-understanding) (check where this link goes on github)

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

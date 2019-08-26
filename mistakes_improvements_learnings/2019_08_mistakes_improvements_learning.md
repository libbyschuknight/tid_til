# August 2019 Mistakes, Improvements, Learning and Stuff

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

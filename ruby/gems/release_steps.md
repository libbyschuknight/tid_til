# Release process for APL gem - for my understanding

## Step 1: Development

### APL Gem

Create new branch (`apl-123`)

- write code, do all the things etc etc
- get working
- push new branch (`apl-123`) to gitlab
- ready for testing

### Core App

Create a new branch - (core - `apl-123`)

- can use this for developing local (who could use the `Playground` app)
  - set the APL gem tp local path in Gemfile
  `gem 'admin_pattern_library', :path => '../admin_pattern_library'`
  - use  `bundle _1.17.3_ update --conservative admin_pattern_library` to up date just the gem (you may or may not need to set the `bundle` version)
- if adding to the gem, changes you make in the core branch will not be pushed to master

## Step 2: Testing

### APL Gem

- CI runs
- can now use the new deploy branch in the Core app branch

### Core App

- create new branch (core - `apl-123`) if haven't already
- update the gemfile to point to the APL deploy branch
  `gem 'admin_pattern_library', :powergem => 'admin_pattern_library', :deploy => 'deploy-apl-123'`
  (use  `bundle _1.17.3_ update --conservative admin_pattern_library` to up date just the gem (you may or may not need to set the `bundle` version))
- push
- CI will run
- can set up on Wippy for testing

## Step 3: Releasing a new version of the APL gem

- once testing complete and PO approved etc

### APL Gem

- remove / squash unnecessary commits from the gem branch `apl-123`
  - best to do with a `git rebase -i` probably
  <!-- Note I think this was meant for the core app info -->
- merge into master
  - this will trigger a build of the deploy branch
- update version, changelog and commit to master
  - ruby `version.rb`
  - javascript `package.json`
  - change log - `CHANGELOG.md`
  - this commit will trigger a build of the deploy branch

#### Gitlab

- go to GitLab
- create a new tag
  - repo -> tags -> new tag - **create from `deploy` branch**
  - tag name - e.g. v0.9.0
  - message - e.g. `Release gem version 0.9.0`
  - release notes - do not add any release notes, we are not doing releases like this, see CHANGELOG.md  for release notes

### Core App

- in the core branch (core - `apl-123`)
- remove / squash unnecessary commits from the gem branch `apl-123`
  - e.g. there might be a few "Bump gem version" commits
  - best to do with a `git rebase -i` probably
- update the `Gemfile` to use the new APL gem version
  `gem 'admin_pattern_library', :powergem => 'admin_pattern_library', :tag => 'v0.0.0'`
- run `bundle update --conservative admin_pattern_library`
  - depending on if you have mutiple versions on `bundler` you may need to add in the `bunlder` version
  - `bundle _1.17.3_ update --conservative admin_pattern_library`
- in the `Gemfile.lock` the information for the APL gem should be updated and NOTHING else.
- push branch to GitLab
- CI hopefully passes
- test on Wippy - just in case
- then assign to MargeBot so it is merged into master!

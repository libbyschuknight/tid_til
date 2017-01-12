# [Test-Driven Rails](https://thoughtbot.com/upcase/test-driven-rails)

[Upcase tutorials](https://thoughtbot.com/upcase/practice)

## Introduction

### Why test?

##### What's the value?
- $$$
- goals
  - business goals
    - behaves the way the customer wants e.g. user logging in
    - behaves the way the user expects
    - works - e.g. business logic is applied properly
  - code goals
    - easy for others to understand - consider ourselves as others in the future
      - tests act as documentation
    - easy to refactor
  - process goals
    - written quickly
    - addresses only what's necessary
    - establishes trust

##### How?

Red, Green, Refactor
- red = failing test
- green - make tests pass
- refactor, look over and make sure is best code can write, not adding any new functionality

Outside-in development
- acceptance tests
  - high level tests
  - driven from perspective of user
  - high level interactions, large steps
  - == integration / feature tests
  - behaviors throughout the whole application where component are interacting

- unit tests
  - much more granule level e.g. calculating tax
  - can isolate small component


Primary tools
- RSpec
- Capybara


Secondary tools
- FactoryGirl
- Shoulda Matchers - associations and validations
- DatabaseCleaner


Goals
- how to test and why to test
- focusing on the business values
- making sure the code is easy to modify, extend, add functionally
- design perspective - easy to modify or extend

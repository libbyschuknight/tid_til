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


## 1. Setting Up the App & Initial Test

Build a todo app
`rails new todos -T`, `-T` skips test unit

run `rake` to run specs

? what is the difference between the different ways to run tests??


Capybara - feature and scenario ==  describe and it


## 2. Creating the First Todo

Next test - logically - to create a new todo

## 3. Signing In and Todo Ownership

- add module to `support/features` for `sign_in` method.

- add to `rails_helper.rb`

  - `config.include `Features`, type: :feature`

  - flag that says only include the `Features` module tin the features specs

  - also need to uncomment this:
      `Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }` in `rails_helper.rb` to get it working

## 4. Refactor to User Model

- add `current_user` rather then just `sessions params`

- active record relation / scope

  ```ruby
  Todo.where(email: @email)
  ```

## 5. Completing a Todo

ActiveRecord `touch`

http://apidock.com/rails/v4.2.7/ActiveRecord/Persistence/touch

> it is a method that only updates the specified timestamps of the model with the current time.

http://stackoverflow.com/questions/31665895/in-rails-activerecord-what-is-touch-for

## 6. Refactoring Todo Completions

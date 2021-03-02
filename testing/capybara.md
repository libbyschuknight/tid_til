# Capybara

<https://github.com/teamcapybara/capybara>

<https://github.com/teamcapybara/capybara#using-capybara-with-rspec>

<https://rubydoc.info/github/teamcapybara/capybara/master/Capybara>

<https://relishapp.com/rspec/rspec-rails/docs/feature-specs/feature-spec>

[Write Reliable, Asynchronous Integration Tests With Capybara](https://thoughtbot.com/blog/write-reliable-asynchronous-integration-tests-with-capybara)

[Testing Your App In The Browser With Capybara (Rails Backend, React Frontend)](https://medium.com/@ethanryan/testing-your-app-in-the-browser-with-capybara-rails-backend-react-frontend-e409671c4596)

## Notes

Useful page - has node methods (as in `fill_in`) and session methods (using `page`, `page.body`, `page.save_page`)

[Class: Capybara::Session](http://www.rubydoc.info/github/jnicklas/capybara/Capybara/Session)

## Save and open page

When using [`save_and_open_page`](https://www.stefanwille.com/2010/12/printing-the-page-content-in-capybara/), to use the assets so the page has the correct styling, in your `config/environments/test.rb` file, add these:

```ruby
config.assets.debug = true
config.action_controller.asset_host = "http://localhost:6001"
```

`save_and_open_screenshot`

- need to have in the test `js: true`, for SP

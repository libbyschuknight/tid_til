# Stuff that doesn't yet fit somewhere else

## Trello

[How To Format Your Text in Trello](http://help.trello.com/article/821-using-markdown-in-trello)
[Keybaord Shortcuts](https://trello.com/shortcuts)

## Aliases

Been working in Sequel gem a lot and got tired of doing `bundle exec irb` then when in irb `require "./config/environment.rb"`.
Learnt that you can do this `bundle exec irb -r ./config/environment.rb"`, which I have added as an alias called `sequelc` - sequel console!

## Multiple Codebases

When working with multiple codebases that work together, remember:

- update where gems are pointing to, e.g. if you are working with local changes to a gem, have both apps pointing at your local version of the gem.
- when running App1, which makes calls to App2 (api), remember to change the environment variable to hit local App2 - e.g API_HOST = http://localhost:3000.
- look for errors in the server output of both apps
- when working in different branches of the same app and making changes to the database in one of those branches, when you change to another branch, changes to the structure/schema of the database DOES NOT change, you will need to do `rake db:migrate` or `rake db:reset`
- remember also that you will need to run `rake db:test:prepare`!!

## Google

### Chrome

**Useful Keyboard Shortcuts:**

- `Cmd + L` to focus on address bar

### Slides / Presentations

[Crop and adjust images](https://support.google.com/docs/answer/4600160?co=GENIE.Platform%3DDesktop&hl=en)

>Mask an image in Google Slides
>To fit an image into a shape in Google Slides, you can mask an image.
>
>1. On your computer, open a presentation.
>2. Click the image you want to mask.
>3. At the top, next to Crop Crop, click the Down arrow Down Arrow.
>4. Click the shape you want.
>5. Your shape will mask your image. To adjust your shape, click and drag the colored handles.

## [Rollbar](https://rollbar.com)

Error was coming up on Rollbar

```bash
NoMethodError: undefined method 'strftime' for nil:NilClass
```

Fixed this and deployed fix to UAT.
Tried on UX again and the error reoccured. Rollbar continued to say it was the above error.
This is being on the traceback tab.
After getting help, looked at the occurences tab and the top error was:

```bash
undefined method 'user' for nil:NilClass
```

Funny that it continues to report on the original error even though it has been fixed!!

## RegEx

[Rubular - a Ruby regular expression editor](http://rubular.com/)

RegExrv2.1 - <https://regexr.com/>

<https://regex101.com/> - good for validating regex

<https://regexcrossword.com/>

<https://www.executeprogram.com/>

### Cucumber expressions

```cucumber
{int} - will match an integer
{string} - will match a string
(100) - capture block
.* - any character any number of times
[0-9]* - any number of digits
\d+ - at least one digit
\w+ - at least one word
```

<https://cucumber.io/docs/cucumber/cucumber-expressions/>

(Thanks Anuj)

![reg-ex- cuke](/cuke-regex-2.png)

### Escaping a `?`

`?` needs to be escaped in this case:

```ruby
expect(page).to have_content(/Oh no! Did you enter something incorrectly\? If not, let a computer friend know there is a problem./)
```

otherwise the test does not pass! Even though it looks like it should.

## Mac Keyboard Shortcuts

Control+Shift+Eject - sleep / lock (external keyboard)
Control+Shift+Power

control + shift + space bar - for switching between keyboard languages
control + space bar - to bring up list and select with arrow keys

## Some markdown stuff

Image
`![alt_tag](images/<name of image>.png)`

## Bug hunting

A bug came up where the user was clicking a `save and switch` button and the page either just reloaded and there was no change or it errored and there was a message on Rollbar. After looking a lot at the errors and even doing stuff on the server the person I was working with was like "hmmm, its missing this!!". The thing missing should also have been showing an error message on the page but with a lot of work on changing the view recently it got hidden.
Lesson learnt - take the time to check what the user has inputted and what you would expect to see!!

# Cucumber

<https://cucumber.io/docs/reference>

<https://cucumber.io/docs/guides/overview/>

<https://cucumber.io/docs/cucumber/step-definitions/> - Ruby

## Thoughts on writing cukes

`Given I am on the game page - correct guess`

>Possibly `Given I am ready to play a turn` as this contains no implementation specific language.
>Most of the following steps have implementation details (e.g. click a button). Cukes should describe intent of the action (submit my guess).

## Given, When, Then and And

Thoughts from Jordane

>It's all very wordy, but comes down to the kind of action you're intending to perform in the step
>
>```cucumber
>(Given) some context the database is acted on directly, ivars are set up, etc.
>
>(When) some action is carried out the webdriver steps happen to reproduce user actions, ie, clicking and entering inputs
>
>(Then) a particular set of observable consequences should obtain check the state of the world to determine the expected outcome
>```

>`And` in the feature can just be assumed as whatever was before it.
>
>Just makes things nice to read and understand without looking into the code that backs the step
>
><https://www.foreach.be/blog/9-tips-improving-cucumber-test-readability>

## Cucumber expressions

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

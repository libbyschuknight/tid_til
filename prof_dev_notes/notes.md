# Notes from Random Things

## [Two screencasts, two ways to eradicate Ruby nil values](https://www.rubytapas.com/2017/01/31/two-screencasts-two-ways-eradicate-ruby-nil-values/)

[Special Case Pattern](https://martinfowler.com/eaaCatalog/specialCase.html)

- Special case identified - no logged in user / guest and then represented as an object in its own right, simpler code that also reads better

> Anytime a program keeps switching on the same condition over and over again, it is a good indication that there is a new kind of object waiting and wanting to be discovered.


[Null Object Pattern](https://en.wikipedia.org/wiki/Null_Object_pattern)

>a Null Object is an object with no referenced value or with defined neutral ("null") behavior. The Null Object design pattern describes the uses of such objects and their behavior (or lack thereof)

`try` - is basically a `if nil` statement

always test nil behaviour before refactoring 

a gotcha - parallel interfaces on the `NoAnswer` class
- `it 'mimics the API of answer'`

For most `null` objects they are used in limited scopes.

Is a potential source of bugs and confusion.

When it is used in the right places it can be great:
- looking for nil or handling nothingness

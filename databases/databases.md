# Databases - general stuff

#### Migrations

In regard to taking out a column from db, remove all reference to the column FIRST in your code. Once you have done that, then removed the column via a migration. In particular if you are doing this on a live production site.


#### Where vs Find
So, when using...
```ruby
Models::Meal.find(ingredient: "beef")
```
will only return the first one.
When using:
```ruby
Models::Meal.where(ingredient: "beef")
```
...will return all.

(Example using [Sequel gem](http://sequel.jeremyevans.net/))

TODO: add example output???

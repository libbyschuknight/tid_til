# Databases - general stuff

#### Migrations

In regard to taking out a column from db, remove all reference to the column FIRST in your code. Once you have done that, then remove the column via a migration. In particular if you are doing this on a live production site.


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


#### Using `.find` or creating find_by method on model

if doing this a lot in codebase
```ruby
Models::Cat.find(tag_id: "123")
```

could add a `find_by_tag_id` to the Cat model
```ruby
Models::Cat.find_by_tag_id("123")
```

```ruby
module Models
  class Cat

    many_to_one :home

    one_to_many :dogs

    def self.find_by_tag_id(tag_id)
      self.find(tag_id: tag_id)
    end

  end
end
```

This would be good if you are using `find` in a lot of places and then the column name you were using changed. Doing it like this would mean that you just need to change the column name in one place.


#### Class name can be Implicit
```ruby
module Models
  class Event < Sequel::Model

    many_to_one :sports

    def self.new_running_event(params:,)
      Models::Event.create(sports_id: sports_id, type: "running", data: params)
    end

  end
end
```
Instead of having:
```ruby
Models::Event.create(sports_id: sports_id, type: "running", data: params)
```
you can just have:
```ruby
create(sports_id: sports_id, type: "running", data: params)
```
... as you are inside the `Event` model.

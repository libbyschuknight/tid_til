# January / February Mistakes & Improvements

## scopes

If doe this as a scope:

```ruby
scope :first_read_taken, -> { order_by_taken_at.first }
```
can't chain another scope on it.
Could use a `limit(1)` instead but suggested is you would do a class method:

```ruby
def first_read_taken
  order_by_taken_at.first
end
```

## validations

[Skipping Validations in Ruby On Rails](https://richonrails.com/articles/skipping-validations-in-ruby-on-rails)

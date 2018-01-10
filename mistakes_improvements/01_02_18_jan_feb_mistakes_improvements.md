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


## Remind about things to think about when starting to test something like a service object

Draw it out:
![service object](service_object.jpg)

Pseudocode it out:

```ruby
describe "#call" do
  # happy path
  #   creates / saves an invoice
  #      with correct values
  #   invoice has no errors

  # sad path
  #   invoice is not saved
  #   invoice has errors
  #   or
  #   invoice_creator has errors
end
```

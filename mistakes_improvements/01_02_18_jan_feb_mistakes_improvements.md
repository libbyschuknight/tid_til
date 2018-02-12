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

## Test on a scope for number of customers

`scope :customers, -> { where(admin: false) }`

spec

```ruby
it "returns users that are customers" do
  expect(User.customers.first.admin).to be false
end
```

suggestion to change to:
> i think you could do something like expect(User.customers.pluck(:admin).compact).to eq [false] or something?

changed to
`expect(User.customers.pluck(:admin).compact.uniq).to eq([false])`


## Thinking on links vs buttons and making a link look like a button

Changing this

```html
<div class="back-to-overview"><%= link_to "Back to overview", {:controller => '/properties'}, :id => "back-to-overview-link" %></div>
```

```css
.back-to-overview {
  float: left;
  margin-left: 12px;
  padding-top: 8px;
}
```

Which looks just like a link to something that looks like a button but is not a button, as it does not submit anything.
It took me a little while to get my head around that, I had in my head that the design/er was wanting a button, so was thinking about using the styles already in the app for buttons. But its functionality is not that of a button, it is a link, so although it might end up looking like a button, it is not.

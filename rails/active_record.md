# Active Record DB stuff

## Queries

https://robots.thoughtbot.com/activerecords-wherenot

This query:

`User.where.not(name: 'Gabe')`

is effectively the same as this:

`User.where('name != ?', 'Gabe')`


#### Finding records

In between certain dates
```ruby
Consumer.active.activated.where(start_date: Date.parse("23/3/2017")..Date.parse("4/4/2017"))
```

Before a certain date, with a certain attribute set to `nil`
```ruby
Consumer.active.activated.where(last_annual_summary_date: nil).where("start_date <= ?", Date.parse("1/4/2018"))
```


## [.includes](http://apidock.com/rails/ActiveRecord/QueryMethods/includes)

Use to speed up a query that is taking ages due to using lots of models.

```ruby
consumers = Consumer.where(participant_ref: provider_url).includes(customer: [account: [{user: :userref}, :sign_up, :contacts]])
```
where consumers is being used to do:

```ruby
consumers.each do |consumer|
  csv << csv_row(consumer)
end

# and these are being accessed from the consumer

customer = consumer.customer
user = customer.account.user
account = customer.account
contact = account.main_contact
sign_up = account.sign_up
```

## Scopes

[The Importance of Scopes in Ruby on Rails](https://jasoncharnes.com/importance-rails-scopes/)

[Should You Use Scopes or Class Methods?](https://www.justinweiss.com/articles/should-you-use-scopes-or-class-methods/)

#### `where` and `nil`

So was doing a `where` like this in a scope a model in Rails:
```ruby
Model.where("started_by = ? AND source = ?", nil, "join")
```
When I did `to_sql` on it (handy little trick in rails), got this:
```sql
"SELECT \"models\".* FROM \"models\" WHERE (started_by = NULL AND source = 'join')"
```
which returns `[]`, which is not what I want!

So, knowing that this returns what I want:
```ruby
Model.where(started_by: nil).where(source: "join")
```
and the sql is this:
```sql
"SELECT \"models\".* FROM \"models\" WHERE \"models\".\"started_by\" IS NULL AND \"models\".\"source\" = 'join'"
```
and seeing that where `NULL` is it uses `IS NULL` I changed my first query to:
```ruby
Model.where("started_by is ? AND source = ?", nil, "join")
```
which is
```sql
"SELECT \"models\".* FROM \"models\" WHERE (started_by is NULL AND source = 'join')"
```
and returns what I want!


## Joining Tables
[Joining Tables](http://guides.rubyonrails.org/active_record_querying.html#joining-tables)

### Find all records which have a count of an association greater than zero
https://stackoverflow.com/questions/20183710/find-all-records-which-have-a-count-of-an-association-greater-than-zero

I wanted to find games that had more then x guesses.

I thought it might have been simple (I might be missing a simple way), but this is what I found:

```ruby
Game.joins(:guesses).group('games.id').having('count(game_id) > 5')
```



## Validations

#### Number being non-negative

http://api.rubyonrails.org/classes/ActiveModel/Validations/HelperMethods.html#method-i-validates_numericality_of

```ruby
class Game < ApplicationRecord
  validates :lives, presence: true
  validates_numericality_of :lives, greater_than_or_equal_to: 0
end
```


## Migrations

[Rails 5: Rename a Column on a Database in a Migration](http://codkal.com/how-rename-database-column-rails-5-migration/)



## Enums

[Creating Easy, Readable Attributes With ActiveRecord Enums](https://www.justinweiss.com/articles/creating-easy-readable-attributes-with-activerecord-enums/)


## update_all

http://api.rubyonrails.org/classes/ActiveRecord/Relation.html#method-i-update_all
When have a group of records where want to change say an `something_id` on all of them.


## Overcome readonly_attributes

Needed to do some hacking to change a brand on a `User` and `Customer` but due to validations and readonly_attributes couldn't.

The work around (note - this is something not to do on any prod data):

```ruby
User.class_eval do
  def self.readonly_attributes
    []
  end
end

User.update_column(brand_id: 3)
```


## .merge

[14.4 Merging of scopes](http://guides.rubyonrails.org/active_record_querying.html#merging-of-scopes)

Instead of doing this:

```ruby
Consumer.joins(:customer).where("experience = ?", Customer::SHOPPER)
```
can do:
```ruby
Consumer.joins(:customer).merge(Customer.shopper)
```

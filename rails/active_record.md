# Active Record DB stuff

https://robots.thoughtbot.com/activerecords-wherenot

This query:

`User.where.not(name: 'Gabe')``

is effectively the same as this:

`User.where('name != ?', 'Gabe')``


### [.includes](http://apidock.com/rails/ActiveRecord/QueryMethods/includes)

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

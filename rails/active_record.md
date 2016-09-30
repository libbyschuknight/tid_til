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

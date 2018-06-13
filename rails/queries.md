# Queries

Place to throw queries - simple to more complex

```ruby
# find all meters created in the last 4 weeks
Meter.where("created_at >= ?", 4.weeks.ago)

# find customers that are active where either the email date of the created_at date was more than a year ago
Customer.active.where("COALESCE(customers.email_date, customers.created_at) <= ?", 1.year.ago.end_of_day)


# Is this a query?
# update all customers email_date field to be nil
Customer.all.each { |c| c.update(email_date: nil) }





```

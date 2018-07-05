# July / August Mistakes, Improvements, Stuff

## Look at logs
When working on an incident I wasn't looking closely enough at the logs. Basically it should have been pulling back records for two different objects but in one case was only bringing back one.

Query:

```ruby
(consumers.map(&:hold_customer_mail_until) + inbound_consumers.map(&:hold_customer_mail_until)).compact.max
```

Working correctly:

a "banana" consumer

```bash
[69590cd5-ad86-4a83-ac07-9b7b6cb559cb]   Consumer Load (35.5ms)  SELECT `consumers`.* FROM `consumers` WHERE `consumers`.`customer_id` = 12345
[69590cd5-ad86-4a83-ac07-9b7b6cb559cb]   InboundConsumer Load (31.0ms)  SELECT `inbound_consumers`.* FROM `inbound_consumers` WHERE `inbound_consumers`.`customer_id` = 12345
```

Not working correctly:

a "apple" consumer

```bash
[3d262f9e-3994-49d7-812e-6c60cac24d6d]   InboundConsumer Load (17.8ms)  SELECT `inbound_consumers`.* FROM `inbound_consumers` WHERE `inbound_consumers`.`customer_id` = 98765
```

The "banana" and "apple" consumers don't differ hugely but it seemed that something was happening with caching when the apple consumer was being used.

The fix was:

```ruby
[
  Consumer.where(customer_id: holdable.customer_id).maximum(:hold_customer_mail_until),
  InboundConsumer.where(customer_id: holdable.customer_id).maximum(:hold_customer_mail_until)
].compact.max
```

Could have also used a reload in the original code which is not shown here.

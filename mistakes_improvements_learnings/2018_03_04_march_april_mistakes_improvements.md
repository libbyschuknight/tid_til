# April / March Mistakes, Improvements

Asked this question:

>Just been looking at the code review template - when should we do this `Any new files begin the with # frozen_string_literal: true pragma, and/or this pragma is added to existing files as appropriate`?

got this answer:
>Basically when we add new rb files we should put that at the top
> <https://freelancing-gods.com/2017/07/27/friendly-frozen-string-literals.html>

Was going to add to the repo, but have already!! Remember to check here first! And to back myself!

## Working on Specs - Spec helpers

When doing some pairing with colleague for a fix to the api, on setting up a spec for a water consumer, he looked into if there were any spec helpers that would be useful.
There was one called `readings_spec_support.rb`, which had some useful methods in it. Which could be used in the spec by including the spec helper in the file or actually using similar code from the spec helper in the spec file.
(This is an app that is HUGE!!)

Learning / improvement - look around for things that might be helpful, look at spec helpers / spec support, ask others if they know of anywhere that might have some useful stuff, rather than trying to set things up from scratch every time.


## Copying records

Have plan 1 and want to copy all costs from plan 1 to plan 2

```ruby
costs.each do |cost|
  new_cost = cost.dup # this makes a new record, associations aren't copied
  new_cost.plan_id = 2
  new_cost.save!
end
```

If wanting to copy one record:

```ruby
old_plan = Plan.find(plan_id)
new_plan = Plan.new(old_plan.attributes)

# still need to update things
new_plan.id = 44
```

## Using Specs
Use specs when difficult to manually test a scenario with development.
Had a case where wanted to see if an email would be sent if the consumer was not with Brand A. But was difficult to find a consumer that was not on Brand A for timeframe looking at.

So, in test was able to set up consumer that was with a brand different to Brand A. Now should be able to get working as want to.


## Using `to_sql` and Sequel Pro to help with working out a query

Started with trying this in irb

```ruby
Consumer.active.activated.joins(:customer => :brand).where(:customer => {:brand => {:shopper_enabled => true }}).where("COALESCE(last_annual_summary_date, start_date) <= ?", Date.today - CUTOFF).to_sql
```

which gave

```
"SELECT `consumers`.* FROM `consumers` INNER JOIN `customers` ON `customers`.`id` = `consumers`.`customer_id` INNER JOIN `brands` ON `brands`.`id` = `customers`.`brand_id` WHERE (`consumers`.`start_date` <= '2018-04-13' AND (`consumers`.`end_date` IS null OR `consumers`.`end_date` >= '2018-04-13')) AND (`consumers`.`go_shopping_notified_at` IS NOT NULL) AND `brand`.`shopper_enabled` = 1 AND (COALESCE(last_annual_summary_date, start_date) <= '2017-04-27')"
```

Running that though in Sequel Pro, firstly gave a SQL syntax error, need to remove the `""`.
Then got `Unknown column 'brand.shopper_enabled' in 'where clause'`, so did some searching and figured what needed to do to make the query work as expected.

<https://stackoverflow.com/questions/9033797/how-to-specify-conditions-on-joined-tables-in-rails>

`Score.joins(:submission).where(:submissions => {:task_id => 1})`

```ruby
Consumer.active.activated.joins(:customer => :brand).where(:brands => {:shopper_enabled => true }).where("COALESCE(last_annual_summary_date, start_date) <= ?", Date.today - CUTOFF).to_sql
```

```sql
SELECT `consumers`.* FROM `consumers` INNER JOIN `customers` ON `customers`.`id` = `consumers`.`customer_id` INNER JOIN `brands` ON `brands`.`id` = `customers`.`brand_id` WHERE (`consumers`.`start_date` <= '2018-04-13' AND (`consumers`.`end_date` IS null OR `consumers`.`end_date` >= '2018-04-13')) AND (`consumers`.`go_shopping_notified_at` IS NOT NULL) AND `brands`.`shopper_enabled` = 1 AND (COALESCE(last_annual_summary_date, start_date) <= '2017-04-27')
```

## Logic in a couple of places

In code review I had:

```ruby
annual_summary_date = (consumer.last_annual_summary_date || consumer.start_date) + 1.year

# and in another place
@start_date = (@consumer.last_annual_summary_date || @consumer.start_date)
@end_date = @start_date + 1.year
```

Suggested that all the logic figuring out the `start_date` and `end_date` was in the one place, and passed through to the other, which was possible. So changed to:

```ruby
# in first file/method
...
current_start_date = (consumer.last_annual_summary_date || consumer.start_date)
current_end_date = current_start_date + 1.year

transaction do
  model.something!(
    nil,
    "annual_consumer_summary",
    :utility_description => consumer.description,
    :property => consumer.vanity_address.property_name_or_street_address,
    :start_date => current_start_date,
    :end_date => current_end_date
  )
  model.update_attributes!(:something_else => current_end_date)
end
...

# in second file/method where the above goes off to
...
@start_date = params[:start_date]
@end_date = params[:end_date]
...
```

### Finding records

#### before certain date

Wanted to check that this query:

```ruby
CUTOFF = 1.year + 14.days

Consumer.active.activated.joins(:customer).merge(Customer.shopper).where("COALESCE(last_annual_summary_date, start_date) <= ?", Date.today - CUTOFF).count
# 134
```

was getting what I expected.
Knowing that all records have a `nil` value for `last_annual_summary_date`, I just needed to use `start_date` and figure out the date to use.

```ruby
Consumer.active.activated.where("start_date <= ?", Date.today).count
# 24174

Consumer.active.activated.where("start_date <= ?", 1.year.ago).count
# 201

Consumer.active.activated.where("start_date <= ?", 1.year.ago - 14.days).count
# 134
```

#### Date and type

```ruby
Consumer.active.activated.where("start_date <= ?", Date.today).where(utility_type: "water").count
```

collecting date to double check

```ruby
Consumer.active.activated.where("start_date <= ?", Date.today).where(utility_type: "water").collect(&:start_date)
```


### Partials

Was trying to get a local working through rendering a partial, was doing this:

```html
<%= render => "customer_stored_mailer/shared/header", :locals => { :title => "Annual Account Summary" } % >
```

Thought it wasn't working because of there being a `content_for` block being involved and not really knowing how they work or how the `yield` block works within them.

Then tried it with the `partial` wording

```html
<%= render :partial => "customer_stored_mailer/shared/header", :locals => { :title => "Annual Account Summary" } %>
```

And it worked. And had a look at what I had added in here the other week:

## view stuff / render - add link

### Rails Assets Precompile

Colleague was swapping images out for a separate market in a big app, but the page this was happening on was still showing the old images. With some chatting and looking at the file on the page, and me going "Well, that is the image, where is it?" was an image name like `confirm-header-1-2346yhduldo.png`. We were then like, oh that is a complied assets. Colleague remembered about precompiling assets and did `rails assets:precompile`, this there loaded the new images! Yay!

[4.1 Precompiling Assets](http://guides.rubyonrails.org/asset_pipeline.html#precompiling-assets)

## Getting db stuff

The way Flux gets db's created locally uses ssh things. This came up:

```bash
Enter passphrase for key '/Users/libby/.ssh/id_rsa':

# entered password and got

Authentication failed.
```

Asked some peeps and needed to do this `ssh-add`. Which I keep forgetting!!

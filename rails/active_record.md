# Active Record

Add logger into rails console

```ruby
ActiveRecord::Base.logger = Logger.new $>
```

## DB stuff

[Preload, Eagerload, Includes and Joins](https://blog.bigbinary.com/2013/07/01/preload-vs-eager-load-vs-joins-vs-includes.html)

[Making sense of ActiveRecord joins, includes, preload, and eager_load](http://blog.scoutapp.com/articles/2017/01/24/activerecord-includes-vs-joins-vs-preload-vs-eager_load-when-and-where)

[Rails 4: List of available datatypes](https://stackoverflow.com/questions/17918117/rails-4-list-of-available-datatypes)

### Queries

<https://robots.thoughtbot.com/activerecords-wherenot>

This query:

`User.where.not(name: 'Gabe')`

is effectively the same as this:

`User.where('name != ?', 'Gabe')`

#### Finding records

In between certain dates:

```ruby
# `activated` is work/model specific method
Consumer.active.activated.where(start_date: Date.parse("23/3/2017")..Date.parse("4/4/2017"))
```

Before a certain date, with a certain attribute set to `nil`:

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

## .where

### `where` and `nil`

So was doing a `where` like this with a scope on a model:

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

### finding a bunch of users by id

```ruby
ids = [1,2,3,4]
User.where(id: ids)
```

## Joining Tables

[Joining Tables](http://guides.rubyonrails.org/active_record_querying.html#joining-tables)

### Find all records which have a count of an association greater than zero

<https://stackoverflow.com/questions/20183710/find-all-records-which-have-a-count-of-an-association-greater-than-zero>

I wanted to find games that had more then x guesses.

I thought it might have been simple (I might be missing a simple way), but this is what I found:

```ruby
Game.joins(:guesses).group('games.id').having('count(game_id) > 5')
```

## Validations

### Number being non-negative

<http://api.rubyonrails.org/classes/ActiveModel/Validations/HelperMethods.html#method-i-validates_numericality_of>

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

## `update_all`

<http://api.rubyonrails.org/classes/ActiveRecord/Relation.html#method-i-update_all>

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

# can do
Consumer.joins(:customer).merge(Customer.shopper)
```

## Printing table data in console

```bash
pt Customer.all
```

## HACK DAYS - Getting Better at Queries

Things I didn't know / haven't come across before / or will be useful (and I should know about!):

### [Active Record Query Interface](https://guides.rubyonrails.org/active_record_querying.html)

> On a collection that is ordered using order, first will return the first record ordered by the specified attribute for order.
>
> ```bash
> client = Client.order(:first_name).first
> # => #<Client id: 2, first_name: "Fifo">
> ```

### [Ruby on Rails ACTIVE RECORD QUERIES](https://www.theodinproject.com/courses/ruby-on-rails/lessons/active-record-queries)

#### ActiveRecord::Relation

> But try running `User.where(:id => 1).class` and you’ll see that it isn’t an Array, it’s actually an instance of ActiveRecord::Relation.
> ...
> Active Record queries return relations to be lazy.
>
> You should care that ActiveRecord queries usually return Relations because you’ll run into them often when coding and debugging. The knowledge should make you comfortable chaining query methods together to construct elaborate queries.
>
> The key thing to note is that `#find` returns the actual record while `#where` returns an `ActiveRecord::Relation` which basically acts like an array. So if you’re using `#where` to find a single record, you still need to remember to go into that “`array`” and grab the first record, e.g. `User.where(:email => "foo@bar.com")[0]` or `User.where(:email => "foo@bar.com").first`.
>
> `#select` should be pretty obvious to a SQL ninja like you – it lets you choose which columns to select from the table(s), just like in SQL. To select just the ID column for all users, it’s as simple as `User.select(:id)`. You can also use aliases like in SQL but should use quotes instead of symbols, e.g. `@users = User.select("users.id AS user_id")` will create a new attribute called `user_id`, e.g. allowing you to access `@users.first.user_id`.

```ruby
$ users = User.select(:id).limit(5)
> [
    [0] #<User:0x00007fbe98cda588> {
        "id" => 1
    },
    [1] #<User:0x00007fbe98cda420> {
        "id" => 2
    },
    [2] #<User:0x00007fbe98cda2e0> {
        "id" => 3
    },
    [3] #<User:0x00007fbe98cda1a0> {
        "id" => 4
    },
    [4] #<User:0x00007fbe98cd9b10> {
        "id" => 5
    }
]

$ users = User.select("users.id AS user_id").limit(5)
> [
    [0] #<User:0x00007fbe9b360e50> {
             "id" => nil,
        "user_id" => 1
    },
    [1] #<User:0x00007fbe9b360d10> {
             "id" => nil,
        "user_id" => 2
    },
    [2] #<User:0x00007fbe9b360bd0> {
             "id" => nil,
        "user_id" => 3
    },
    [3] #<User:0x00007fbe9b360a90> {
             "id" => nil,
        "user_id" => 4
    },
    [4] #<User:0x00007fbe9b360950> {
             "id" => nil,
        "user_id" => 5
    }
]
```

#### Aggregations

```ruby
$ Game.joins(:guesses).group("guesses.letter").count
>{
    "G" => 1,
    "a" => 15,
    "b" => 13,
    "c" => 14,
    "d" => 11,
    "e" => 14,
    "f" => 14,
    "g" => 13,
    "h" => 10,
    "i" => 10,
...
}
```

#### N + 1 Queries and Eager Loading

> The N + 1 query problem is the classic case of this – you grab all the records for your users (User.all) then loop through each user and call an association it has, like the city the user lives in (user.city). For this example we’re assuming an association exists between User and City, where User belongs_to a City. This might look like:
>
> ```ruby
>  User.all.each do |user|
>    puts user.city
>  end
> ```
>
> This is going to result in one query to get all the users, then another query for each user to find its city through the association… so N additional queries, where N is the total number of users. Hence “N+1” problems. Note that it’s totally fine to just grab a regular attribute of User like user.name… it’s because you’re reaching through the association with City that we’ve got to run another full query.

`one query to get all users, another on each user to get its city - 1 query plus N additional queries`

> Rails is well aware of your distress and has provided a simple solution – “eager loading”. When you first grab the list of all users, you can tell Rails to also grab the cities at the same time (with just one additional query) and store them in memory until you’d like to call upon them. Then user.city gets treated the same way as user.name… it doesn’t run another query. The trick is the #includes method.

<https://guides.rubyonrails.org/active_record_querying.html#eager-loading-associations>

When you grab a list of `guesses` you can grab the games at the same time and store in memory and call later.

```ruby
> guesses = Guess.includes(:game)

Guess Exists (0.4ms)  SELECT  1 AS one FROM "guesses" LIMIT ?  [["LIMIT", 1]]
  Guess Load (1.9ms)  SELECT "guesses".* FROM "guesses"
  Game Load (0.6ms)  SELECT "games".* FROM "games" WHERE "games"."id" IN (16, 17, 1, 18, 31, 48, 50, 51, 52, 54, 56, 58, 61, 63, 64, 71, 75, 76, 79, 80, 87, 89, 91, 94, 95, 97, 146, 166, 176, 179, 184, 185, 186, 189, 195, 203, 204, 205, 206, 209, 210, 211, 213, 226)

> guesses.each do |guess|
>   p guess.game
> end

#<Game id: 16, word: "powershop", created_at: "2017-11-10 01:06:24", updated_at: "2017-11-10 01:06:24", lives_at_start: nil>
#<Game id: 16, word: "powershop", created_at: "2017-11-10 01:06:24", updated_at: "2017-11-10 01:06:24", lives_at_start: nil>
#<Game id: 17, word: "powershop", created_at: "2017-11-12 21:00:02", updated_at: "2017-11-12 21:00:02", lives_at_start: nil>

# versus

> Guess.all.each do |guess|
>   p guess.game
> end

Guess Load (3.0ms)  SELECT "guesses".* FROM "guesses"
  Game Load (0.2ms)  SELECT  "games".* FROM "games" WHERE "games"."id" = ? LIMIT ?  [["id", 16], ["LIMIT", 1]]
#<Game id: 16, word: "powershop", created_at: "2017-11-10 01:06:24", updated_at: "2017-11-10 01:06:24", lives_at_start: nil>
  Game Load (0.3ms)  SELECT  "games".* FROM "games" WHERE "games"."id" = ? LIMIT ?  [["id", 16], ["LIMIT", 1]]
#<Game id: 16, word: "powershop", created_at: "2017-11-10 01:06:24", updated_at: "2017-11-10 01:06:24", lives_at_start: nil>
```

<https://api.rubyonrails.org/classes/ActiveRecord/QueryMethods.html#method-i-includes>

<https://api.rubyonrails.org/classes/ActiveRecord/QueryMethods.html#method-i-eager_load>

[Understanding Rails Eager-Loading](https://dev.to/johncip/understanding-rails-eager-loading-3n6j)

[Includes, Eager Load, and Preload](https://blog.techatpower.com/includes-eager-load-and-preload-246e6b900cb8)

#### [1.2 Retrieving Multiple Objects in Batches](https://guides.rubyonrails.org/active_record_querying.html#retrieving-multiple-objects-in-batches)

`find_each`

> The find_each method retrieves records in batches and then yields each one to the block. In the following example, find_each retrieves users in batches of 1000 and yields them to the block one by one

`find_in_batches`

> The find_in_batches method is similar to find_each, since both retrieve batches of records. The difference is that find_in_batches yields batches to the block as an array of models, instead of individually.

## Translations (yaml files)

[4.5 Translations for Active Record Models](https://guides.rubyonrails.org/i18n.html#translations-for-active-record-models)

> For example when you add the following translations:

```
en:
  activerecord:
    models:
      user: Dude
    attributes:
      user:
        login: "Handle"
      # will translate User attribute "login" as "Handle"
```

> Then User.model_name.human will return "Dude" and User.human_attribute_name("login") will return "Handle".

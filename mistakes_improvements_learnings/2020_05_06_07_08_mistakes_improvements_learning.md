# May / June / July 2020 Mistakes, Improvements, Learning and Stuff

## Check the gem version used in the app you are working on

Wanted to get a random time and looked at using `Faker` <https://github.com/faker-ruby/faker>.

Found how to do time.

```ruby
Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) #=> "2014-09-18 12:30:59 -0700"`

# ArgumentError: wrong number of arguments (given 1, expected 2..4)
# from /Users/libby/.gem/ruby/2.6.3/gems/faker-1.9.1/lib/faker/time.rb:14:in `between'
```

Well, I should check what version the gem is. It is telling me right there in the error that the app is using 1.9.1.
But the syntax I used is from the latest version and is using keyword arguments.

So, check the version, find the version on Ruby Gems
<https://rubygems.org/gems/faker/versions/1.9.1>

and go to the docs for that version

<https://www.rubydoc.info/gems/faker/1.9.1/Faker/Time>

```ruby
Faker::Time.between(DateTime.now - 1, DateTime.now)

# 2020-05-12 11:42:13 +1200
```

## Migration issue with indexes

Oh no! Just ran migrations and got this error

```bash
== 20200701200149 AddUniqueIndexOnChildDailyRoutines: migrating ===============
-- add_index("daily_routines", [:date, :centre_id, :child_id], {:using=>"btree", :unique=>true, :algorithm=>:concurrently})
rails aborted!
StandardError: An error has occurred, all later migrations canceled:
Index name 'index_daily_routines_on_date_and_centre_id_and_child_id' on table 'daily_routines' already exists
/Users/libby/.gem/ruby/2.6.6/gems/activerecord-5.2.2/lib/active_record/connection_adapters/abstract/schema_statements.rb:1160:in `add_index_options'
/Users/libby/.gem/ruby/2.6.6/gems/activerecord-5.2.2/lib/active_record/connection_adapters/postgresql/schema_statements.rb:465:in `add_index'
```

Asked collegues, thought deleting DRs would help but not. This was then suggested:


ER
Hmm it might have partially applied,
What's the output of:

```bash
# run in rails console
migrations = ActiveRecord::Base.connection.execute("SELECT * FROM schema_migrations")
migrations.any? { |r| r["version"] == "20200701200149" }
```

Libby
`false`

ER
Okay, so the migration hasn't run so we can't rollback

ER
Can you delete the index with the following:
(run in rails console)

```bash
ActiveRecord::Base.connection.execute("DROP INDEX IF EXISTS index_daily_routines_on_date_and_centre_id_and_child_id;")

# it returned
   (8.1ms)  DROP INDEX IF EXISTS index_daily_routines_on_date_and_centre_id_and_child_id; /*application:StoryJar*/
#<PG::Result:0x00007fd1bc03c808 status=PGRES_COMMAND_OK ntuples=0 nfields=0 cmd_tuples=0>
```

Migration then worked!

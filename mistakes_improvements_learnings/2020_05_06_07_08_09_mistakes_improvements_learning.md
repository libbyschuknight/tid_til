# May / June / July / August / September 2020 Mistakes, Improvements, Learning and Stuff

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

## `Errno::ECONNRESET: Connection reset by peer @ io_fillbuf` error

Getting this locally. Due to how I run all my server things separately. See add link

```bash
[2020-09-07 16:37:13] ERROR Errno::ECONNRESET: Connection reset by peer @ io_fillbuf - fd:38

NotImplementedError (only partial hijack is supported.):
rack (2.2.3) lib/rack/handler/webrick.rb:83:in `block in service'
actioncable (5.2.2) lib/action_cable/connection/stream.rb:101:in `hijack_rack_socket'
actioncable (5.2.2) lib/action_cable/connection/client_socket.rb:59:in `start_driver'

...

{"method":"GET","path":"/api/v3/children/2338406119233291491/daily_routines","format":"json","controller":"Api::V3::Children::DailyRoutinesController","action":"index","status":200,"duration":343.0,"view":13.06,"db":72.49,"conact":"Api::V3::Children::DailyRoutinesController#index","uid":12,"ip":"192.168.1.70","host":"Libbys-MacBook-Pro.local","pid":2293,"sql":90,"params":{"page_token":"undefined","format":"json","child_id":"2338406119233291491","daily_routine":{}},"session_id":"e1f515a1d4b8fe8858e61109b75247b8","speed":"33.01"}
192.168.1.70 - - [09/Sep/2020:08:41:31 NZST] "GET /api/v3/children/2338406119233291491/daily_routines?page_token=undefined HTTP/1.1" 200 33089
http://192.168.1.70:3000/children/2338406119233291491/routines -> /api/v3/children/2338406119233291491/daily_routines?page_token=undefined
NotImplementedError (only partial hijack is supported.):
rack (2.2.3) lib/rack/handler/webrick.rb:83:in `block in service'
actioncable (5.2.2) lib/action_cable/connection/stream.rb:101:in `hijack_rack_socket'

```

We have a procfile to run everything locally with `foreman`.

But `foreman` does not play nicely with `pry`.

So I can all the processes in separate tabs and the server command is:

```bash
bin/spring stop && be rails s -b 0.0.0.0
```

Which means that:
>Mathew
>So that's not running passenger and whatever default server it's trying to run (I'm assuming thin) can't handle the websocket connection
>
>I think you ignore the error and continue using rails s which is probably more useful for using pry, or use passenger if >you don't want to see the error, and use something like better_errors instead of pry to debug
>
>Mathew Hartley  < 1 minute ago
>Yes, planning#edit is the only area which uses action_cable/websockets (edited)

So, currently just putting up with it and remembering to get of any `planning#edit` pages if I don't need to be looking at them.

One day I will get around to looking at using `overmind` which may fix this issue.

<https://github.com/DarthSim/overmind>

<https://evilmartians.com/chronicles/introducing-overmind-and-hivemind>

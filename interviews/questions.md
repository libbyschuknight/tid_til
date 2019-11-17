# Questions at Job Interviews

[https://30secondsofinterviews.org/](https://30secondsofinterviews.org/) (html/css/js)

## Questions from interviewers - Technical

### How would you solve the N + 1 query problem?

If using Rails and Activerecord, I would use eager loading.

This is where you can use a method like `includes`, which will use eager loading to grab the list of all of the first model and then grab the next model as well and store in memory.

For example:

- without using eager loading

```bash
> Guess.all.each { |guess| p guess.game }

Guess Load (1.1ms)  SELECT "guesses".* FROM "guesses"
  Game Load (0.2ms)  SELECT  "games".* FROM "games" WHERE "games"."id" = ? LIMIT ?  [["id", 2], ["LIMIT", 1]]
#<Game id: 2, word: "bananas", created_at: "2019-10-05 04:54:39", updated_at: "2019-10-05 04:54:39", lives_at_start: nil>
  Game Load (0.2ms)  SELECT  "games".* FROM "games" WHERE "games"."id" = ? LIMIT ?  [["id", 2], ["LIMIT", 1]]
#<Game id: 2, word: "bananas", created_at: "2019-10-05 04:54:39", updated_at: "2019-10-05 04:54:39", lives_at_start: nil>
  Game Load (0.1ms)  SELECT  "games".* FROM "games" WHERE "games"."id" = ? LIMIT ?  [["id", 2], ["LIMIT", 1]]
#<Game id: 2, word: "bananas", created_at: "2019-10-05 04:54:39", updated_at: "2019-10-05 04:54:39", lives_at_start: nil>
  Game Load (0.1ms)  SELECT  "games".* FROM "games" WHERE "games"."id" = ? LIMIT ?  [["id", 2], ["LIMIT", 1]]
#<Game id: 2, word: "bananas", created_at: "2019-10-05 04:54:39", updated_at: "2019-10-05 04:54:39", lives_at_start: nil>
  Game Load (0.1ms)  SELECT  "games".* FROM "games" WHERE "games"."id" = ? LIMIT ?  [["id", 3], ["LIMIT", 1]]
#<Game id: 3, word: "powershop", created_at: "2019-10-05 07:49:53", updated_at: "2019-10-05 07:49:53", lives_at_start: 5>
  Game Load (0.1ms)  SELECT  "games".* FROM "games" WHERE "games"."id" = ? LIMIT ?  [["id", 3], ["LIMIT", 1]]
#<Game id: 3, word: "powershop", created_at: "2019-10-05 07:49:53", updated_at: "2019-10-05 07:49:53", lives_at_start: 5>
  Game Load (0.1ms)  SELECT  "games".* FROM "games" WHERE "games"."id" = ? LIMIT ?  [["id", 3], ["LIMIT", 1]]
#<Game id: 3, word: "powershop", created_at: "2019-10-05 07:49:53", updated_at: "2019-10-05 07:49:53", lives_at_start: 5>
  Game Load (0.9ms)  SELECT  "games".* FROM "games" WHERE "games"."id" = ? LIMIT ?  [["id", 3], ["LIMIT", 1]]
#<Game id: 3, word: "powershop", created_at: "2019-10-05 07:49:53", updated_at: "2019-10-05 07:49:53", lives_at_start: 5>
  Game Load (0.4ms)  SELECT  "games".* FROM "games" WHERE "games"."id" = ? LIMIT ?  [["id", 3], ["LIMIT", 1]]
#<Game id: 3, word: "powershop", created_at: "2019-10-05 07:49:53", updated_at: "2019-10-05 07:49:53", lives_at_start: 5>
  Game Load (0.4ms)  SELECT  "games".* FROM "games" WHERE "games"."id" = ? LIMIT ?  [["id", 3], ["LIMIT", 1]]
#<Game id: 3, word: "powershop", created_at: "2019-10-05 07:49:53", updated_at: "2019-10-05 07:49:53", lives_at_start: 5>
  Game Load (0.7ms)  SELECT  "games".* FROM "games" WHERE "games"."id" = ? LIMIT ?  [["id", 4], ["LIMIT", 1]]

  # ...etc
```

- with using eager loading

```bash
> guesses = Guess.includes(:game)
guesses = Guess.includes(:game)
  Guess Exists (0.3ms)  SELECT  1 AS one FROM "guesses" LIMIT ?  [["LIMIT", 1]]
  Guess Load (1.2ms)  SELECT "guesses".* FROM "guesses"
  Game Load (0.3ms)  SELECT "games".* FROM "games" WHERE "games"."id" IN (2, 3, 4, 5, 6, 7, 8, 10, 11, 12, 13, 14)


> guesses.each { |guess| p guess.game }

#<Game id: 2, word: "bananas", created_at: "2019-10-05 04:54:39", updated_at: "2019-10-05 04:54:39", lives_at_start: nil>
#<Game id: 2, word: "bananas", created_at: "2019-10-05 04:54:39", updated_at: "2019-10-05 04:54:39", lives_at_start: nil>
#<Game id: 2, word: "bananas", created_at: "2019-10-05 04:54:39", updated_at: "2019-10-05 04:54:39", lives_at_start: nil>
# ...etc

```

[N+1 Queries and Eager Loading](/rails/active_record.md#N+1-Queries-and-Eager-Loading)

<https://api.rubyonrails.org/classes/ActiveRecord/QueryMethods.html#method-i-includes>

<https://api.rubyonrails.org/classes/ActiveRecord/QueryMethods.html#method-i-eager_load>

## Questions from Me / Interviewee

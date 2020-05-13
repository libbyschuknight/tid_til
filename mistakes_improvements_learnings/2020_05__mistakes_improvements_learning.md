# May 2020 Mistakes, Improvements, Learning and Stuff

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

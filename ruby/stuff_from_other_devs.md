# Useful Stuff from other Devs


## Samson Ootovak (Flick Electric)
#### `.call`
Hay team just wanted to share something that I didn’t know till recently. In Ruby `.call` is a bit of a special method you can define as normal but you can call it two different ways. The first way is the way you would expect.

```ruby
class Friend
  def call
    puts "Hello!"
  end
end

friend = Friend.new
friend.call
```

The second way is almost Javascript like in that you call the method but specifying brackets.
```ruby
friend.()
```
This also works on class methods.
```ruby
class Friend
  def self.call
    puts "Hello!"
  end
end

Friend.()
```
And you can also pass parameters to it like you wold any other method call.
```ruby
class Friend
  def call(my_name)
    puts "Hello, #{my_name}"
  end
end

friend = Friend.new
friend.("Sam")
```

You will see this style of code in some of XX newer code as well as (where I think he got it from) any of the [Dry gems](http://dry-rb.org/).

The reason Ruby treats it special is that `.call` is the method that executes `Procs` and `lambdas` in Ruby. Procs and lambdas are the one way you can pass around blocks of code (the same way you can pass a function around in JS) and so this makes Ruby act more like a language that has “first-class” function support.

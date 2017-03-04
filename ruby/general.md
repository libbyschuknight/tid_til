# Ruby Stuff

### [to_proc](http://ruby-doc.org/core-2.3.0/Symbol.html#method-i-to_proc)

You can shorten:
```ruby
state_paths.to_states.map { |state| state.to_s }
```
to
```ruby
state_paths.to_states.map(&:to_s)
```
[How Does Symbol#to_proc Work?](http://benjamintan.io/blog/2015/03/16/how-does-symbol-to_proc-work/)

[Ruby Style Guide](https://github.com/bbatsov/ruby-style-guide#single-action-blocks)
> Use the proc invocation shorthand when the invoked method is the only operation of a block

### "pragma", or "directive"
> a directive pragma (from "pragmatic") is a language construct that specifies how a compiler (or assembler or interpreter) should process its input.

https://en.wikipedia.org/wiki/Directive_(programming)

Example in pull request:
```ruby
# frozen_string_literal: true
```
[Ruby 2.3 release](https://www.ruby-lang.org/en/news/2015/12/25/ruby-2-3-0-released/)


### class_attribute
http://api.rubyonrails.org/classes/Class.html#method-i-class_attribute

```ruby
included do
  class_attribute :formats
end
 ```

## Arrays

Show all data for one attribute on all your records:
```ruby
Application.all.collect(&:started_at)
```
output:
```bash
[
  [ 0] Wed, 21 Sep 2016 03:33:56 UTC +00:00,
  [ 1] Thu, 29 Sep 2016 02:42:43 UTC +00:00,
  [ 2] Wed, 21 Sep 2016 03:35:08 UTC +00:00,
  [ 3] Sun, 02 Oct 2016 22:16:28 UTC +00:00
]
```



### 2 dimensional array - array of arrays

@users.collect{ |u| [u.name, u.id] }

Wanted to make an array for `select_tag` in Rails. Found this [example](http://apidock.com/rails/ActionView/Helpers/FormTagHelper/select_tag#54-select-tag-with-options-for-select-example):

```ruby
select_tag 'user_id', options_for_select(@users.collect{ |u| [u.name, u.id] })
```
will give:
```html
<select id="user_id" name="user_id">
  <option value="1">Brad</option>
  <option value="2">Angie</option>
  <option value="3">Jenny</option>
</select>
```

### Private vs Protected (and Public)
[The difference between Public, Protected and Private methods in Ruby](http://culttt.com/2015/06/03/the-difference-between-public-protected-and-private-methods-in-ruby/)
> ... a Public method and so you can call it from outside the scope of the object.

> Both Private and Protected methods are not accessible from outside of the object as they are used internally to the object.

> So the only way to call a Private method is to do so within the context of the object instance.

> A Protected method is not accessible from outside of the context of the object, but it is accessible from inside the context of another object of the same type.


##### Private methods in modules
[Private Class Methods in Ruby](http://domon.cc/2013/12/25/private-class-methods-in-ruby/)

```ruby
module UserInformationService

  def self.overall_users_counts
    {
      started_count:      Application.started.count,
      started_today_count:    Application.started_today.count
    }
  end

  def self.collect_individual_users_data
    users_names_and_counts.sort_by { |user| user[:name] }
  end

  def self.users_names_and_counts  # this is now a private method!!
    # stuff happens in here
  end
  private_class_method :users_names_and_counts
end
```


### Keyword Arguments
ADD!! links
https://robots.thoughtbot.com/ruby-2-keyword-arguments
http://codeloveandboards.com/blog/2014/02/05/ruby-and-method-arguments/


## True / False Statements / Conditionals
If using things that return a `boolean` value, don't need to have them in a `if/else` statement.

```ruby
def valid?
  if !number_empty? && is_valid_format?
    true
  else
    false
  end
end
```

```ruby
def valid?
  !number_empty? && is_valid_format?
end
```

## Change a Hash but keep original Hash

```ruby
name_numbers = { "name1" => 1, "name2" => 2 }

{
    "name1" => 1,
    "name2" => 2
}

new_name_numbers = Hash[name_numbers.map { |name, number| [name, number * 20] } ]

{
    "name1" => 20,
    "name2" => 40
}
```

### Accessing Hashes

**ActiveSupport::HashWithIndifferentAccess**
[Quick Guide to ActiveSupport::HashWithIndifferentAccess](http://ruby-journal.com/quick-guide-to-activesupport-hashwithindifferentaccess/)
[Object::HashWithIndifferentAccess < Hash](http://api.rubyonrails.org/classes/ActiveSupport/HashWithIndifferentAccess.html)

Came across issue in test, where in code was accessing a hash in this manner:
```ruby
let(:params) { MultiJson.load(json_data) }

params.key?(:complete_switch)
```
but in the spec this was returning `nil`. However, if I accessed like this in spec:
```ruby
params.key?("complete_switch")
```
it returned `true`.

To fix for test needed to use HashWithIndifferentAccess:
```ruby
let(:params) { ActiveSupport::HashWithIndifferentAccess.new(MultiJson.load(json_data)) }
```

## Using JSON

Had a string that wanted to parse to make a json string.

Wanted to use
```
JSON.parse(string)
```
but wasn't working because of this `include Roar::JSON` being included at top.

So needed to do:
```
::JSON.parse(string)
```
The two colons make it move out of the current class. Or something like that.


### Time
Michael @Flick
>ISO8601 is more flexible that I thought, an ISO8601 can represent a time without any zone data e.g. `2016-10-02T22:12:13Z`, or it can include zone data: `2016-10-02T22:12:13+1300`

Use this in console to get the correct formatted iso8601 string

```ruby
string = "2017-01-04"
Time.parse(string).utc.iso8601
> "2017-01-04T00:00:00Z"
```


### [Precedence](https://ruby-doc.org/core-2.3.0/doc/syntax/precedence_rdoc.html)
  >From highest to lowest, this is the precedence table for ruby. High precedence operations happen before low precedence operations.


### Case statements

Thought you had to do like this:

```ruby
case
when colour == "yellow" || colour == "white"
  puts "light"
when colour == "orange"
  puts "not as light"
else
  puts "dark"
end
```
and thought this was what [The Ruby Style Guide](https://github.com/bbatsov/ruby-style-guide) was saying as well:

```ruby
# good
case
when song.name == 'Misty'
  puts 'Not again!'
when song.duration > 120
  puts 'Too long!'
when Time.now.hour > 21
  puts "It's too late"
else
  song.play
end
```

But have realised that each when is checking on different things.
And doing a quick search on case statements in ruby found out that you can do:

```ruby
case colour
when "yellow" || "white"
  puts "light"
when "orange"
  puts "not as light"
else
  puts "dark"
end
```
Would be nice if the ruby style guide covered this... although the snippet above is from the the Source Code Layout section


## `**kwargs`

[kwargs reserved word in python. What does it mean? duplicate](http://stackoverflow.com/questions/20158516/kwargs-reserved-word-in-python-what-does-it-mean)


## Ancestors

```ruby
puts buyer1.ancestors

Buyer
User
Object
Kernel
BasicObject
```

# Ruby Stuff

[Ruby Docs](https://ruby-doc.org/)

[The Ruby Style Guide](https://rubystyle.guide/) - <https://github.com/rubocop-hq/ruby-style-guide>

[Hidden features of Ruby you may not know about](https://blog.arkency.com/2014/07/hidden-features-of-ruby-you-may-dont-know-about/)

[Idiomatic Ruby: writing beautiful code](https://www.freecodecamp.org/news/idiomatic-ruby-writing-beautiful-code-6845c830c664/)

[Learn How to Program: Ruby & Rails](https://www.learnhowtoprogram.com/ruby-and-rails)

[Ruby Guides - Jesus Castello](https://www.rubyguides.com/)

## PORO = Plain Old Ruby Objects

e.g service objects, query objects, use case objects

## `attr_`

[Why use Ruby's attr_accessor, attr_reader and attr_writer?](https://stackoverflow.com/questions/5046831/why-use-rubys-attr-accessor-attr-reader-and-attr-writer)

## Ancestors

```ruby
puts buyer1.ancestors

Buyer
User
Object
Kernel
BasicObject
```

```ruby
date_range = (Date.yesterday)..(Date.today)
# Mon, 25 Sep 2017..Mon, 25 Sep 2017

date_range.class
# Range < Object
date_range.class.ancestors
# [
#     [ 0] Range < Object,
#     [ 1] Enumerable,
#     [ 2] Object < BasicObject,
#     [ 3] PP::ObjectMixin,
#     [ 4] RequireAll,
#     [ 5] V8::Conversion::Object,
#     [ 6] ActiveSupport::Dependencies::Loadable,
#     [ 7] Delayed::MessageSending,
#     [ 8] JSON::Ext::Generator::GeneratorMethods::Object,
#     [ 9] Kernel,
#     [10] BasicObject
# ]
```

## class_attribute

<http://api.rubyonrails.org/classes/Class.html#method-i-class_attribute>

```ruby
included do
  class_attribute :formats
end
```

## Operators / Operations

### [Precedence](https://ruby-doc.org/core/doc/syntax/precedence_rdoc.html) / Operator precedence

> From highest to lowest, this is the precedence table for ruby. High precedence operations happen before low precedence operations.

[Ruby - Operators](https://www.tutorialspoint.com/ruby/ruby_operators.htm)

### Bang

[Why are exclamation marks used in Ruby methods?](https://stackoverflow.com/questions/612189/why-are-exclamation-marks-used-in-ruby-methods)

> In general, methods that end in ! indicate that the method will modify the object it's called on. Ruby calls these as "dangerous methods" because they change state that someone else might have a reference to.
>
> A bang can used in the below ways, in order of my personal preference.
>
> 1. An active record method raises an error if the method does not do what it says it will.
> 2. An active record method saves the record or a method saves an object (e.g. strip!)
> 3. A method does something “extra”, like posts to someplace, or does some action.

### Question mark

<https://github.com/rubocop-hq/ruby-style-guide#boolean-methods-question-mark>

[What does the question mark operator mean in Ruby?](https://stackoverflow.com/questions/1345843/what-does-the-question-mark-operator-mean-in-ruby)

>It's a convention in Ruby that methods that return boolean values end in a question mark. There's no more significance to it than that.

<https://docs.ruby-lang.org/en/master/syntax/methods_rdoc.html>

>Methods that end with a question mark by convention return boolean, but they may not always return just true or false. Often, they will return an object to indicate a true value (or “truthy” value).

### safe navigation operator

[The Safe Navigation Operator (&.) in Ruby](http://mitrev.net/ruby/2015/11/13/the-operator-in-ruby/)

### and/or

[How to use Ruby’s English and/or operators without going nuts](http://www.virtuouscode.com/2014/08/26/how-to-use-rubys-english-andor-operators-without-going-nuts/)

### splat \* / \*\*

[An introduction to Ruby’s \*Splat and double \*\*Splat operators](https://medium.freecodecamp.org/rubys-splat-and-double-splat-operators-ceb753329a78)

[Using splats to build up and tear apart arrays in Ruby](https://www.honeybadger.io/blog/ruby-splat-array-manipulation-destructuring/)

> But the main idea is that whenever you don’t want to specify the number of arguments you have, you would use a splat operator. The simplest example would be something like this:
>
> ```ruby
> def unknown_amount(*args)
>  p args
> end
> unknown_amount(1, 2, 3)
> # => [1, 2, 3]
> ```

[Ruby double splat (\*\*) operator cheatsheet](https://jetrockets.pro/blog/ruby-double-splat-operator-cheatsheet)

#### Another use of splat

[Using splats to build up and tear apart arrays in Ruby](https://www.honeybadger.io/blog/ruby-splat-array-manipulation-destructuring/)

>Constructing arrays
>
>The splat operator is useful not only for destructuring arrays but also for constructing them.
>
>In the following example, we use splat to join two arrays.
>
>```ruby
>[*[1,2], *[3,4]]
>=> [1, 2, 3, 4]
>```
>
>This is the equivalent of `[[1, 2], [3,4]].flatten`.

### Unary / Double colon operator

[Ruby Dot "." and Double Colon "::" Operators](https://www.tutorialspoint.com/ruby/ruby_operators.htm)

## [Range](https://ruby-doc.org/core-2.2.3/Range.html)

**Date ranges - begin/end**

```ruby
date_range = (Date.parse("16/9/2017"))..(Date.today)
# Sat, 16 Sep 2017..Mon, 25 Sep 2017

date_range.begin
# Sat, 16 Sep 2017

date_range.end
# Mon, 25 Sep 2017
```

**Quickly making an array**

```ruby
("a".."f").to_a
# => ["a", "b", "c", "d", "e", "f"]
```

## [to_proc](http://ruby-doc.org/core-2.3.0/Symbol.html#method-i-to_proc)

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

## "pragma", or "directive"

> a directive pragma (from "pragmatic") is a language construct that specifies how a compiler (or assembler or interpreter) should process its input.

<https://en.wikipedia.org/wiki/Directive_(programming)>

Example in pull request:

```ruby
# frozen_string_literal: true
```

[Ruby 2.3 release](https://www.ruby-lang.org/en/news/2015/12/25/ruby-2-3-0-released/)

### frozen_string_literal

[An Introduction to Frozen String Literals](https://freelancing-gods.com/2017/07/27/an-introduction-to-frozen-string-literals.html)

[Friendly Frozen String Literals](https://freelancing-gods.com/2017/07/27/friendly-frozen-string-literals.html)

[Explain the difference between strings and symbols like I am five](https://dev.to/laurosilvacom/explain-the-difference-between-strings-and-symbols-like-i-am-five-2j73)

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

### Quickly making an array

```ruby
[*"a".."f"]
# => ["a", "b", "c", "d", "e", "f"]
```

as well as using a range above

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

## Private vs Protected (and Public)

[The difference between Public, Protected and Private methods in Ruby](http://culttt.com/2015/06/03/the-difference-between-public-protected-and-private-methods-in-ruby/)

> ... a Public method and so you can call it from outside the scope of the object.
>
> Both Private and Protected methods are not accessible from outside of the object as they are used internally to the object.
>
> So the only way to call a Private method is to do so within the context of the object instance.
>
> A Protected method is not accessible from outside of the context of the object, but it is accessible from inside the context of another object of the same type.

### Private methods in modules'

[Private Class Methods in Ruby](http://domon.cc/2013/12/25/private-class-methods-in-ruby/)

```ruby
module UserInformationService

  def self.overall_users_counts
    {
      started_count:          Application.started.count,
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

## Keyword Arguments

[Ruby and method arguments](http://codeloveandboards.com/blog/2014/02/05/ruby-and-method-arguments/)

[Ruby 2 Keyword Arguments](https://robots.thoughtbot.com/ruby-2-keyword-arguments),

[Keyword arguments in Ruby 2.0](http://brainspec.com/blog/2012/10/08/keyword-arguments-ruby-2-0/))

[Utilizing Ruby Keyword Arguments](https://medium.com/@tyler_brewer2/utilizing-ruby-keyword-arguments-462ba8366483)

With a method like this:

```ruby
def enter_details(cost:, start_date:, end_date:)
  cost_field.set(cost)
  start_date_field.type_date(start_date)
  end_date_field.type_date(end_date)
end

# called

admin_app.new_premium_provider_page.form.enter_details(
  name: "Alice",
  start_date: "01 Jan 2014",
  end_date: ""
)

# could pass in default values to the method

def enter_details(cost:, start_date: "", end_date: "")
...
end

# then can just do
admin_app.new_premium_provider_page.form.enter_details(name: "Alice", start_date: "01 Jan 2014")
```

### `**kwargs` - keyword arguments

[kwargs reserved word in python. What does it mean? duplicate](http://stackoverflow.com/questions/20158516/kwargs-reserved-word-in-python-what-does-it-mean)

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

## Hashes

### Change a Hash but keep original Hash

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

### Hash Rockets

[Why did Ruby 1.9 do away with hash rocket syntax?](https://www.quora.com/Why-did-Ruby-1-9-do-away-with-hash-rocket-syntax)

```ruby
x = {:name => "Tom", :location => "London"}

x = {name: "Tom", location: "London"}

# This saves a few characters and may be a bit more readable.

# There are still situations when you will need to use the hashrocket, for instance: if you want to use strings as keys.

x = {"name" => "Tom", "location" => "London"}
```

### `delete(key)`

https://ruby-doc.org/core-2.4.5/Hash.html#method-i-delete

```ruby
h = { "a" => 100, "b" => 200 }
h.delete("a")   #=> 100
```

> Deletes the key-value pair and returns the value from hsh whose key is equal to key.

## Using JSON

Had a string that wanted to parse to make a json string.

Wanted to use

```js
JSON.parse(string);
```

but wasn't working because of this `include Roar::JSON` being included at top.

So needed to do:

```js
::JSON.parse(string);
```

The two colons make it move out of the current class. Or something like that.

## Time

Michael @Flick

> ISO8601 is more flexible that I thought, an ISO8601 can represent a time without any zone data e.g. `2016-10-02T22:12:13Z`, or it can include zone data: `2016-10-02T22:12:13+1300`

Use this in console to get the correct formatted iso8601 string

```ruby
string = "2017-01-04"
Time.parse(string).utc.iso8601
> "2017-01-04T00:00:00Z"
```

## Case statements

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

## ri - ruby documentation

<http://stackoverflow.com/a/1728941/4772356>

```bash
ri File.open
ri open
ri IO.foreach
ri File#each_line
```

## tap - object

> Yields self to the block, and then returns self. The primary purpose of this method is to “tap into” a method chain, in order to perform operations on intermediate results within the chain.

<https://ruby-doc.org/core-2.2.3/Object.html#method-i-tap>

[advantage of tap method in ruby](http://stackoverflow.com/questions/17493080/advantage-of-tap-method-in-ruby)

[Understanding tap in Ruby](http://stackoverflow.com/questions/25191805/understanding-tap-in-ruby)

## Patterns

~~[Decorators, Presenters, Delegators and Rails](https://robertomurray.co.uk/blog/2014/decorators-presenters-delegators-rails/)~~ - dead link 😢

[Using SimpleDelegator for your Decorators](https://hashrocket.com/blog/posts/using-simpledelegator-for-your-decorators)

An example:

```ruby
class ChargeBatchDecorator < SimpleDelegator
  def self.wrap(collection)
    collection.map do |object|
      new(object)
    end
  end

  def completed?
    status == "completed"
  end

  def processing?
    status == "processing"
  end

  def failed?
    status == "failed"
  end

  def status_icon
    if completed?
      "✅"
    elsif processing?
      "⚠️"
    elsif failed?
      "❌"
    else
      "❓"
    end
  end
end
```

The object in this case being an OpenStruct:

```ruby
ChargeBatch {
             :id => "549a3164-08b6-4c63-b603-e6464da83b20",
           :kind => "charge_batch",
    :description => "FLCK_E_FLCK_YINVHDR_201610_20170807_152642_19700101000000.csv",
    :upload_date => "2017-08-29T23:53:52Z",
         :status => "completed"
}
```

## Using `try()`

[try(), try() again in Rails](https://everydayrails.com/2011/04/28/rails-try-method.html)

[Do, or do not. There is no #try.](http://www.virtuouscode.com/2011/06/28/do-or-do-not-there-is-no-try/)

[Demeter: It’s not just a good idea. It’s the law.](http://www.virtuouscode.com/2011/07/05/demeter-its-not-just-a-good-idea-its-the-law/)

## Memoization

Great article:

[The Basics of Ruby Memoization](http://gavinmiller.io/2013/basics-of-ruby-memoization/)

[4 Simple Memoization Patterns in Ruby (And One Gem)](https://www.justinweiss.com/articles/4-simple-memoization-patterns-in-ruby-and-one-gem/)

[Ruby Memoization and Alternatives](https://thoughtbot.com/blog/ruby-memoization-and-alternatives)

>Memoization has two big benefits:
>
>1. Cache expensive work
>2. Delay expensive work via laziness
>As a form of caching it comes with all the advantages and downsides of such. It also complicates a codebase.
>
>Most common uses of memoization in Ruby are premature optimization. For operations that:
>
>- are always used by your object then set the instance variable in the constructor and have a normal reader
>- are only used once then a regular method is fine
>- are cheap then a regular method is fine
>- are expensive and not always used then you may want to use a memoized method to do the work lazily
>In all cases, move the calculation to its own method!

e.g.

>Doing
>
>```ruby
>def foo
>  @foo ||= dosomething
>end
>```
>
>Allows you to cache the result of `dosomething` so we don't run it every time foo is called

[Speeding up Rails with Memoization](https://www.honeybadger.io/blog/ruby-rails-memoization/?utm_source=rubyweekly&utm_medium=email&utm_campaign=ruby)

## alias keyword and method

[Alias in Ruby](https://medium.com/rubycademy/alias-in-ruby-bf89be245f69)

## Set ruby version

using `rbenv` do `rbenv local 2.4.5` and it will create a file `.ruby-version` with the version number in it.

Then you need to do `bundle install` to get all the gems with this version and probably need to do a `rbenv rehash` either before or after or both.

## The % Notation - `%w, %i`

<https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Literals#The_.25_Notation>

<https://ruby-doc.org/core-2.5.1/doc/syntax/literals_rdoc.html#label-Percent+Strings>

<http://ruby.zigzo.com/2014/08/21/rubys-notation/>

## `Struct` in Ruby

<https://ruby-doc.org/core-2.5.0/Struct.html>

>A Struct is a convenient way to bundle a number of attributes together, using accessor methods, without having to write an explicit class.

### `keyword_init`

>If the optional keyword_init keyword argument is set to true, .new takes keyword arguments instead of normal arguments.

```ruby
Customer = Struct.new(:name, :address, keyword_init: true)
Customer.new(name: "Dave", address: "123 Main")
#=> #<struct Customer name="Dave", address="123 Main">
```

[How to Use Struct & OpenStruct in Ruby](https://www.rubyguides.com/2017/06/ruby-struct-and-openstruct/)

## Use Cases

[A Case For Use Cases](https://webuild.envato.com/blog/a-case-for-use-cases/)

- [CommandQuerySeparation](https://martinfowler.com/bliki/CommandQuerySeparation.html)

  >The fundamental idea is that we should divide an object's methods into two sharply separated categories:
  >Queries: Return a result and do not change the observable state of the system (are free of side effects).
  >Commands: Change the state of a system but do not return a value.

## Guard clause

[Guard Clauses vs. Nested Conditionals](https://anthonygharvey.com/ruby/guard_clauses_vs_nested_if_statements)

[PREFER GUARD CLAUSES OVER NESTED CONDITIONALS](https://www.thechrisoshow.com/2009/02/16/using-guard-clauses-in-your-ruby-code/)

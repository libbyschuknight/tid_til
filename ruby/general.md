# Stuff I Forget

#### [to_proc](http://ruby-doc.org/core-2.3.0/Symbol.html#method-i-to_proc)

You can shorten:
```ruby
state_paths.to_states.map { |state| state.to_s }
```
to
```ruby
state_paths.to_states.map(&:to_s)
```
[How Does Symbol#to_proc Work?](http://benjamintan.io/blog/2015/03/16/how-does-symbol-to_proc-work/)



# New

#### "pragma", or "directive"
> a directive pragma (from "pragmatic") is a language construct that specifies how a compiler (or assembler or interpreter) should process its input.

https://en.wikipedia.org/wiki/Directive_(programming)

Example in pull request:
```ruby
# frozen_string_literal: true
```
[Ruby 2.3 release](https://www.ruby-lang.org/en/news/2015/12/25/ruby-2-3-0-released/)


#### class_attribute
http://api.rubyonrails.org/classes/Class.html#method-i-class_attribute

```ruby
included do
  class_attribute :formats
end
 ```

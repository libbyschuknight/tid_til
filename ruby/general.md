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

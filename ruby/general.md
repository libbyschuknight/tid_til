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

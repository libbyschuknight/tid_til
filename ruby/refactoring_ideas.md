# Refactoring Ideas
These are things that have come up during code reviews by my co-workers/peers

@run_at = Time.zone.now.utc
ADDDDDDD!!


### Returning `true` / `false`

I have a habit of doing this:

```ruby
if application.switch_type == type && application.move_date.blank?
  true
else
  false
end
```
I think I end up with this as I kind of pseudocode and write it out fully and forget about the fact that this `application.switch_type == type` returns `true` or `false`, as well as this `application.move_date.blank?`.

So I can just have:
```ruby
application.switch_type == type && application.move_date.blank?
```

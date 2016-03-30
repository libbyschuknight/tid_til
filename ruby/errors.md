# Errors

#### Rescue Errors
I have found this useful when needing to rescue errors as well as at times using it to find out more about the error.

```ruby
begin
  raise BadRequest
rescue => error
  p error.inspect
end
```
See [Rescue StandardError, Not Exception](https://robots.thoughtbot.com/rescue-standarderror-not-exception)

Used to rescue a database error and return empty array:

```ruby
begin
  @buckets = stones.collect do |stone|
    facade = Facades::CategoryFacade.new(stone)
  end
rescue Sequel::DatabaseError
  return @buckets = []
end
```

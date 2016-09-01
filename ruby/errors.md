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

## One way to deal with errors

Create a method to handle them:

```ruby
def handle_error(resource, check_value)
  if check_value
    @success  = true
  elsif resource.error
    @error    = resource.error
    @success  = false
  else
    @success  = false
  end
end
```

Called:

```ruby
url_format_csv = "#{url}?format=csv"
fetcher = CsvFetcher.new(url: url_format_csv)
fetcher.fetch_by_url

if handle_error(fetcher, fetcher.response_body)
  fetcher.response_body
end
```

The "fetcher" does this:

```ruby
class CsvFetcher

  attr_reader :url, :response_body, :error

  def initialize(url: url)
    @url = url
  end

  def fetch_by_url
    request = Typhoeus::Request.new(
      ENV["FLICK_API_HOST"] + url,
      method: :post,
      headers: { "Auth" => "auth" }
    )

    response = request.run

    if response.success?
      @response_body = response.body
    elsif response.timed_out?
      @error = "Network HTTP Request Time Out"
    else
      @error = "Network HTTP Request failed: #{response.code.to_s}"
    end
  end

end
```

So the `handle_error` method takes in a resource and a check value that will be nil or not nil.

And if there are errors, it can get the error from the resource, as the resource has an `@error` (instance variable).

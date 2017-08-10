# August Mistakes & Improvements

Got this idea from organiser of https://twitter.com/SheNomads
- https://gist.github.com/LNA/3f66ec30e299289cb96ce1dea7a31a45

My aim:
- to track my programming mistakes here, so I can reflect what I've been learning, improve my skill set
- see if there are any patterns in my mistake making
- what concepts aren't sticking?


## string interpolation in JS

Had these two functions:

```js
function makeTableRow(data, target) {
  var number = data["records"]["total"].toLocaleString();
  var processed = data["records"]["processed"].toLocaleString();

  $(target).html(
    `<tr>
    <td></td>
    <td colspan="2">Number of records: ${number} </td>
    <td></td>
    <td></td>
    </tr>
    <tr>
      <td></td>
      <td colspan="2">Number of processed records: ${processed}</td>
      <td></td>
      <td></td>
    </tr>`
  );
}

function displayError(error_message, link, target) {
  $(target).addClass("error");
  $(target).html(`<tr><td colspan="5">${error_message} ${link}</td></tr>`);
}
```
Was hoping they would work online but didn't.
Changed the code in the `makeTableRow` but didn't look through the rest of the code and missed the backticks in the `displayError` function. Which meant I had to change, push and re-deploy. 😞


## Adding a dataset method on a Sequel model

Have a `ImportFile` Sequel model.

Doing this:

```ruby
module ChargeSourcesService
  def self.find_charge_sources
    ImportFile.order(:created_at).limit(20)
  end
end
```

Was having trouble testing it. Suggestion was to add a method to the `ImportFile` model, so that the service has no need to know about any queries / sql.

```ruby

class ImportFile < Sequel::Model
  def_dataset_method(:recent_sources) do
    order(:created_at).limit(20)
  end
end

# then

module ChargeSourcesService
  def self.find_charge_sources
    ImportFile.recent_sources
  end
end
```

## Mounting controller in Ruby Grape API

Was getting this error in a test:

```bash
1) Stuffs::StuffsController retrieving charge sources unauthorized returns an error
     Failure/Error: response_json = JSON.parse(last_response.body)

     JSON::ParserError:
       784: unexpected token at '404 Not Found'
     # ./spec/api/lib/stuffs/controllers/stuffs_controller_spec.rb:14:in `block (4 levels) in <module:Stuffs>'
     # ./spec/support/test_within_transaction.rb:4:in `block (3 levels) in <top (required)>'
     # ./spec/support/test_within_transaction.rb:4:in `block (2 levels) in <top (required)>'
```

Added new controller but forgot to mount it in the `root_controller`

```ruby
require ... things
require_relative "../../stuffs/controllers/stuffs_controller"

module Stuffs
  class RootController < Grape::API
    use Rollbar::Middleware::Sinatra

    APP_NAME = "billing"

    format       :json
    formatter    :json, Grape::Formatter::Roar
    content_type :json, "application/vnd.flick+json"
    prefix       ENV['MOUNTED_AT']
    version      "v1", using: :header, vendor: "flick"

    before do
      header["Access-Control-Allow-Origin"]   = "*"
      header["Access-Control-Request-Method"] = "*"
    end

    mount Stuffs::StuffsController
  end
end
```

## OMG! Read the error message more carefully!

Couple things here, firstly I didn't look at this line carefully enough:
`uninitialized constant Billing::ChargeSourcesController::ChargeSourceService`

As it should be `ChargeSourcesService` - sources instead of source.

Secondly, I made that mistake yesterday in the spec file, so I then jumped straight to the spec file looking for the problem.
Initially I thought it was a file loading error/mistake and tried adding in `Billing::ChargeSources::ChargeSourcesService` and combos of those to where I had `ChargeSourcesService` in the spec file. But no, it was not that.

Thirdly, I didn't take the time to look carefully at the rest of the error message and missed that the first line:
`# ./apps/api/lib/charge_sources/controllers/charge_sources_controller.rb:30:in `block (2 levels) in <class:ChargeSourcesController>'`

show that it is in the controller not in the spec file!

```bash
Failures:

  1) Billing::ChargeSourcesController retrieving charge sources authorised returns the expected json
     Failure/Error: get "billing/charge_sources"

     NameError:
       uninitialized constant Billing::ChargeSourcesController::ChargeSourceService
     # ./apps/api/lib/charge_sources/controllers/charge_sources_controller.rb:30:in `block (2 levels) in <class:ChargeSourcesController>'
     # ./spec/api/lib/charge_sources/controllers/charge_source_controller_spec.rb:47:in `block (4 levels) in <module:Billing>'
     # ./spec/support/test_within_transaction.rb:4:in `block (3 levels) in <top (required)>'
     # ./spec/support/test_within_transaction.rb:4:in `block (2 levels) in <top (required)>'
...

Finished in 0.14194 seconds (files took 3.92 seconds to load)
3 examples, 1 failure, 1 pending

Failed examples:

rspec ./spec/api/lib/charge_sources/controllers/charge_source_controller_spec.rb:29 # Billing::ChargeSourcesController retrieving charge sources authorised returns the expected json
```

## Handling null value
Question in code review - "Do we need to handle the case in which these are null?"

Code was:

```js
function makeTableRow(data, target) {
  var number = data["records"]["total"].toLocaleString(); // could be no total
  var processed = data["records"]["processed"].toLocaleString(); //could be no processed

  $(target).html(
    '<tr>' +
      '<td></td>' +
      '<td colspan="2">Number of records: ' + number + '</td>' +
      '<td></td>' +
      '<td></td>' +
    '</tr>' +
    '<tr>' +
      '<td></td>' +
      '<td colspan="2">Number of processed records: ' + processed + '</td>' +
      '<td></td>' +
      '<td></td>' +
    '</tr>'
  );
}
```

What I changed to:

```js
function makeTableRow(data, target) {
  var records = data['records'];
  var total = records['total'];
  var processed = records['processed'];
  if (total && processed) {
    var total_string = total.toLocaleString();
    var processed_string = processed.toLocaleString();
    constructHtml(target, total_string, processed_string);
  } else {
    var url = data["_links"]["self"]["href"];
    displayError('Oh no! Not all the details could be retrieved for: ', url, target);
  }
}

function constructHtml(target, total_string, processed_string) {
  $(target).html(
    '<tr>' +
    '<td></td>' +
    '<td colspan="2">Number of records: ' + total_string + '</td>' +
    '<td></td>' +
    '<td></td>' +
    '</tr>' +
    '<tr>' +
    '<td></td>' +
    '<td colspan="2">Number of processed records: ' + processed_string + '</td>' +
    '<td></td>' +
    '<td></td>' +
    '</tr>'
  );
}
```

So, if there is no `total` or `processed`, will return an error message to the view.


## Add in Result object to handle success

Was this:

```ruby
def self.delete_source(id:, source_deleter: self)
  path = "#{resource_path}/#{id}"
  source_deleter.delete(path)
rescue RequestError, ResourceError => error
  Rollbar.error(error)
  raise SourceError, "Source deletion error."
end
```

And the class that was calling this was doing:

```ruby
def self.delete(id:)
  response = Something::Resources::Source.delete_source(id: id)
  response == 200 ? true : false
end
```

Changed to:

```ruby
Result = Struct.new(:code) do
  def success?
    code == 200
  end
end

def self.delete_source(id:, source_deleter: self)
  path = "#{resource_path}/#{id}"
  Result.new(source_deleter.delete(path))
rescue RequestError, ResourceError => error
  Rollbar.error(error)
  raise SourceError, "Source deletion error."
end
```

and

```ruby
def self.delete(id:)
  response = Something::Resources::Source.delete_source(id: id)
  response.success?
end
```


## Using RESTful routes instead of adding others

Had:

```ruby
resources :charge_sources, only: [:index, :show, :destroy] do
  collection do
    get "detailed_view" => "charge_sources#show"
  end
end
```

Changed to:
```ruby
resources :charge_sources, only: [:index, :show, :destroy]
```

Action is called via click and ajax call, in view is:


```erb
<table class="highlight accordion" data-detailed-view="<%= Base64.urlsafe_encode64(charge_source.links[:detailed_view].href) %>">
```

Encoded the url/href here so that the server would not try to just add it to the end of the show action.

It was trying to do this:

```
ActionController::RoutingError (No route matches [GET] "/charge_sources/something/charge_sources/bd28b37e-2dc2-46a8-86c8-3e80b4fd6afe/detailed_view"):
```

With the encoding and then decoding in the controller it now is this:

```
Started GET "/charge_sources/L2JpbGxpbmcvY2hhcmdlX3NvdXJjZXMvYmQyOGIzN2UtMmRjMi00NmE4LTg2YzgtM2U4MGI0ZmQ2YWZlL2RldGFpbGVkX3ZpZ
```

The decoding in the controller:

```ruby
link = Base64.urlsafe_decode64(params[:id])
```


## Query.sql / Ruby

Reminders

```bash
$ FileData.order(:total).limit(5).sql
=> SELECT * FROM \"file_data\" ORDER BY \"total\" LIMIT 5
```

```ruby
FileData.order(:total).limit(5).collect { |record| record.total }

# same as

FileData.order(:total).limit(5).collect(&:total)
```


## Hashes!!
Small things, difference between writing a hash like this:

```ruby
params = { "id" => "1224" }

params["id"] == "1224"

# but

params[:id] == nil

# where as

params = { id: "1224" }

params[:id] == "1224"
```

Issue I came across in RSpec test. Something to remember!


## Testing in Rspec with Sequel vs ActiveRecord

Was doing an `allow`:

```ruby
allow(InvoiceSourceImport).to receive(:find).with(id).and_return(header_import)

# but getting this error

<Billing::InvoiceSourceImport (class)> received :find with unexpected arguments
   expected: ("95c11a2c-438e-44dd-b27d-e9acac63d99f")
        got: ({:id=>"95c11a2c-438e-44dd-b27d-e9acac63d99f"})
```

Collegue pointed out the the Sequel `find` method takes `id` as an argument, so need to do:

```ruby
allow(InvoiceSourceImport).to receive(:find).with(id: "id").and_return(header_import)
```

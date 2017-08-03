# August Mistakes

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

Added new controller but forgot to mount it in the `root_controller`

```ruby
require ... things
require_relative "../../stuffs/controllers/stuffs_controller"

module Billing
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

    mount Billing::StuffsController
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

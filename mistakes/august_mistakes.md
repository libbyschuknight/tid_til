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

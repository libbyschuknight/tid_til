# Rails View Stuff

## Formtastic
At work we are using [Formtastic](https://github.com/justinfrench/formtastic).
[more docs](http://www.rubydoc.info/github/justinfrench/formtastic)


Having had no prior knowledge of Formtastic and little experience with forms, let alone complex forms, I continually find it difficult to search and find answers to problems I am having with getting things working with Formtastic.
Usually it is to do with the html formatting of part of the form.

E.g. I wanted to disable a submit action (button).
Tried:

```ruby
= f.action :submit, disabled: true, label: "Add Credit Card"
= f.action :submit, :disable_with => 'Processing...', label: "Add Credit Card"
= f.action :submit, :input_html => { :disabled => true }, label: "Add Credit Card"
= f.action :submit, label: "Add Credit Card", disabled: disabled
```
Before coming across a post that had:
```ruby
<%= f.action :submit, :button_html => { :label => "create case", :class => "btn primary", :disable_with => 'Processing...'} % >
```
So tried this and it worked!
```ruby
= f.action :submit, button_html: { disabled: true },label: "Add Credit Card"
```


## Date Time Helper
```ruby
module DateTimeHelper
  DEFAULT_DATE_FORMAT = "%d %B %Y".freeze

  def date_format(time, format: DEFAULT_DATE_FORMAT)
    time.in_time_zone.strftime(format)
  end
end
```
So if date is showing as `2017-06-01`, use `date_format` method

```erb
<%= date_format Model.date %>
```

And will show as `01 June 2017`

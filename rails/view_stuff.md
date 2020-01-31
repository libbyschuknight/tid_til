# Rails View Stuff

## Forms

<https://api.rubyonrails.org/classes/ActionView/Helpers/FormHelper.html>

<https://guides.rubyonrails.org/form_helpers.htm>

<https://apidock.com/rails/ActionView/Helpers/FormHelper/form_for>

<https://guides.rubyonrails.org/form_helpers.html#customizing-form-builders>

[Rails 5.1's form_with vs. form_tag vs. form_for](https://m.patrikonrails.com/rails-5-1s-form-with-vs-old-form-helpers-3a5f72a8c78a)

[form_with — Building HTML forms in Rails 5.1](https://medium.com/@tinchorb/form-with-building-html-forms-in-rails-5-1-f30bd60ef52d)

### Formtastic

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
= f.action :submit, button_html: { disabled: true }, label: "Add Credit Card"
```

## Helpers

### Date Time Helper

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

## strftime

If you want to have good spacing for dates and times, use this:
e.g.
`09 Jan 2018 - 9:51am`

`%-d %b %Y` but a `-` between the `%` and the `d` and get:

`9 Jan 2018 - 9:51am`

## Using `capture`

[Using concat and capture to clean up custom Rails helpers](https://thepugautomatic.com/2013/06/helpers/)

## Buttons / Links

[Rails' default HTTP methods for button_to and link_to helpers](https://cardoni.net/rails-button-to-vs-link-to-url-helpers/)

Case in point, was doing this:

`<%= button_tag "Refresh page", billing_reports_path, class: "green" %>`

Only wanted it to redirect to a page but it kept wanting to create something because the actual html is:

```html
<form class="button_to" method="post" action="/billing_reports">
  <input class="green" type="submit" value="Refresh page">
  <input type="hidden" name="authenticity_token" value="xyz">
</form>
```

Whereas if you do:

`<%= button_to "Refresh page", billing_reports_path, method: :get, class: "green" %>`

you get:

```html
<form class="button_to" method="get" action="/billing_reports">
  <input class="green" type="submit" value="Refresh page">
</form>
```

## render

[Layouts and Rendering in Rails](https://guides.rubyonrails.org/layouts_and_rendering.html)

[Ruby On Rails : difference between render and `render partial: :template`| Passing locals in partials](https://cbabhusal.wordpress.com/2015/06/19/ruby-on-rails-difference-between-render-and-render-partial/)

>render is a shorthand for render :partial.
>render will not accept additional local variables for the partial, you need to use render :partial

[Using Partials (Rails Guide)](http://guides.rubyonrails.org/layouts_and_rendering.html#using-partials)

### Different syntax for rendering views

```ruby
render :partial => "customer_row"
render :partial => "/layouts/mobile_header"

render :partial => 'form', :locals => {:f => f}

render 'admin/billings/menu'

```

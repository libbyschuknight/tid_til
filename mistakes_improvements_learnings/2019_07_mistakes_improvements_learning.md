<!-- TODO: Remane 2018 files -->

# July 2019 Mistakes, Improvements, Learning and Stuff

## FormBuilder methods and customising

For the work we are doing on the pattern library at work, we are customisting `ViewHelpers` and `FormBuilders`.
I will try and explain what we are doing.
We are adding a `text input` and wanting to have it for both a form helper tag (the basic helpers ending in `*_tag` - https://guides.rubyonrails.org/form_helpers.html#helpers-for-generating-form-elements)...

```html
<%= form_tag("/search", method: "get") do %>
  <%= label_tag(:q, "Search for:") %>
  <%= text_field_tag(:q) %>
  <%= submit_tag("Search") %>
<% end %>
```
and for forms dealing with model objects.

You can use the `*_tag` methods, but Rails makes things work with models and you drop the `_tag` of the method name:

>A particularly common task for a form is editing or creating a model object. While the *_tag helpers can certainly be used for this task they are somewhat verbose as for each tag you would have to ensure the correct parameter name is used and set the default value of the input appropriately. Rails provides helpers tailored to this task. These helpers lack the _tag suffix, for example text_field, text_area.

```html
<%= text_field(:person, :name) %>

<!-- instead of  -->

<%= text_field_tag(:query) %>
```

And then with the binding of a form to an object (https://guides.rubyonrails.org/form_helpers.html#binding-a-form-to-an-object), by using `form_with` or `form_for` you can use the form builder object - *"The form_for method yields a form builder object (the f variable)."*

```html
<%= form_for @article, url: {action: "create"}, html: {class: "nifty_form"} do |f| %>
  <%= f.text_field :title %>
  <%= f.text_area :body, size: "60x12" %>
  <%= f.submit "Create" %>
<% end %>
```

The way that we are building out out components at the moment is that we have:

- a `TextInput`
- a `Field`
- and then a `TextInputField`

this is so that we can have different levels of html around each part and then reuse them as well.

These means that for each of these we have to have custom methods for `ViewHelpers` and `FormBuilders`.
We have just been looking at the `Field` component and we hadn't actually added any methods for the `FormBuilder` but we do as we need to make sure that a label is added for an attribue on the model.

Before adding the implementation for the pattern library, for the `title` attribute (field) on the a model (`Promotion` model) we have the form builder:

```html
<%= f.label :title %>
<%= f.text_field :title, :class => "input" %>

<!-- generation this -->

<label for="promotion_title">Title</label>
<input class="input" type="text" name="promotion[title]" id="promotion_title">
```

With the current implementation of the `Field` component (which does not have any `FormBuilder` methods) we get:

```html
<%= f.apl_text_input_field_v1 :title %>

<!-- it just generates this -->
<div class="apl-field-v1_0 ">
  <input class="apl-text-input-v1_1 " aria-describedby="" type="text" name="promotion[title]" id="promotion_title">
</div>
```

But we want the component (`apl_text_input_field_v1`) to automatically add the label so that `<%= f.label :title %>` doesn't need to be added by the dev, plus we add more stuff like that `div` above.

The output should look similar to the output we get when using the `apl_text_input_field_tag_v1` `ViewHelper` method.

```html
<div class="apl-field-v1_0 extra-field-libby-name has-error">
  <label class="apl-field__label" for="apl-text-input-field-v1_0-2">APL Field tag test</label>
  <input type="text" name="test-field" id="apl-text-input-field-v1_0-2" value="Some text" class="apl-text-input-v1_1 input-class-name" aria-describedby="apl-text-input-field-v1_0-2-error-text apl-text-input-field-v1_0-2-help-text">
  <div class="apl-field__help-text" id="apl-text-input-field-v1_0-2-help-text">Enter your full name</div>
  <div role="alert" class="apl-field__error-text" id="apl-text-input-field-v1_0-2-error-text">wrong input</div>
</div>
```

This is useful when thinking/learning about the `form_builder` methods:

[ActionView::Helpers::FormBuilder < Object](https://api.rubyonrails.org/classes/ActionView/Helpers/FormBuilder.html)

And in particular in this case around the `label` method - https://api.rubyonrails.org/classes/ActionView/Helpers/FormBuilder.html#method-i-label


## Ruby Mine / doing `bundle open <gem>`

A couple of my colleagues use [RubyMine](https://www.jetbrains.com/ruby/) and it works in such a way that you can easily look at the methods etc of gems that are included in your Rails project.

I use [VSCode](https://code.visualstudio.com/) and it doesn't have this ability. (It actually might have this ability with this extension https://github.com/rubyide/vscode-ruby / https://marketplace.visualstudio.com/items?itemName=rebornix.Ruby)

But what you can do instead is `bundle open rails` for example and then you have access to all the rails gem code.

*Note:* further to this, I was able to do `bundle open rails` and see everything (all the gems) as we use a forked version at work. However, now `rails` is separeated out into gems - https://github.com/rails/rails#frameworks-and-libraries, so doing `bundle open rails` only opens up the readme for rails. For what I wanted to be looking at I need to do `bundle open actionview` if I was using a standard rails app where rails had not been forked (and had all the gems in it already)

I have just done this as I am working on adding methods to the `FormBuidler` and wanted to take a closer look at the `label` method

https://api.rubyonrails.org/classes/ActionView/Helpers/FormBuilder.html#method-i-label

And have also put a `binding.pry` in there so I can have a nosey around.

Actually dived into a bit of a rabbit hole by looking at more methods in Rails.

Started by searching for `label(method`, which took me to `actionview/lib/action_view/helpers/form_helper.rb:2025`, which is this code:

```ruby
def label(method, text = nil, options = {}, &block)
  @template.label(@object_name, method, text, objectify_options(options), &block)
end
```

Then used the "Go to definition" function in VScode to find the `label` method on `@template.label`, which took me to here `actionview/lib/action_view/helpers/form_helper.rb:1115` and this:

```ruby
def label(object_name, method, content_or_options = nil, options = nil, &block)
  Tags::Label.new(object_name, method, self, content_or_options, options).render(&block)
end
```

Then looked at `Label`, `actionview/lib/action_view/helpers/tags/label.rb`. Not that I figured anything out but really interesting looking at the Rails code. Think it is the first time I have done it and some of it has made sense.


## Using the `label` method on the `FormBuilder`

Further to the above, I paired with a colleague and we figured some stuff out and solved our problem. Our problem was that we have added a customised `FormBuilder`:

```ruby
class AplFormBuilder < ActionView::Helpers::FormBuilder
  include ::APL::DatePicker::FormBuilderMethods
  include ::APL::Field::FormBuilderMethods
  include ::APL::TextInput::FormBuilderMethods
  include ::APL::TextInputField::FormBuilderMethods
...
end
```

And have been including lots of form builder methods. One of which uses the `label(method, text = nil, options = {}, &block)` on the `FormBuilder`.

Because of stuft that we were doing and some other things were working, we needed a way that we could add a `span` inside of the `label` while still showing the correct value for the name of that label. And making sure that it would work if there were helper translations being used or activerecord translations being used.

Digging into the rails code we came up with doing this:

```ruby
label(method, nil, class: class_names_label) do |label_builder|
  if options[:label]
    @template.concat options[:label]
  else
    @template.concat label_builder.translation
  end

  @template.concat optional_label
end
```
It is basically because we want to be able to add this optional span within the label, previosuly the way we were doing it:

```ruby
label = options[:label] + optional_label
label(method, label, class: class_names_label)
```
And with this, the underlying code using `method` to create the text for the label was being overwritten by what we were passing into the second argument. So we needed a way that we could have the text from the `method` (e.g. if the method was `:first_name` then the text would be `First name`, that would do the translation stuff if needed AND pass in the optional `span`, within the label.

Hence the solution above which ends up outputting this HTML:

```html
<label class="apl-field__label" for="promotion_title">
  Title
  <span class="apl-field__optional-text">Optional</span>
</label>
```



## TODO: finish: add about method and id

okay I believe I have fixed it! So what was happening was that an id was being passed all the way through to `text_field(method, options)` in `options` and if you pass an id in options to that method it overrides the id created  from using `method`.
So have deleted out the id from the `text_input_options` before they get passed to `apl_text_input_v1_1` where the `text_field` method is called! Yay! exciting!
Will pull down your changes thomas and then push mine.

libby  [8 hours ago]
oh and because I am removing that is from `text_input_options` then all of the id creation we have done before that is used for the error text etc etc !! :smile:



```html
<div class="apl-field-v1_0 field-class-name has-error">
  <label class="apl-field__label" for="person_firstName">
    this is a title for the label
    <span class="apl-field__optional-text">Optional</span>
  </label>
  <input
    placeholder="text input with field should have label"
    class="apl-text-input-v1_1 input-class-name"
    aria-describedby="-error-text -help-text"
    type="text" name="person[firstName]"
    id="person_firstName">
  <div role="alert"
    class="apl-field__error-text"
    id="-error-text">
      wrong input
    </div>
  <div
    class="apl-field__help-text"
    id="-help-text">
      this is help text
  </div>
</div>


<div class="apl-field-v1_0 field-class-name has-error">
  <label class="apl-field__label" for="person_firstName">
    this is a title for the label
    <span class="apl-field__optional-text">Optional</span>
  </label>
  <input
    id="apl-text-input-field-v1_0-1"
    placeholder="text input with field should have label"
    class="apl-text-input-v1_1 input-class-name"
    aria-describedby="apl-text-input-field-v1_0-1-error-text apl-text-input-field-v1_0-1-help-text"
    type="text"
    name="person[firstName]">
  <div
    role="alert"
    class="apl-field__error-text"
    id="apl-text-input-field-v1_0-1-error-text">wrong input
  </div>
  <div
    class="apl-field__help-text"
    id="apl-text-input-field-v1_0-1-help-text">
      this is help text
  </div>
</div>


aria-describedby="person_firstName-error-text person_firstName-help-text"
```

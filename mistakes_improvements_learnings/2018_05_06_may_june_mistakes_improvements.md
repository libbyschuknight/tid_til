# May / June Mistakes, Improvements

## Passing args into rake task when using zsh

[How To Use Arguments In a Rake Task](https://robots.thoughtbot.com/how-to-use-arguments-in-a-rake-task)
where it has `rake tweets:send\[cpytel\]`

So tried:
`rake brands:create\[test_brand\]` worked

See - ![rake tasks and zsh](../terminal/terminal_stuff.md#rake-tasks)

## ruby - .insert

Had to do some stuff with tab links that are in an array. Changed the order of when they were created, which meant one that was second to last ended up being last.
To get this back into the right position I used `.insert`

```ruby
letters = Array.new(['a', 'b', 'c'])
=> ["a", "b", "c"]

letters.insert(letters.length - 1, 'Z')
=> ["a", "b", "Z", "c"]
```

https://gistpages.com/posts/ruby_arrays_insert_append_length_index_remove

https://ruby-doc.org/core-2.5.0/Array.html#method-i-insert


## exclude from git (not git ignore)

Found this useful again for a place to add notes when doing reading

Add to `.git/info/exclude`

e.g. if you want to have a local folder but not have it in git or in the `gitignore` file

`local/*`

[Exclude files from git without committing changes to .gitignore 🙅](https://hackernoon.com/exclude-files-from-git-without-committing-changes-to-gitignore-986fa712e78d)


## Carful about adding nils

```ruby
def UsageTabs
  tabs = default_customer_usage_tabs

  tabs << cheapest_tariffs_tab(tabs, consumer)

  tabs
end

def cheapest_tariffs_tab(tabs, consumer)
  if vanilla_only_brand?(consumer.brand) && consumer.active?
    ["Could you pay less?", { :controller => "/cheapest_tariffs", :action => "best_rates" }]
  end
end
```

>Be careful here, you'll end up shovelling nil into tabs (which is actually ok to do, since I know it eventually gets .compact called on it, but it's cleaner not to assume that).
colleague at Flux


## erb link_to and buttons!!

Was updating some views and changing a link to look like a button. Did this first:

```html
<button class="button">
  <i class="material-icons is-small">add</i>
    <%= link_to "New #{Thing}", thing_path(:id => id) %>
</button>
```

Which shows on the page as:

```html
<button class="button">
  <i class="material-icons is-small">add</i>
    <a href="/things/new?id=2">New Thing</a>
</button>
```
In this case the `add` icon (which is a plus sign) is none clickable.

I had forgotten that you can do a `do` with `link_to`, changed to this:

```html
<%= link_to new_thing(:id => @id), class: "button" do %>
  <i class="material-icons is-small">add</i> <%= "New Thing" %>
<% end %>
```

Looks like:

```html
<a class="button" href="/admin/premium_providers/new?id=2">
  <i class="material-icons is-small">add</i> New Premium provider
</a>
```
So the `add` icon is within the link.

Feedback from colleague when asking about something:

>Just as an FYI, having the <a> inside the button would be very frustrating for the user.
>Generally speaking, only the text in the button would be a link.

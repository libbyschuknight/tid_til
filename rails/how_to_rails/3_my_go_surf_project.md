## Part 3 - Adding the view with HTML & ERB

### Step 1 - Add heading

```html
<h1>New Surf Spot</h1>
```
Go to [http://localhost:3000/surf_spots/new](http://localhost:3000/surf_spots/new) and you will see the heading.

### Step 2 - add a form
We now want to add html so we can add a surf spot.

```html
<h1>New Surf Spot</h1>

<%= form_for :surf_spot do |f| %>
  <p>
    <%= f.label :name %><br>
    <%= f.text_field :name %>
  </p>

  <p>
    <%= f.label :description %><br>
    <%= f.text_area :description %>
  </p>

  <p>
    <%= f.label :place %><br>
    <%= f.text_field :place %>
  </p>

  <p>
    <%= f.label :region %><br>
    <%= f.text_field :region %>
  </p>

  <p>
    <%= f.label :country %><br>
    <%= f.text_field :country %>
  </p>

  <p>
    <%= f.label :latitude %><br>
    <%= f.number_field :latitude %>
  </p>

  <p>
    <%= f.label :longtitude %><br>
    <%= f.number_field :longtitude %>
  </p>

  <p>
    <%= f.label :stoke_rating %><br>
    <%= f.number_field :stoke_rating %>
  </p>

  <p>
    <%= f.submit %>
  </p>
<% end %>
```

You should see this now:
![new_form](images/new_surf_spot.png)

Add a surf spot:
```
Lyall Bay
Surf is great when it is on. The Airport End is where I surf the most and has a break of the wall. Other parts of the beach can be good at times.
Southerly swell, northerly wind.
Wellington
Wellington
New Zealand
-41.328778
174.803901
5
``

With the initial migration, we made latitude and longtitude floats, but we need to add decimals, so we will need to create a new migration to change the model.

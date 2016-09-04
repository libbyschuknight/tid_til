## Part 4 - Adding an index page to view all surf spots

### Step 1 - Add action for index

If you visit either the root url [http://localhost:3000/](http://localhost:3000/) or the index url [http://localhost:3000/surf_spots](http://localhost:3000/surf_spots), you will get an `Unknown action` error for the `index` action.

Add index action to the controller:

```ruby
def index
  @surf_spots = SurfSpot.all
end
```
You should now be getting the missing template error for the index.

### Step 2 - Add view for the index

Create a new file in the `app/views/surf_spots` folder, `index.html.erb`.
Add this html & erb to it:
```html
<h1>Surf Spots</h1>

<% @surf_spots.each do | surf_spot | %>
  <h2> <%= surf_spot.name %> </h2>
  <%= surf_spot.place %>
  <%= surf_spot.region
   %>
  <%= surf_spot.stoke_rating %>
  <%= link_to "Show", surf_spot_path(surf_spot) %>
<% end %>
```
Now visit the root url or the index url and you should see all the surf spots you have made. And be able to click through to view them.


This is what you should be able to do now:

http://localhost:3000/                  View all surf spots

http://localhost:3000/surf_spots        View all surf spots

http://localhost:3000/surf_spots/new    Create a new surf spot

http://localhost:3000/surf_spots/3      View a surf spot


However, you don't want to have to change the url every time you want to do one of the above.

### Step 3 - Add links to navigate actions/views

On the index page - `app/views/surf_spots/index.html.erb` add
```
<%= link_to "New Surf Spot", new_surf_spot_path %>
```

Show page - `app/views/surf_spots/show.html.erb`
New page - `app/views/surf_spots/new.html.erb`

```
<%= link_to "Back", surf_spots_path %>
```



### Step 4 - add editing of surf spot

If you want to update something in a surf spot you have already added.

Add the `edit` action to the controller:
```ruby
def edit
  @surf_spot = SurfSpot.find(params[:id])
end
```

Add a view file, create a new file in the `app/views/surf_spots` folder, `edit.html.erb`.

Add this:

```html
<h1>Update a New Surf Spot</h1>

<%= form_for :surf_spot, url: surf_spot_path(@surf_spot), method: :patch do |f| %>
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
    <%= f.number_field :latitude, step: :any %>
  </p>

  <p>
    <%= f.label :longitude %><br>
    <%= f.number_field :longitude, step: :any %>
  </p>

  <p>
    <%= f.label :stoke_rating %><br>
    <%= f.number_field :stoke_rating %>
  </p>

  <p>
    <%= f.submit %>
  </p>
<% end %>

<%= link_to "Back", surf_spots_path %>
```

Update the controller with the `update`action:

```ruby
def update
  @surf_spot = SurfSpot.find(params[:id])

  if @surf_spot.update(surf_spot_params)
    redirect_to @surf_spot
  else
    render 'edit'
  end
end
```

We also need a link to the `edit` action, on the index page:

`<%= link_to "Update", edit_surf_spot_path(surf_spot) %>`

and the show page:

`<%= link_to "Update", edit_surf_spot_path(@surf_spot) %>`


### [Next](5_my_go_surf_project.md)

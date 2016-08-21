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
Now visit the root url or the index url and you should see all the surf spots you have made. 

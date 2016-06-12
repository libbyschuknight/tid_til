# Rails

To run rails server not on default port

```bash
be rails s -p 4000
```

### Assest Pipeline - scss
Been working on my Seido Karate Guide and added some styling to the `stances.scss` file. When loading page this wasn't coming through. Looking at a previous  project, I was missing:

```
*= require_tree .
*= require_self
```

from the `application.scss` file. Added this back in and it worked fine.


### Simple mistake?
Don't copy and paste!!
Why won't this migration run?

```ruby
class AddTypeToBananas < ActiveRecord::Migration
  def change
    def change
      add_column :bananas, :type, :string, null: true
    end
  end
end
```

Because it has two `def change` methods!! Doh!

### `to_sql`
Can be used on ActiveRecord stuff to see SQL statement:

```ruby
Customer.all.to_sql
```

```sql
"SELECT \"customers\".* FROM \"customers\""
```

### Constants
On a model:
```ruby
class Phone

  LIST = [
    ["notified", "N"],
    ["verified", "V"]
  ]

end
```

Accessing constant in controller:
```ruby
Phone::LIST
```



### Changing Database / Migrations / Rollbacks
Really think about changing tables/columns etc before doing it!!

Be very careful when deleting migration files. Think carefully about rolling back and when to delete! Especially if you have data you want to keep.


### HAML
HAML converter to HTML - https://haml2erb.org/


### Adding Next and Previous buttons to show pages
Found this on StackOverFlow - http://stackoverflow.com/questions/1275963/rails-next-post-and-previous-post-links-in-my-show-view-how-to (second answer)

```ruby
class Stance < ActiveRecord::Base
  def next
    Stance.where(["id > ?", id]).first
  end
end
```
Not being too good with SQL yet, I ran the query in the Rails console to see what the raw SQL is.
`Stance.where(["id > ?", 7]).first.inspect`

```sql
SELECT  "stances".* FROM "stances" WHERE (id > 7)  ORDER BY "stances"."id" ASC LIMIT 1

"#<Stance id: 8, description: \"50/50, heels together, each foot at 45 degs\", created_at: \"2016-04-15 09:35:54\", updated_at: \"2016-04-15 09:35:54\", image_file_name: \"musubi.JPG\", image_content_type: \"image/jpeg\", image_file_size: 107624, image_updated_at: \"2016-04-15 09:35:54\", japanese_name: \"Musubi Dachi\", english_name: \"Open-toe stance\">"
```

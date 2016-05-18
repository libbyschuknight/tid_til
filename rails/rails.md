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



### Changing Database
Really think about changing tables/columns etc before doing it!!

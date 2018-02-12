# [Refinery](http://www.refinerycms.com/)

### [Guides](http://www.refinerycms.com/guides)
These are pretty good once I got my head around them being out of date:
>This guide is based on Refinery CMS 2.1.0 so some of the code shown here may not work in earlier versions of Refinery.

and the most up to date version of Rails being 5, but Refinery not working with 5 yet, and having to create a Rails up with an older version of Rails.

Which I realised further down the Getting Started page can be done like this:

```
rails _3.2.15_ new rickrockstar -m http://refinerycms.com/t/2.1.0
```

I did
```
rails _4.2.7.1_ new rickrockstar -m http://refinerycms.com/t/3.0.4
```
as that is the most recent Rails version before 5, and the most up to date RefineryCMS version.

changing the default db and skipping test-unit
```
rails _4.2.7.1_ new learn-2-code-nz -m http://refinerycms.com/t/3.0.4 --database=postgresql --skip-test-unit
```



## Karate site
#### Generations

```ruby
rails generate refinery:engine singular_model_name attribute:type [attribute:type ...]

rails generate refinery:engine person first_name:string last_name:string photo:image dojo:string

rails generate refinery:engine grade title:string dan:boolean kyu:boolean level:integer

# here added it into
rails g refinery:engine grade dan:boolean level:integer  --extension people --namespace people

rails generate migration AddGradeToRefineryPeople grade_id:integer
```

```ruby
Refinery::Page.where(slug:  "grades")
Refinery::Page.where(:slug => "grades")
```


#### Associate two models in different engines https://stackoverflow.com/questions/12691733/refinerycms-with-mutliple-associated-model-in-rails/14599955#14599955

```ruby
# In the user.rb in the User engine add
has_many :posts, :class_name => Refinery::Posts::Post

# and in the post.rb add

belongs_to :user, :class_name => Refinery::Users::User
```
### has_many: through

#### Example off Railscasts

[47 Two Many-to-Many - Railscasts](http://railscasts.com/episodes/47-two-many-to-many)

```ruby

# models
# category - name
# product - name

# create join model

rails g model categorisation product_id:integer category_id:integer

# categorisation model
#   belongs_to :product
#   belongs_to :category

# product model
#   has_many :categorisation
#   has many :categories, :through => :categorisation

# category model
#   has_many :categorisation
#   has_many :products, :through => :categorisation
```

#### What done for refinerycms karate site
```ruby

# model
# Refinery::Katas::Kata
# Refinery::Stances::Stance

# create join model

rails g model Katas_Stances kata_id:integer stance_id:integer

# migration
class CreateKatasStances < ActiveRecord::Migration
  def change
    create_table :katas_stances do |t|
      t.integer :kata_id # singular
      t.integer :stance_id # singular

      t.timestamps null: false
    end
  end
end

# KatasStances model
#   belongs_to :kata, class_name: Refinery::Katas::Kata  # singular
#   belongs_to :stance, class_name: Refinery::Stances::Stance # singular

# Refinery::Katas:::Kata model
#   has_many :katas_stances
#   has_many :stances, :through => :katas_stances, :class_name => Refinery::Stances::Stance


# Refinery::Stances::Stance model
#   has_many :katas_stances
#   has_many :katas, :through => :katas_stances, :class_name => Refinery::Katas::Kata
```

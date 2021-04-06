# Factory Bot

<https://github.com/thoughtbot/factory_bot>

<https://github.com/thoughtbot/factory_bot/blob/master/GETTING_STARTED.md>

[factory_bot - thoughtbot](https://thoughtbot.com/upcase/videos/factory-bot)

## Creating data quickly

In rails console:

```ruby
# create 100 posts belonging to the same group
FactoryBot.create_list(:post, 100, group_id: 4, content:"this is all the same")

# find a post
post = Post.find(446)

# create 20 comments for that post
FactoryBot.create_list(:comment, 20, commentable: post)
```

Used this in case to see how adding a `includes` on a query improved the performance of the search.

## Nesting

Nested factories work well:

```ruby
factory :role, class: Models::Role do
  created_at { Time.now.utc }
  factory :role do
    role "shop_keeper"
    factory :aaa do
      ex_party_id "AAA"
    end
    factory :bbb do
      ex_party_id "BBB"
    end
    factory :ccc do
      ex_party_id "CCC"
    end
    factory :ddd do
      ex_party_id "DDD"
    end
  end
end
```

You can just use `create` without having to use `FactoryGirl.create` and you can easily pass in other arguments for the model:

```ruby
entity = create(:entity)
create(:entt, party_id: entity.id)
```

Useful to think about what else could be hard coded into the factory. A test was failing as every time it was run it was creating new models and therefore new UUIDs.

```ruby
factory :party, class: Models::Party do
  created_at { Time.now.utc }
  factory :aaa do
    id "58bda40c-14cc-44c7-94a3-0da4a2a5f5fc"
    name "AAA"
  end
end
```

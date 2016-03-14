# Factory Girl

Nested factories work well:

```ruby
factory :role, class: Models::Role do
  created_at { Time.now.utc }
  factory :role do
    role "retailer"
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

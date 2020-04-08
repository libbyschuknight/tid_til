# [Enumerable](http://ruby-doc.org/core-2.3.0/Enumerable.html)

## zip

```ruby
array1

[
    [0] "T",
    [1] "A",
    [2] "G"
]

array2

[
    [0] "G",
    [1] "A",
    [2] "T"
]

array1.zip(array2)  # makes a nested array,  2 by 2

[
    [0] [
        [0] "T",
        [1] "G"
    ],
    [1] [
        [0] "A",
        [1] "A"
    ],
    [2] [
        [0] "G",
        [1] "T"
    ]
]
```

## collect

```ruby
Applicatio
n.all.collect(&:started_at)
```

get an array of `started_at` values

[to_proc](http://apidock.com/rails/Symbol/to_proc)

[what is the functionality of “&: ” operator in ruby?](http://stackoverflow.com/questions/9429819/what-is-the-functionality-of-operator-in-ruby?answertab=active#tab-top)

[What does map(&:name) mean in Ruby?](http://stackoverflow.com/questions/1217088/what-does-mapname-mean-in-ruby)

## map

[Ruby : Choosing between each, map, inject, each_with_index and each_with_object](https://stackoverflow.com/questions/40469476/ruby-choosing-between-each-map-inject-each-with-index-and-each-with-object/40469887#40469887)

>A more tl;dr answer:
>
>How to choose between `each`, `map`, `inject`, `each_with_index` and `each_with_object`?
>
>Use #each when you want "generic" iteration and don't care about the result. Example - you have numbers, you want to print the absolute value of each individual number:
>
>`numbers.each { |number| puts number.abs }`
>
>Use #map when you want a new list, where each element is somehow formed by transforming the original elements. Example - you have numbers, you want to get their squares:
>
>`numbers.map { |number| number ** 2 }`
>
>Use #inject when you want to somehow reduce the entire list to one single value. Example - you have numbers, you want to get their sum:
>
>`numbers.inject(&:+)`
>
>Use #each_with_index in the same situation as #each, except you also want the index with each element:
>
>`numbers.each_with_index { |number, index| puts "Number #{number} is on #{index} position" }`
>
>Uses for #each_with_object are more limited. The most common case is if you need something similar to #inject, but want a new collection (as opposed to singular value), which is not a direct mapping of the original. Example - >number histogram (frequencies):
>
>`numbers.each_with_object({}) { |number, histogram| histogram[number] = histogram[number].to_i.next }`

More detailed answer

<https://stackoverflow.com/questions/40469476/ruby-choosing-between-each-map-inject-each-with-index-and-each-with-object/40469477#40469477>


Own example that lead to looking at this in more detail.

```ruby
# was this but can use .map
def recipients_memberships_or_children_groups
  recipient_groups = []
  @recipients.each do |recipient|
    recipient_groups << memberships_or_children_groups(recipient)
  end
  recipient_groups.flatten
end


# use of .map
def recipients_memberships_or_children_groups
  recipient_groups = @recipients.map do |recipient|
    memberships_or_children_groups(recipient)
  end
  recipient_groups.flatten
end

# this method for understanding
def memberships_or_children_groups(user)
  return user.groups.pluck(:id) if user.groups.any?
  user_groups = user.relations.map do |relation|
    relation.child.groups.pluck(:id)
  end
  user_groups.flatten
end
```

## Get min and max number from an array

```ruby
list = [1, 2, 3, 4, 5]

list.min # 1
list.max # 5

list.minmax # [1, 5]
```

## transform_values / transform_keys

ActiveSupport

Following a post about this:

```ruby
hash = { :a => 1, :b => 2, :c => 3 }
hash.merge(hash) {|k,v| v*2 } # => {:a=>2, :b=>4, :c=>6}
```

Another post was this:
ActiveSupport also has `transform_values` and `transform_keys`

```ruby
{ a: 1, b: 2, c: 3 }.transform_values { |x| x * 2 } # => { a: 2, b: 4, c: 6 }
```

https://apidock.com/rails/v4.2.7/Hash/transform_values

https://apidock.com/rails/v4.2.7/Hash/transform_keys

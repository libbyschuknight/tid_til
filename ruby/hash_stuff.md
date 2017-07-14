ok have kind of got close with what I want..., have some hashes and want to make 3rd hash out of them

```ruby
ANIMALS = {
  cat: "urn:animal:cat",
  dog: "urn:animal:dog",
  rabbit: "urn:animal:rabbit",
  sloth: "urn:animal:sloth"
}

ANIMAL_LABELS = {
  cat: "Cool cat",
  dog: "Dirty dog",
  rabbit: "Rabid rabbit",
  sloth: "Sleepy sloth "
}
```

want to iterate over and get:

```ruby
{
  "urn:animal:cat" =>"Cool cat",
  "urn:animal:dog" => "Dirty dog",
  "urn:animal:rabbit" => "Rabid rabbit",
  "urn:animal:sloth" => "Sleepy sloth"
}
```


Got this so far

```ruby
LABELS_FOR_ANIMALS =
  ANIMALS.map do |key, value|
    Hash[value, ANIMAL_LABELS[key] ]
  end

LABELS_FOR_ANIMALS = ANIMALS.map { |key, value| Hash[value, ANIMAL_LABELS[key] ] }.inject(:merge)
```

  which gives me

```ruby
  [
    { "urn:animal:cat" => "Cool cat" },
    { "urn:animal:dog" => "Dirty dog"},
    { "urn:animal:rabbit" => "Rabid rabbit" },
    { "urn:animal:sloth" => "Sleepy sloth " }
  ]

  array.inject(:merge)
  {
         "urn:animal:cat" => "Cool cat",
         "urn:animal:dog" => "Dirty dog",
      "urn:animal:rabbit" => "Rabid rabbit",
       "urn:animal:sloth" => "Sleepy sloth "
  }
```

Suggestions of Ruby NZ Slack channel:

``` ruby
ANIMALS.keys.reduce({}) { |memo, key| memo[ANIMALS[key]] = ANIMAL_LABELS[key]; memo }

> `memo` is the hash that is supplied as the first argument to `reduce`. It’s also often called the `accumulator` since it’s meant to accumulate the value.
>`inject` is an alias for `reduce` and I find it a very confusing method

ANIMALS.each_with_object({}) { |(key, urn), hash| hash[urn] = ANIMAL_LABELS[key] }


ANIMALS.map { |key, urn| [urn, ANIMAL_LABELS[key]] }.to_h


ANIMALS.map { |key, value| [ value, ANIMAL_LABELS[key]] }.to_h

```


## Values - array
So, was waiting to get a validation working in Rails, did have:

```ruby
SOURCES = {
  cat: "kiity-cat",
  dog: "puppy-wuppy"
}.freeze

{
    :cat => "kiity-cat",
    :dog => "puppy-wuppy"
}
```

Using inclusion for the validation it needed an array so can do:

```ruby
SOURCES.values

[
    [0] "kiity-cat",
    [1] "puppy-wuppy"
]
```


-------
## Random hash stuff

```ruby
hash = { :a => 1, :b => 2, :c => 3 }
hash.merge(hash) { |k,v| v*2 } => { :a=>2, :b=>4, :c=>6 }
```

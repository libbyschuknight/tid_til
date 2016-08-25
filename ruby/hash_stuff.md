ok have kind of got close with what I want..., have some hashes and want to make 3rd hash out of them
```
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

want to iterate over and get:

{
  "urn:animal:cat" =>"Cool cat",
  "urn:animal:dog" => "Dirty dog",
  "urn:animal:rabbit" => "Rabid rabbit",
  "urn:animal:sloth" => "Sleepy sloth"
}


Got this so far

LABELS_FOR_ANIMALS =
  ANIMALS.map do |key, value|
    Hash[value, ANIMAL_LABELS[key] ]
  end

LABELS_FOR_ANIMALS = ANIMALS.map { |key, value| Hash[value, ANIMAL_LABELS[key] ] }.inject(:merge)

  which gives me

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

Suggestions of Ruby NZ Slack channel:

ANIMALS.keys.reduce({}) { |memo, key| memo[ANIMALS[key]] = ANIMAL_LABELS[key]; memo }

> `memo` is the hash that is supplied as the first argument to `reduce`. It’s also often called the `accumulator` since it’s meant to accumulate the value.
>`inject` is an alias for `reduce` and I find it a very confusing method

ANIMALS.each_with_object({}) { |(key, urn), hash| hash[urn] = ANIMAL_LABELS[key] }


ANIMALS.map { |key, urn| [urn, ANIMAL_LABELS[key]] }.to_h


ANIMALS.map { |key, value| [ value, ANIMAL_LABELS[key]] }.to_h

```

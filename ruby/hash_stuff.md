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

```

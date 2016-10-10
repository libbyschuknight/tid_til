# [Enumerable](http://ruby-doc.org/core-2.3.0/Enumerable.html)

### zip

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
Application.all.collect(&:started_at)
```
get an array of `started_at` values

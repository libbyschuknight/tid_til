#!/usr/bin/env ruby

# letters = ("a".."z").to_a
# # => ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]

# puts "array of letters - ('a'..'z').to_a"
# p letters


# puts "\n" # newline -> line break or could also just use puts
# puts

# puts "array of numbers - (1..10).to_a"
# numbers = (1..10).to_a
# # => [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]


# def what_is_self
#   self
# end

# puts what_is_self

number = 0
5.times() do
  number = number + 1
  puts number
end

puts number


def array_doubler(array)
  new_array = []
  array.each do |array_element|
    new_array.push(array_element * 2)
  end
  new_array
end

p array_doubler([1,2,3])


x = 0
array = []
while (x < 5 )
  x = x + 1
  array.push(x)
end

p array


x = 0
array = []
until (x >= 10 )
  x = x + 1
  array.push(x)
end

p array

counter = 0
loop do
  counter += 1
  if counter > 10
    break
  end
  puts "hi"
end

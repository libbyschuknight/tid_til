#!/usr/bin/env ruby

# https://www.learnhowtoprogram.com/ruby-and-rails/basic-ruby/basic-ruby-scripting

# puts 'What is your name?'
# name = gets.chomp
# puts "Hello #{name}!"

# name = ARGV[0]
# puts "Hello #{name}!"


first_name = ARGV[0]
last_name = ARGV[1]
age = ARGV[2]
puts "This is ARGV, the arguments array: #{ARGV}."
puts "Hello #{first_name} #{last_name}. You are #{age} years old!"

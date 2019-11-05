#!/usr/bin/env ruby

# reminding myself of stuff

class Hangman
  attr_reader :word, :correct_letters
  attr_accessor :lives

  def initialize(word)
    @word = word.chars
    @lives = 8
    @correct_letters = []
  end
end

new_game = Hangman.new("powershop")

p new_game
p new_game.word


class Country
  attr_reader :name, :region, :population

  def initialize(name, region, population)
    @name = name
    @region = region
    @population = population
  end
end

new_country = Country.new("New Zealand", "Pacific", 10000)

p new_country
p new_country.population

# irb -r "playing_file.rb" # to load ruby script into irb

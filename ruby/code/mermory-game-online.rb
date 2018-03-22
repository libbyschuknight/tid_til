def memory_game
  letters = "aabbccddeeffgghhiijj".chars.shuffle
  turn = 1

  40.times do    # still probably a better way to do this loop
    last_letter = ""   # hmm should this be set outside the loop, this and questioning where turn var should be set I would normally test quickly by running the code....something for me to work on! hmmm

    puts "This is turn #{turn}."

    boxes_left(letters)
    puts "There are these boxes left: #{boxes_left.join(", ")}."

    puts "Select a box: "  # using gets will provide ability for user to input a number
    user_number = input.gets  # can't remember exactly what the syntax is, but this will capture the users input

    current_letter = get_current_letter(letters, user_number)

    puts "This is the letter in the box you selected: #{current_letter}."
    # puts "Type in "clear_screen" to continue."

    letters = remove_letters(letters, current_letter, last_letter) if current_letter == last_letter

    check_won_loss(turn, letters)

    last_letter = current_letter  # so setting at beginning of loop to empty string and then re-assigning here
    turn += 1
  end
end

def boxes_left(letters)
  boxes = []
  letters.each_with_index { |letter, index| boxes << index + 1 unless letter.nil? }
  boxes
end


# I feel like there is or should be a ruby method that takes an index of an array and returns the element
# Hmm, think maybe you could do this with .pop or .shift by adding in the index, except I don't want to remove an element
# perhaps there is a method that just returns the element and does not remove it (it is probably really simple :) )
# this, again is where I would look up the docs :) as cannot remember :(

def get_current_letter(letters, user_number)
  current_letter = ""
  letters.each_with_index { |letter, index| current_letter = letter if (user_number - 1) == index }  # this is right
  current_letter
end

def remove_letters(letters, current_letter, last_letter)
  letters.each do |letter|
    # return nil if (letter == current letter)
  end
end

def check_won_loss(turn, letters)
  if turn < 40 && letters.all?(nil) # check to see if all elements in the array are nil
    puts "You have won!! Congratulations!!!!"
    # exit / finish game - can't remember!
  elsif turn == 40
   puts "Oh no! You lose! Bad luck! Try again!"
   # exit / finish game
  end
end


def clear_screen
  # can't remember how to clear the console screen, but this method would! :)
end


# when script/game is run, calling memory_game method will kick it all off

memory_game

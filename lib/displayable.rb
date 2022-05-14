# frozen_string_literal: true

# methods to print to the console
module Displayable
  def print_guess_prompt
    puts "Your turn to guess one letter in the secret word.\nYou can also type 'save' or 'exit' to leave the game."
  end

  def print_invalid_guess_error
    puts "Your guess should only be 1 letter that has not been guessed.\n\n"
  end

  def print_start_game_message(word_length)
    puts "\nYour random word has been chosen, it has #{word_length} letters:"
  end

  def print_already_guessed_message(letters)
    puts "You have already guessed: #{letters}"
  end

  def print_incorrect_guess_message(char)
    puts "Sorry, '#{char}' is not in the secret word."
  end

  def print_guesses_left_message(guesses_left)
    puts "You have #{guesses_left} incorrect guess(es) left."
  end

  def print_lost_game_message(word)
    puts "\nYou lost. The word that you were trying to solve was: #{word}."
  end

  def print_won_game_message(guesses_left)
    puts "\nCONGRATULATIONS! You figured out the secret word, with #{guesses_left} incorrect guess(es) remaining!"
  end
end

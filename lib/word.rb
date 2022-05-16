# frozen_string_literal: true

require_relative 'displayable'

# the secret word the player must guess
class Word
  include Displayable
  def initialize(value)
    @value = value
  end

  def to_s
    @value
  end

  def to_s_with_blanks(guesses)
    @value.split('').reduce('') { |word, char| word + (guesses.include?(Guess.new(char)) ? char.to_s : '_') }
  end

  def guessed?(guesses)
    @value == to_s_with_blanks(guesses)
  end

  def length
    @value.length
  end

  def lost_game
    print_lost_game_message(@value)
  end

  def wrong_guess?(guess)
    !@value.include?(guess)
  end
end

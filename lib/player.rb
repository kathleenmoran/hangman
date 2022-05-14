# frozen_string_literal: true

require 'set'
require_relative 'displayable'
require_relative 'guess'

# the user playing hangman
class Player
  include Displayable
  attr_reader :prev_guesses

  def initialize
    @prev_guesses = Set.new
  end

  def make_guess
    print_guess_prompt
    guess = Guess.new(gets.chomp)
    if guess.valid? && !@prev_guesses.include?(guess)
      @prev_guesses << guess
      guess
    else
      print_invalid_guess_error
      make_guess
    end
  end

  def made_wrong_guess?
    !@prev_guesses.empty?
  end

  def prev_guesses_to_s
    @prev_guesses.sort_by(&:value).to_a.join(' ')
  end
end

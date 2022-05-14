# frozen_string_literal: true

require_relative 'word'
require_relative 'player'
require_relative 'displayable'

# a game of hangman
class Game
  include Displayable
  MIN_WORD_LENGTH = 5
  MAX_WORD_LENGTH = 12
  FILE_NAME = '../words.txt'
  def initialize(incorrect_guesses = 8)
    @word = generate_random_word
    @player = Player.new
    @guesses_left = incorrect_guesses
    @is_won = false
  end

  def generate_random_word
    file = File.open(FILE_NAME)
    words = file.readlines.map(&:chomp).select { |word| word.length.between?(MIN_WORD_LENGTH, MAX_WORD_LENGTH) }
    file.close
    Word.new(words[rand(0...words.length)])
  end

  def start_game
    print_start_game_message(@word.length)
  end

  def play_round
    puts "\n#{@word.to_s_with_blanks(@player.prev_guesses)}\n\n"
    print_already_guessed_message(@player.prev_guesses_to_s) if @player.made_wrong_guess?
    guess = @player.make_guess
    if @word.correct_guess?(guess.value)
      # nothing
    else
      print_incorrect_guess_message(guess.value)
      @guesses_left -= 1
      print_guesses_left_message(@guesses_left) if @guesses_left.positive?
    end
  end

  def play
    start_game
    while @guesses_left.positive?
      play_round
      if @word.guessed?(@player.prev_guesses)
        @is_won = true
        break
      end
    end
    @is_won ? print_won_game_message(@guesses_left) : @word.lost_game
  end
end

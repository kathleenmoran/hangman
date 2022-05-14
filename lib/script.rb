# frozen_string_literal: true

require_relative 'game'

def prompt_to_play_again
  puts "\nWould you like to play again?\n\n[1] yes\n[2] no"
  gets.chomp
end

def ask_to_play_again
  user_input = prompt_to_play_again
  case user_input
  when '1'
    play_new_game
  when '2'
    exit
  else
    puts 'Invalid input.'
    ask_to_play_again
  end
end

def play_new_game
  Game.new.play
  ask_to_play_again
end

play_new_game

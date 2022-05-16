# frozen_string_literal: true

require_relative 'game'
require_relative 'serializable'
require 'yaml'
require_relative 'player'
require 'set'
require_relative 'word'
require_relative 'guess'

@saved_game_files = Dir['*.yaml']
@current_file_name = nil
def prompt_to_play_again
  puts "\nWould you like to play again?\n\n[1] yes\n[2] no"
  gets.chomp
end

def print_invalid_input_message
  puts 'Invalid input.'
end

def ask_to_play_again
  @current_file_name = nil
  user_input = prompt_to_play_again
  case user_input
  when '1'
    ask_new_or_saved
  when '2'
    exit
  else
    print_invalid_input_message
    ask_to_play_again
  end
end

def prompt_new_or_saved
  puts "Would you like to:\n\n[1] Play a new game\n[2] Load a saved game"
  gets.chomp
end

def ask_new_or_saved
  user_input = prompt_new_or_saved
  case user_input
  when '1'
    play_new_game
  when '2'
    play_saved_game
  else
    print_invalid_input_message
    ask_new_or_saved
  end
end

def play_new_game
  puts "Let's play hangman!\n"
  new_game = Game.new
  new_game.play
  save_game(new_game) if new_game.save_request_made
  ask_to_play_again
end

def play_saved_game
  print_file_names
  user_input = prompt_user_to_select_file
  p @saved_game_files.length
  p user_input.to_i.to_s == user_input
  if user_input.to_i.to_s == user_input && user_input.to_i.between?(1, @saved_game_files.length)
    file_name = @saved_game_files[user_input.to_i - 1]
    @current_file_name = file_name
    puts "Loading game saved in saved in #{file_name}..."
    saved_game = YAML.safe_load(File.open(file_name), [Game, Word, Player, Set, Guess])
    saved_game.play
    save_game(saved_game) if saved_game.save_request_made
    ask_to_play_again
  else
    print_invalid_input_message
    play_saved_game
  end
end

def prompt_user_to_select_file
  puts 'Please select a file number.'
  gets.chomp
end

def print_file_names
  puts '[#] File Name(s)'
  @saved_game_files.each_with_index do |game, index|
    puts "[#{index + 1}] #{game}"
  end
end

def save_game(game)
  game.save_request_made = false
  if @current_file_name.nil?
    file_name = "saved_game_#{@saved_game_files.length}.yaml"
    game.save(file_name)
    @saved_game_files << file_name
    puts "Your game was saved in #{file_name}."
  else
    game.save(@current_file_name)
    puts "The game saved in #{@current_file_name} was updated."
    @current_file_name = nil
  end
end

ask_new_or_saved

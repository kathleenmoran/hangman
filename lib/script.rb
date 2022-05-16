# frozen_string_literal: true

require_relative 'game'
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
    exit_game
  else
    handle_invalid_ask_to_play_again_input
  end
end

def exit_game
  puts "\nThank you for playing!"
  exit
end

def handle_invalid_ask_to_play_again_input
  print_invalid_input_message
  ask_to_play_again
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
  save_game_and_ask_to_play_again(new_game)
end

def play_saved_game
  print_file_names
  user_input = prompt_user_to_select_file
  if user_input.to_i.to_s == user_input && user_input.to_i.between?(1, @saved_game_files.length)
    play_valid_saved_game(user_input.to_i)
  else
    print_invalid_input_message
    play_saved_game
  end
end

def save_game_and_ask_to_play_again(game)
  save_game(game) if game.save_request_made
  ask_to_play_again
end

def play_valid_saved_game(file_number)
  file_name = @saved_game_files[file_number - 1]
  @current_file_name = file_name
  saved_game = open_saved_file(file_name)
  saved_game.play
  save_game_and_ask_to_play_again(saved_game)
end

def open_saved_file(file_name)
  puts "Loading game saved in saved in #{file_name}..."
  YAML.safe_load(File.open(file_name), [Game, Word, Player, Set, Guess])
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
    save_new_game(game)
  else
    save_existing_game(game)
  end
  @saved_game_files = Dir['*.yaml']
end

def save_new_game(game)
  file_name = "saved_game_#{@saved_game_files.length}.yaml"
  game.save(file_name)
  puts "\nYour game was saved in #{file_name}."
end

def save_existing_game(game)
  game.save(@current_file_name)
  puts "\nThe game saved in #{@current_file_name} was updated."
  @current_file_name = nil
end

ask_new_or_saved

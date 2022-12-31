# frozen_string_literal: true

require_relative 'game'
require_relative 'random_word'
require 'yaml'

puts 'How to play Hangman in the console.'
puts 'A random word with 5-12 letters will be chosen. On each turn, you can guess one letter.'
puts 'To win, you must find all the letters in the word before using 8 incorrect guesses.'
puts "Let's play hangman in the console! Would you like to:"

puts '[1] Play a new game'
puts "[2] Load a saved game\n\n"

answer = gets.chomp.to_i
until answer.between?(1, 2)
  puts 'Error. Please enter a valid answer.'
  answer = gets.chomp.to_i
end
case answer
when 1
  system('clear')
  Game.new.play_game
when 2
  if Dir.glob('saved/games').length == 0
    puts 'No saved game files exist!' 
  else
    puts "\n\Enter the name of the game you would you like to load\n\n"
    Dir.foreach("saved_games") { |file| puts "#{file}" if file.length > 2 }
    file_name = gets.chomp
    game = YAML.load_file(
      "saved_games/#{file_name}", 
      permitted_classes: [Game]
    )
    system('clear')
    game.round_results
    game.play_game
  end
end

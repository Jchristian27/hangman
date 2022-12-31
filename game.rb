# frozen_string_literal: true

require 'yaml'
require 'open-uri'

# A class for playing the game
class Game
  def initialize(**opts)
    @word = opts[:word] || RandomWord.new.random_word
    @guess_array = opts[:guess_array] || []
    @wrong_letters = opts[:wrong_letters] || []
    @wrong_guesses = opts[:wrong_guesses] || 0
    puts "\nYour word has been chosen. It has #{@word.length} characters\n\n"
    @word.length.times { @guess_array.push('_') }
    puts "#{@guess_array.join(' ')}\n\n"
  end

  def save_game
    puts 'choose a name for your saved game file'
    filename = gets.chomp.downcase.split(' ').join('-')
    serialized_game = YAML.dump(self)
    File.write("saved_games/#{filename}.yaml", serialized_game)
  end

  def self.load_game(yaml_string)
    string = YAML.load(yaml_string)
    puts string
  end

  def round_output
    if @wrong_guesses == 7
      puts "WARNING! You have 1 incorrect guess left.\n\n"
    else
      puts "You have #{8 - @wrong_guesses} incorrect guess(es) left.\n\n"
    end
    puts 'Your turn to guess a letter in the secret word.'
    puts "You can also type 'save' to save and exit your game.\n\n"
  end

  def round_results
    puts "\n#{@guess_array.join(' ')}\n\n"
    puts "Incorrect letters guessed: #{@wrong_letters.join(' ')}\n\n"
  end

  def round_logic(letter)
    if @word.include?(letter)
      @word.split('').each_with_index do |e, i|
        @guess_array[i] = letter if e == letter
      end
    elsif !@word.include?(letter)
      @wrong_letters.push(letter)
      @wrong_guesses += 1
    end
    round_results
  end

  def valid_letter?(letter)
    letter.length == 1 && letter.match?(/[[:alpha:]]/) &&
      !@wrong_letters.include?(letter) && !@guess_array.include?(letter)
  end

  def player_turn
    round_output
    letter = gets.chomp.downcase
    if letter == 'save'
      save_game
    else
      until valid_letter?(letter)
        puts 'Uh oh. You entered an invalid letter. Please enter a letter you haven\'t picked yet'
        letter = gets.chomp
      end
    end
    round_logic(letter)
  end

  def game_over?
    true if @wrong_guesses == 8 || @guess_array == @word.split('')
  end

  def play_game
    player_turn until game_over?
    if @guess_array == @word.split('')
      print 'CONGRATULATIONS! You figured out the secret word, '
      print "with #{8 - @wrong_guesses} incorrect guess(es) remaining!\n\n"
    elsif @wrong_guesses == 8
      puts "You lost :(\n\n"
      puts "The word you were trying to guess was: #{@word}\n\n"
      puts "Better luck next time ¯\\_(ツ)_/¯\n\n"
    end
  end
end

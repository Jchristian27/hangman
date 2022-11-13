# frozen_string_literal: true

# A class for playing the game
class Game
  def initialize
    @word = RandomWord.new.random_word
    @length = @word.length
    @guess_array = []
    (@length - 1).times do
      @guess_array.push('_')
    end
    @word_array = @word.split('')
    @word_array.pop
    @guess = nil
    @round = 0
  end

  def display_guess
    puts @guess_array
  end

  def player_turn
    p @word_array
    puts 'Guess a letter'
    letter = gets.chomp
    until letter.length == 1
      puts 'Uh oh. You entered more than one letter. Please try again'
      letter = gets.chomp
    end
    @word_array.each_with_index do |e, i|
      @guess_array[i] = letter if e == letter
    end
    puts @guess_array.join(' ')
    @round += 1
  end

  def game_over?
    true if @round == 13 || @guess_array == @word_array
  end

  def play_game
    player_turn until game_over?
  end
end

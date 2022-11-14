# frozen_string_literal: true

# A class for playing the game
class Game
  def initialize
    @word = RandomWord.new.random_word
    @length = @word.length
    @guess_array = []
    @word_array = @word.split('')
    @word_array.pop
    @guess = nil
    @round = 0
    puts "\nYour word has been chosen. It has #{@length - 1} characters\n\n"
    (@length - 1).times do
      @guess_array.push('_')
    end
    puts "#{@guess_array.join(' ')}\n\n"
  end

  def display_guess
    print @guess_array
  end

  def warning
    case @round
    when 10
      puts 'Two guesses remaining.'
    when 11
      puts 'BE CAREFUL. You only have one guess left.' if @round == 11
    end
  end

  def player_turn
    #p @word_array
    warning
    puts 'Guess a letter'
    letter = gets.chomp
    until letter.length == 1
      puts 'Uh oh. You entered more than one letter. Please try again'
      letter = gets.chomp
    end
    @round += 1 unless @word_array.include?(letter)
    @word_array.each_with_index do |e, i|
      @guess_array[i] = letter if e == letter
    end
    puts @guess_array.join(' ')
  end

  def game_over?
    true if @round == 12 || @guess_array == @word_array
  end

  def play_game
    player_turn until game_over?
  end
end

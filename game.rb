# frozen_string_literal: true

# A class for playing the game
class Game
  def initialize
    @word = RandomWord.new.random_word
    @length = @word.length
    @word_array = @word.split('')
    @word_array.pop
    @guess_array = []
    @guess = nil
    @wrong_letters = []
    @wrong_guesses = 0
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
    case @wrong_guesses
    when 6
      puts 'Two guesses remaining.'
    when 7
      puts 'BE CAREFUL. You only have one guess left.'
    end
  end

  def this_round_logic(letter)
    if @word_array.include?(letter)
      @word_array.each_with_index do |e, i|
        @guess_array[i] = letter if e == letter
      end
    elsif !@word_array.include?(letter)
      @wrong_letters.push(letter)
      @wrong_guesses += 1
    end
    this_round_results
  end

  def this_round_results
    puts "\n#{@guess_array.join(' ')}\n\n"
    puts "Incorrect letters guessed: #{@wrong_letters.join(' ')}\n\n"
  end

  def player_turn
    warning
    puts 'Your turn to guess a letter in the secret word.'
    puts "You can also type 'save' or 'exit' to leave the game.\n\n"
    letter = gets.chomp
    until letter.length == 1 && letter.match?(/[[:alpha:]]/) &&
          !@wrong_letters.include?(letter) && !@guess_array.include?(letter)
      puts 'Uh oh. You either entered an invalid letter. Please enter a letter you haven\'t picked yet'
      letter = gets.chomp
    end
    this_round_logic(letter)
  end

  def game_over?
    true if @wrong_guesses == 8 || @guess_array == @word_array
  end

  def play_game
    player_turn until game_over?
  end
end

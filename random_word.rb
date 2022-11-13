# frozen_string_literal: true

# Generate a random word for the game
class RandomWord
  attr_reader :random_word

  def initialize
    @word_array = File.open('words.txt').to_a
    @word_array.filter! { |e| !e.nil? && (5..12).include?(e.strip.size) }
    @random_word = @word_array[rand(1..@word_array.size)]
  end
end

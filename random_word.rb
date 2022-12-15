# frozen_string_literal: true

# Generate a random word for the game
class RandomWord
  attr_reader :random_word

  def initialize
    @word_array = File.readlines('words.txt').map(&:strip)
    @word_array.filter! { |e| !e.nil? && (5..12).include?(e.size) }
    @random_word = @word_array[rand(1..@word_array.size)]
  end
end

# frozen_string_literal: true

# A class for playing the game
class Game
  def initialize
    puts RandomWord.new.random_word
  end
end

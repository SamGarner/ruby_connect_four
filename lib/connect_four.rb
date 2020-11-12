# frozen_string_literal: false

class GameBoard
  attr_accessor :board_array

  def initialize
    @board_array = Array.new (6) { Array.new (7) }
  end
end
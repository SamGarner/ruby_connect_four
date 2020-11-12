# frozen_string_literal: false

require 'require_all'
require_all 'lib/'

# test that an empty game board is created
# test that piece falls to lowest unfilled point in the column
# test same but next turn is other players' piece

describe GameBoard do
  describe '#initialize' do
    it 'a new gameboard will contain 6 elements' do
      board = GameBoard.new

      expect(board.board_array.size).to eq(6)
    end

    it 'each of the 6 elements will be an array of 7' do
      board = GameBoard.new

      expect(board.board_array).to all(eq([nil, nil, nil, nil, nil, nil, nil]))
    end
  end

  describe '#add_piece' do
    it 'adds piece to first row when player 1 goes first' do
      board = GameBoard.new
    end
  end
end

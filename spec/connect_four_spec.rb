# frozen_string_literal: false

require 'require_all'
require_all 'lib/'

# test that an empty game board is created
# test that piece falls to lowest unfilled point in the column
# test same but next turn is other players' piece

describe Game do
  describe '#initialize' do
    it 'player 1 initialized' do
      game = Game.new

      expect(game.player1).not_to be_nil
    end

    it 'player 2 initialized' do
      game = Game.new

      expect(game.player2).not_to be_nil
    end

    it 'player 1 and player 2 are separately identifiable' do
      game = Game.new

      expect(game.player1).not_to eq(game.player2)
    end

    it 'next_move is set to one of the two players' do
      game = Game.new

      expect(game.next_move).to (satisfy { |n| [1,2].include?(n) })
    end

    it 'one GameBoard is initialized' do 
      game = Game.new
      expect(game.game_board).to be_truthy
    end
  end
end

describe GameBoard do
  describe '#initialize' do
    it 'a new gameboard will contain 6 elements' do
      board = GameBoard.new

      expect(board.board_array.size).to eq(6)
    end

    it 'each of the 6 elements will be an array of 7' do
      board = GameBoard.new

      expect(board.board_array).to all(eq([nil, nil, nil, nil, nil, nil, nil]))  #########
    end
  end

  describe '#add_piece' do
    it 'adds piece to first row when player 1 goes first' do
      board = GameBoard.new
      board.add_piece(1, 3)

      expect(board.board_array[5][3]).to eq(1)
    end
  end
end

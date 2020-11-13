# frozen_string_literal: false

require 'require_all'
require_all 'lib/connect_four/'

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

  describe '#update_which_player_has_next_move' do
    it 'a player does not have next turn if that player just went' do
      game = Game.new
      current = game.next_move

      expect(game.update_which_player_has_next_move).not_to eq(current)
    end

    it 'player 1 has next turn if player 2 just went' do
      game = Game.new
      game.next_move = 2

      expect(game.update_which_player_has_next_move).to eq(1)
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

      expect(board.board_array).to all(eq(['-', '-', '-', '-', '-', '-', '-']))
    end
  end

  describe '#add_piece' do
    it 'adds piece to first row when player 1 goes first' do
      board = GameBoard.new
      board.add_piece(1, 3)

      expect(board.board_array[5][3]).to eq(1)
    end

    it 'adds piece to second row if first already taken' do
      board = GameBoard.new
      board.add_piece(1,3)
      board.add_piece(1,3)

      expect(board.board_array[4][3]).to eq(1)
    end

    it "returns column full 'error' if player tries to play a column with no spaces left" do
      board = GameBoard.new
      board.add_piece(1, 3)
      board.add_piece(1, 3)
      board.add_piece(1, 3)
      board.add_piece(1, 3)
      board.add_piece(1, 3)
      board.add_piece(1, 3)

      expect { board.add_piece(1, 3) }.to output("There is no empty space there - choose another column to place your piece.\n").to_stdout#_from_any_process
    end
  end

  describe '#check_for_win' do
    it 'player wins when has four consecutive horizontal places' do
      board = GameBoard.new
      board.add_piece('ß', 1)
      board.add_piece('ß', 2)
      board.add_piece('ß', 3)
      board.add_piece('ß', 4)

      expect(board.check_for_win).to be_truthy
    end

    it 'player wins when has four consecutive vertical places' do
      board = GameBoard.new
      board.add_piece('ß', 3)
      board.add_piece('ß', 3)
      board.add_piece('ß', 3)
      board.add_piece('ß', 3)

      expect(board.check_for_win).to be_truthy
    end

    it 'player wins when has four consecutive upward diagonal places' do
      board = GameBoard.new
      board.add_piece('₴', 3)
      board.add_piece('₴', 4)
      board.add_piece('₴', 4)
      board.add_piece('₴', 5)
      board.add_piece('₴', 5)
      board.add_piece('₴', 5)
      board.add_piece('ß', 2)
      board.add_piece('ß', 3)
      board.add_piece('ß', 4)
      board.add_piece('ß', 5)

      expect(board.check_for_win).to be_truthy
    end

    it 'player wins when has four consecutive downward diagonal places' do
      board = GameBoard.new
      board.add_piece('₴', 2)
      board.add_piece('₴', 2)
      board.add_piece('₴', 2)
      board.add_piece('₴', 3)
      board.add_piece('₴', 3)
      board.add_piece('₴', 4)
      board.add_piece('ß', 2)
      board.add_piece('ß', 3)
      board.add_piece('ß', 4)
      board.add_piece('ß', 5)

      expect(board.check_for_win).to be_truthy
    end
  end 

  describe '#check_for_draw' do #update to be based on flag or something that's not puts?
    it 'is a draw is all spaces have been filled' do
      board = GameBoard.new
      board.board_array = Array.new (6) { Array.new(7) { 1 } }

      expect(board.check_for_draw).to be_truthy
    end
  end
end

# frozen_string_literal: false

class Game
  attr_reader :player1, :player2
  attr_accessor :game_board, :next_move

  def initialize
    @player1 = '☭'
    @player2 = '₴'
    @next_move = [1, 2].sample
    @game_board = GameBoard.new
  end

  def update_which_player_has_next_move(next_play = next_move)
    next_play == 1 ? self.next_move = 2 : self.next_move = 1
  end
end

class GameBoard
  attr_accessor :board_array

  def initialize
    @board_array = Array.new (6) { Array.new (7) }
  end

  def add_piece(player, column)
    if board_array[5][column].nil?
      board_array[5][column] = player
    elsif board_array[4][column].nil?
      board_array[4][column] = player
    elsif board_array[3][column].nil?
      board_array[3][column] = player
    elsif board_array[2][column].nil?
      board_array[2][column] = player
    elsif board_array[1][column].nil?
      board_array[1][column] = player
    elsif board_array[1][column].nil?
      board_array[1][column] = player
    else 
      puts 'That column is already full - choose another column to place your piece.'
    end
  end

  def check_for_draw
    board_array.all? { |n| n.compact.length == 7 }
  end
end
# frozen_string_literal: false

require 'pry'

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
    @board_array = Array.new (6) { Array.new (7) { '-' } }
  end

  def add_piece(player, column)
    if board_array[5][column] == '-'
      board_array[5][column] = player
    elsif board_array[4][column] == '-'
      board_array[4][column] = player
    elsif board_array[3][column] == '-'
      board_array[3][column] = player
    elsif board_array[2][column] == '-'
      board_array[2][column] = player
    elsif board_array[1][column] == '-'
      board_array[1][column] = player
    elsif board_array[1][column] == '-'
      board_array[1][column] = player
    else 
      puts 'That column is already full - choose another column to place your piece.'
    end
  end

  def check_for_draw
    board_array.all? { |n| n.compact.length == 7 }
  end

  def check_for_win
    true if horizontal_win? || vertical_win? || diagonal_win?
  end

  def horizontal_win?
    board_array.each do |row|
      return true if row.join.match(/1{4}/) || row.join.match(/2{4}/)
    end

    false
  end

  def vertical_win?(array = board_array)
    transposed = array.transpose
    transposed.each do |row|
      return true if row.join.match(/1{4}/) || row.join.match(/2{4}/)
    end

    false
  end

  def diagonal_win?
    downward_diagonal_win? || upward_diagonal_win?
  end

  # shift gameboard so downward diagonals can be checked with vertical_win?
  def downward_diagonal_win?
    temp_board_array = []
    (0..5).each { |row| temp_board_array[row] = board_array[row].dup }
    temp_board_array[0].unshift('-', '-', '-', '-', '-')
    temp_board_array[1].unshift('-', '-', '-', '-').push('-')
    temp_board_array[2].unshift('-', '-', '-').push('-', '-')
    temp_board_array[3].unshift('-', '-').push('-', '-', '-')
    temp_board_array[4].unshift('-').push('-', '-', '-', '-')
    temp_board_array[5].push('-', '-', '-', '-', '-')

    (6..11).each do |empty_row|
      temp_board_array[empty_row] = Array.new (12) { '-' }
    end
    # 5.times { temp_board_array.push(['-', '-', '-', '-', '-' , '-', '-', '-', '-', '-', '-', '-']) }
    return true if vertical_win?(temp_board_array)

    false
  end

  # shift gameboard so upward diagonals can be checked with vertical_win?
  def upward_diagonal_win?
    temp_board_array = []
    (0..5).each { |row| temp_board_array[row] = board_array[row].dup }  ## dup -- the arrays in the array are not being dup'd
    temp_board_array[0].push('-', '-', '-', '-', '-')
    temp_board_array[1].push('-', '-', '-', '-').unshift('-')
    temp_board_array[2].push('-', '-', '-').unshift('-', '-')
    temp_board_array[3].push('-', '-').unshift('-', '-', '-')
    temp_board_array[4].push('-').unshift('-', '-', '-', '-')
    temp_board_array[5].unshift('-', '-', '-', '-', '-')

    (6..11).each do |empty_row|
      temp_board_array[empty_row] = Array.new (12) { '-' }
    end
    return true if vertical_win?(temp_board_array)

    false
  end
end
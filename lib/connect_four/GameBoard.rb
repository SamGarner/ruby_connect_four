# frozen_string_literal: false

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
    elsif board_array[0][column] == '-'
      board_array[0][column] = player
    else 
      puts 'There is no empty space there - choose another column to place your piece.'
      false
    end
  end

  def display_board # wait on final piece display to format/even out, # puts board array separates values
    print "#{board_array[0]} \n"
    print "#{board_array[1]} \n"
    print "#{board_array[2]} \n"
    print "#{board_array[3]} \n"
    print "#{board_array[4]} \n"
    print "#{board_array[5]} \n"
    print "  0    1    2    3    4    5    6 \n"
  end

  def check_for_draw
    # board_array.all? { |n| n.compact.length == 7 }
    !board_array[0].include?('-')
  end

  def check_for_win
    true if horizontal_win? || vertical_win? || diagonal_win?
  end

  def four_in_a_row?(array)
    array.each do |row|
      return true if row.join.match(/ß{4}/) || row.join.match(/₴{4}/)
    end

    false
  end

  def horizontal_win?
    four_in_a_row?(board_array)
  end

  def vertical_win?(array = board_array)
    transposed = array.transpose
    four_in_a_row?(transposed)
  end

  def diagonal_win?
    downward_diagonal_win? || upward_diagonal_win?
  end

  # shift gameboard so downward diagonals can be checked with vertical_win?
  def downward_diagonal_win?
    temp_board_array = []
    (0..5).each { |row| temp_board_array[row] = board_array[row].dup }
    shift_gameboard_for_downward_diagonal_check(temp_board_array)
    make_transposable_by_padding_board_with_empty_rows(temp_board_array)
    return true if vertical_win?(temp_board_array)

    false
  end

  def shift_gameboard_for_downward_diagonal_check(array)
    array[0].unshift('-', '-', '-', '-', '-')
    array[1].unshift('-', '-', '-', '-').push('-')
    array[2].unshift('-', '-', '-').push('-', '-')
    array[3].unshift('-', '-').push('-', '-', '-')
    array[4].unshift('-').push('-', '-', '-', '-')
    array[5].push('-', '-', '-', '-', '-')
  end

  def make_transposable_by_padding_board_with_empty_rows(array)
    (6..11).each do |empty_row|
      array[empty_row] = Array.new (12) { '-' }
    end
  end

  # shift gameboard so upward diagonals can be checked with vertical_win?
  def upward_diagonal_win?
    temp_board_array = []
    (0..5).each { |row| temp_board_array[row] = board_array[row].dup }  ## dup -- the arrays in the array are not being dup'd
    shift_gameboard_for_upward_diagonal_check(temp_board_array)
    make_transposable_by_padding_board_with_empty_rows(temp_board_array)
    return true if vertical_win?(temp_board_array)

    false
  end

  def shift_gameboard_for_upward_diagonal_check(array)
    array[0].push('-', '-', '-', '-', '-')
    array[1].push('-', '-', '-', '-').unshift('-')
    array[2].push('-', '-', '-').unshift('-', '-')
    array[3].push('-', '-').unshift('-', '-', '-')
    array[4].push('-').unshift('-', '-', '-', '-')
    array[5].unshift('-', '-', '-', '-', '-')
  end
end
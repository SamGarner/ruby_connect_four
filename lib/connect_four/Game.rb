# frozen_string_literal: false

class Game
  attr_reader :player1, :player2, :play_column
  attr_accessor :game_board, :next_move, :game_over

  def initialize
    @player1 = 'ß'
    @player2 = '₴'
    @next_move = [1, 2].sample
    @game_board = GameBoard.new
    @game_over = 0
  end

  def update_which_player_has_next_move(next_play = next_move)
    next_play == 1 ? self.next_move = 2 : self.next_move = 1
  end

  def get_user_next_play
    puts "Enter an integer 0 through 6 for which column you'd like to play:"
    @play_column = gets.chomp.to_i
  end

  def get_player_piece(turn = next_move)
    turn == 1 ? player1 : player2
  end

  def play
    game_start_message
    game_loop
    game_over_message
  end

  def game_start_message
    puts "Welcome to connect four! #{player1}'s go first." if next_move == 1
    puts "Welcome to connect four! #{player2}'s go first." if next_move == 2
  end

  def game_over_message
    puts "#{player1}'s win!" if game_over == 1 && next_move == 1
    puts "#{player2}'s win!" if game_over == 1 && next_move == 2
    puts "It's a draw!" if game_over == 2
  end

  def which_players_turn_message
    puts "\n#{player1}'s turn." if next_move == 1
    puts "\n#{player2}'s turn." if next_move == 2
  end

  def game_loop
    while game_over.zero?
      which_players_turn_message
      get_user_next_play
      next if game_board.add_piece(get_player_piece, play_column) == false

      game_board.display_board
      self.game_over = 1 if game_board.check_for_win
      self.game_over = 2 if game_board.check_for_draw
      break if game_over > 0

      # game_over = 1 if check_for_win || check_for_draw
      update_which_player_has_next_move
    end
  end
end

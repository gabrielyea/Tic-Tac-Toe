# frozen_string_literal: true

require_relative 'helper_funcs'

# Manages / stores positions and checks game states
class TicTacToe
  include HelperFunctions
  attr_accessor :board

  def initialize
    @board = [[1, 2, 3],
              [4, 5, 6],
              [7, 8, 9]]
  end

  # observer method, calls all methods registered in: player_class on_move event
  def call_event(method_name, *args)
    send method_name, args[0][0], args[0][1] if respond_to?(method_name, true)
  end

  # checks is selected place is availible to mark, gets called in player_class
  def valid_selection?(num)
    n = get_selection_position(num, Convert_to_coord)
    !n.nil?
  end

  # searches for a valid line with same slope, gets called in game manager check_game_state
  # line_found? = true means the game is over
  def line_found?(player_sign)
    pos = get_list_by_player(player_sign)
    !search_line(pos).empty?
  end

  def draw_board(*_args)
    board.each do |row|
      print row
      puts
    end
  end

  # gets called in game_manager check_game_state
  def out_of_moves?(player_sign)
    get_list_by_player(player_sign).size >= 5
  end

  private

  # returns the coords of selected number, callback: store all coords or just return one
  def get_selection_position(num, callback)
    Get_2d_array_pos.call(board, num, callback)
  end

  # searchs a line with same slope, dont have to check if values are next to each other
  # due to the size of tic tac toe board, for larger boards this will not work!
  def search_line(pos)
    pos.combination(3).select do |combi|
      Slope.call(combi[0..1]) == Slope.call(combi[1..2])
    end
  end

  # gets a list of all selected player's movements, used to calculate slope
  def get_list_by_player(player_sign)
    get_selection_position(player_sign, Store_on_list)
  end

  # called from on_move evenet in player_class, marks player choice on board
  def place_move(num, player_sign)
    n = get_selection_position(num, Convert_to_coord)
    board[n.x][n.y] = player_sign
  end
end

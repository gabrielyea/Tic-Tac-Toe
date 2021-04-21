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

  def call_event(method_name, *args)
    send method_name, args[0][0], args[0][1] if respond_to?(method_name, true)
  end

  # places player choice on board, invoked in call_event from player.invoke
  def place_move(num, player_sign)
    n = get_selection_position(num, Convert_to_coord)
    board[n.x][n.y] = player_sign
  end

  # checks is selected place is availible to mark
  def valid_selection?(num)
    n = get_selection_position(num, Convert_to_coord)
    !n.nil?
  end

  # gets a list of all movement of selected player, used to calculate slope
  def get_list_by_player(player_sign)
    get_selection_position(player_sign, Store_on_list)
  end

  def line_found?(player_sign)
    pos = get_list_by_player(player_sign)
    puts !search_line(pos).empty?
    !search_line(pos).empty?
  end

  def draw_board(*_args)
    board.each do |row|
      print row
      puts
    end
  end

  private

  def get_selection_position(num, callback)
    Get_2d_array_pos.call(board, num, callback)
  end

  def search_line(pos)
    pos.combination(3).select do |combi|
      Slope.call(combi[0..1]) == Slope.call(combi[1..2])
    end
  end
end

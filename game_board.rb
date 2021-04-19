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
    send method_name, args[0][0], args[0][1], args[0][2] if respond_to?(method_name, true)
  end

  # places player choice on board, invoked in call_event from player.invoke
  def place_move(num, player_sign, bod)
    n = Get_2d_array_pos.call(bod, num, Convert_to_coord)
    bod[n.x][n.y] = player_sign
  end

  # gets a list of all movement of selected player, used to calculate slope
  def get_list_by_player(get_pos, store_on_list)
    get_pos.call(board, 'x', store_on_list)
  end

  def check_victory_state(pos)
    # gets the slope of two Position structs
    slope = ->(pos1, pos2) { (pos2.y - pos1.y) / (pos2.x - pos1.x).to_f }
    return false if pos.size < 3

    0.upto(1).map { |num| slope.call(pos[num], pos[num + 1]) }.uniq.length == 1
  end

  private

  def draw_board(*bod)
    bod[2].each do |row|
      print row
      puts
    end
  end
end

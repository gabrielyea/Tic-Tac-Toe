# frozen_string_literal: true

# Manages / stores positions and checks game states
class TicTacToe
  attr_accessor :board

  def initialize
    @board = [[1, 2, 3],
              [4, 5, 6],
              [7, 8, 9]]
  end

  # places player choice on board
  def place_move(num, get_pos, convert_to_coord)
    n = get_pos.call(board, num, convert_to_coord)
    board[n.x][n.y] = 'x'
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

  def draw_board
    board.each do |row|
      print row
      puts
    end
  end
end

Position = Struct.new(:x, :y)

# proccess------
# finds a value on a 2d array, callback decides what to do when value found
get_2d_array_pos = lambda do |arr, value, call_back|
  result = nil
  arr.each_with_index do |row, i|
    row.each_with_index do |v, j|
      next unless v == value

      result = call_back.call(i, j, result)
    end
  end
  result
end

# callback for get_2d_array_pos, returns a struct position
convert_to_coord = ->(*args) { Position.new(args[0], args[1]) }

# callback for get_2d_array_pos, stores value to struct on a list.
store_on_list = ->(*args) { args[2].to_a << convert_to_coord.call(args[0], args[1]) }
# -------------

my_tic_tac = TicTacToe.new
my_tic_tac.place_move(6, get_2d_array_pos, convert_to_coord)
my_tic_tac.place_move(5, get_2d_array_pos, convert_to_coord)
my_tic_tac.place_move(4, get_2d_array_pos, convert_to_coord)

pos = my_tic_tac.get_list_by_player(get_2d_array_pos, store_on_list)
my_tic_tac.draw_board
puts my_tic_tac.check_victory_state(pos)

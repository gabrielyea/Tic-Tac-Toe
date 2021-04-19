# frozen_string_literal: true

# Manages / stores positions and checks game states
class TicTacToe
  attr_accessor :board

  def initialize
    @board = [[1, 2, 3],
              [4, 5, 6],
              [7, 8, 9]]
  end

  def place_move(num, get_pos, convert_to_coord)
    n = get_pos.call(board, num, convert_to_coord)
    board[n.x][n.y] = 'x'
  end

  def get_list_by_player(get_pos, convert_to_list)
    get_pos.call(board, 'x', convert_to_list)
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
get_2d_array_pos = lambda do |arr, value, call_back| # call_back = what to do when position found
  result = nil
  arr.each_with_index do |row, i|
    row.each_with_index do |v, j|
      next unless v == value

      result = call_back.call(i, j, result)
    end
  end
  result
end
convert_to_coord = ->(*args) { Position.new(args[0], args[1]) } # when position found convert to x y coord
convert_to_list = ->(*args) { args[2].to_a << [args[0], args[1]] } # when position found store on list
# -------------

my_tic_tac = TicTacToe.new
my_tic_tac.place_move(5, get_2d_array_pos, convert_to_coord)
my_tic_tac.place_move(8, get_2d_array_pos, convert_to_coord)
my_tic_tac.get_list_by_player(get_2d_array_pos, convert_to_list)
my_tic_tac.draw_board

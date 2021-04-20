# frozen_string_literal: true

# helper function for tic tac toe class
module HelperFunctions
  # simple struct for positionss
  Position = Struct.new(:x, :y)
  # proccess------
  # finds a value on a 2d array, callback decides what to do when value found
  Get_2d_array_pos = lambda do |arr, value, call_back|
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
  Convert_to_coord = ->(*args) { Position.new(args[0], args[1]) }

  # callback for get_2d_array_pos, stores value to struct on a list.
  Store_on_list = ->(*args) { args[2].to_a << Convert_to_coord.call(args[0], args[1]) }

  # gets the slope of two Position structs
  Slope = ->(pos1, pos2) { (pos2.y - pos1.y) / (pos2.x - pos1.x).to_f }
  # -------------
end

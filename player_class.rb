# frozen_string_literal: true

require 'observer'

# player class
class Player
  include Observable
  attr_reader :name, :sign
  attr_accessor :on_move # register methods that will respond to the event here

  def initialize(name, sign)
    @name = name
    @sign = sign
    @on_move = on_move
  end

  # calls all on_move methodss
  def make_move(num, board)
    on_move.each { |func| invoke(func, num, sign, board) }
  end

  private

  def invoke(callback, *args)
    changed
    notify_observers(callback, args)
  end
end

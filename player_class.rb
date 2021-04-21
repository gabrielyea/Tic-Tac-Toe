# frozen_string_literal: true

require 'observer'

# player class
class Player
  include Observable
  attr_reader :name, :sign
  attr_accessor :on_move # register methods that will respond to the event here, just by pushing them

  def initialize(name, sign)
    @name = name
    @sign = sign
    @on_move = on_move
  end

  # calls all on_move methodss
  def make_move(num)
    on_move.each { |func| invoke(func, num, sign) }
  end

  # checks if the selection is availible
  def can_move?(num, tic_tac_toe)
    tic_tac_toe.valid_selection?(num)
  end

  private

  # notify observers
  def invoke(callback, *args)
    changed
    notify_observers(callback, args)
  end
end

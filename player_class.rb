# frozen_string_literal: true

require 'observer'

# player class
class Player
  include Observable
  attr_reader :name, :sign

  def initialize(name, sign)
    @name = name
    @sign = sign
  end

  def on_update(callback)
    changed
    notify_observers(callback)
  end
end


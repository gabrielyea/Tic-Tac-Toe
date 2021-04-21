# frozen_string_literal: true

require_relative 'player_class'

# Manages player turns
class GameManager
  attr_reader :players, :player_index

  def initialize
    @player_index = 0
    @players = []
  end

  # observer method, calls all events registered in: player class on_move
  def call_event(method_name, *args)
    send method_name, args if respond_to?(method_name, true)
  end

  def current_player(*_args)
    @players[@player_index]
  end

  def player_by_index(index)
    @players[index]
  end

  def check_game_state(player_sign, tic_tac_toe, callback)
    callback.call("Player #{player_sign} won!!") if tic_tac_toe.line_found?(player_sign)

    callback.call('Out of space!') if tic_tac_toe.get_list_by_player(player_sign).size >= 5
  end

  private

  # only accesable by event call on_move
  def switch_player(*_args)
    @player_index += 1
    @player_index = @player_index % @players.size
  end
end

# frozen_string_literal: true

require_relative 'player_class'

# Manages player turns
class GameManager
  attr_reader :players, :player_index

  def initialize
    @player_index = 0
    @players = []
  end

  # observer method, calls all methods registered in: player class on_move event
  def call_event(method_name, *args)
    send method_name, args if respond_to?(method_name, true)
  end

  def current_player
    @players[@player_index]
  end

  def player_by_index(index)
    @players[index]
  end

  # checks the state of the game and sends a message on game over
  def check_game_state(player_sign, tic_tac_toe, callback)
    # victory / game over
    callback.call("Player #{player_sign} won!!") if tic_tac_toe.line_found?(player_sign)
    # tie / game over
    callback.call('Out of space!') if tic_tac_toe.out_of_moves?(player_sign)
  end

  private

  # called from on_move evenet in player_class after every turn
  def switch_player(*_args)
    @player_index += 1
    @player_index = @player_index % @players.size
  end
end

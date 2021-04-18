# frozen_string_literal: true

require_relative 'player_class'

# Manages player turns
class GameManager
  attr_reader :players

  def initialize
    @player_index = 0
    @players = []
  end

  def switch_player
    @player_index += 1
    @player_index = @player_index % @players.size
    puts @players[@player_index].name
  end

  def current_player
    @players[@player_index]
  end

  def player_by_index(index)
    @players[index]
  end
end

player1 = Player.new('p1', 'o')
player2 = Player.new('p2', '+')

game_manager = GameManager.new
game_manager.players << (player1)
game_manager.players << (player2)

player1.add_observer(game_manager, :switch_player)

player1.on_turn_over

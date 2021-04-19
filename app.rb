# frozen_string_literal: true

require_relative 'game_manager'
require_relative 'player_class'
require_relative 'game_board'

# players ------
player1 = Player.new('p1', 'x')
player2 = Player.new('p2', 'o')

# init manager
game_manager = GameManager.new
game_manager.players << player1
game_manager.players << player2

# register events

game_manager.players.each{|player| player.add_observer(game_manager, :call_event)}


player1.on_update(:test1)
player2.on_update(:test2)

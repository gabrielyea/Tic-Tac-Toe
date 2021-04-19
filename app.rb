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

# init board
tic_tac_toe = TicTacToe.new

# register observers
game_manager.players.each do |player|
  player.add_observer(game_manager, :call_event)
  player.add_observer(tic_tac_toe, :call_event)
end

# register method names -> event
player1.on_move = %i[switch_player place_move draw_board]

# player1.invoke(:switch_player)
# player1.invoke(:place_move, 1, player1.sign, tic_tac_toe.board)
# player1.invoke(:place_move, 5, player1.sign, tic_tac_toe.board)
# player1.invoke(:place_move, 3, player1.sign, tic_tac_toe.board)

# player1.invoke(:place_move, 2, player2.sign, tic_tac_toe.board)
# player1.invoke(:place_move, 4, player2.sign, tic_tac_toe.board)
# player1.invoke(:place_move, 7, player2.sign, tic_tac_toe.board)

player1.make_move(2, tic_tac_toe.board)
# player1.invoke(:draw_board, tic_tac_toe.board)

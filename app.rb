# frozen_string_literal: true

require_relative 'game_manager'
require_relative 'player_class'
require_relative 'game_board'

#------App init settings------------------------
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
  # register event <- method names. Those methods will be called on observable change
  player.on_move = %i[switch_player place_move draw_board]
end

game_over = false

tic_tac_toe.draw_board
user_input = 0

# callback for game over
set_game_state = lambda { |outcome|
  puts outcome
  game_over = true
}
# --------------------------------------------


# ---------main game loop-----------
loop do
  player = game_manager.current_player
  puts 'Select a valid number'
  user_input = gets.chomp.to_i

  next if user_input.zero? || user_input > 9

  # marks selection if it is availibe in the board
  player.make_move(user_input) if player.can_move?(user_input, tic_tac_toe)
  # searches for victory or game over conditions
  game_manager.check_game_state(player.sign, tic_tac_toe, set_game_state)

  break if game_over
end
# ----------------------------------

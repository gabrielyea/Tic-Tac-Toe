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
  # register event <- method names. Those methods will be called on observable change
  player.on_move = %i[switch_player place_move draw_board]
end

game_over = false

tic_tac_toe.draw_board
num = 0

finish = lambda { |outcome|
  puts outcome
  game_over = true
}

loop do
  player = game_manager.current_player
  puts 'Select a valid number '
  num = gets.chomp.to_i

  next if num.zero? || num > 9

  player.make_move(num) if player.can_move?(num, tic_tac_toe)
  game_manager.check_game_state(player.sign, tic_tac_toe, finish)

  break if game_over
end

require_relative 'board'
require_relative 'player'
require_relative 'game'

board = Board.new
player_one = Player.new(1, "X")
player_two = Player.new(2, "O")
game = Game.new

board.set_up
board.print_board
game.game_loop(player_one, player_two, board)

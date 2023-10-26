# frozen_string_literal: true

require_relative 'player'
require_relative 'board'

class Game
  attr_accessor :turn_counter

  def initialize
    @turn_counter = 0
  end

  def player_turn(player_input, symbol, board)
    player_input -= 1
    if player_input.between?(0, 8)
      array_position = player_input / 3
      row_position = player_input % 3
      if board.not_labeled?(array_position, row_position)
        board.update_board(array_position, row_position, symbol)
        @turn_counter += 1
      else
        puts 'Please enter the number of a field that has not been labeled yet.'
      end
    else
      puts 'Please enter a number between 1 and 9.'
    end
  end

  def game_loop(player_one, player_two, board)
    game_ended = false

    board.who_wins?
    if (board.x_winner == true) || (board.o_winner == true)
      game_ended = true
      game_end(board.x_winner, board.o_winner)
    end

    if (@turn_counter < 9) && (game_ended == false)
      if turn_counter.even?
        puts 'Player 1: Your turn. Please enter a number between 1 and 9'
        player_turn(player_one.get_player_input, player_one.symbol, board)
      else
        puts 'Player 2: Your turn. Please enter a number between 1 and 9'
        player_turn(player_two.get_player_input, player_two.symbol, board)
      end
      game_loop(player_one, player_two, board)
    end
    return unless (@turn_counter >= 9) && (game_ended == false)

    game_end(board.x_winner, board.o_winner)
  end

  private

  def game_end(x_winner, o_winner)
    if x_winner == true
      puts "The game ended after #{@turn_counter} turns! Player 1 wins!"
    elsif o_winner == true
      puts "The game ended after #{@turn_counter} turns! Player 2 wins!"
    else
      puts "The board is full and there is no winner! It's a tie!"
      exit
    end
  end
end

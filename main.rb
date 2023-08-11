class Board
  def initialize
    @COLUMN_SIZE = 3
    @ROW_SIZE = 3
    @@board_visual = Array.new(@COLUMN_SIZE) {Array.new(@ROW_SIZE)}
  end

  def update_board(index, symbol)
    @@board_visual[index] = symbol
    print_board
  end

  def set_up
    @@board_visual.map! { |a, b, c| a = "", b = "", c = ""}
  end

  def print_board
    p @@board_visual[0].join(" | ")
    p @@board_visual[1].join(" | ")
    p @@board_visual[2].join(" | ")
  end

  def not_labeled?(board_index, player_input)
    @@board_visual[board_index][player_input] != "X" && @@board_visual[board_index][player_input] != "O"
  end
end


class Player < Board
  attr_reader :symbol, :player_number

  def initialize (player_number, symbol)
    @player_number = player_number
    @symbol = symbol
  end

  def get_player_input
    @@player_input = gets.chomp.to_i
  end
end


class Game < Player
  attr_reader :player
  @turn_counter

  def initialize
    @turn_counter = 0
  end

  def game_loop
    player_input = @@player_input
    if player_input.between?(0, 8)
      if player_input.between?(0, 2) && not_labeled?(0, player_input)
        p @symbol
        update_board(player_input, @symbol)
        @@turn_counter += 1

      elsif player_input.between?(3, 5) && not_labeled?(1, player_input)
        update_board(player_input, @symbol)
        @@turn_counter += 1

      elsif player_input.between?(6, 8) && not_labeled?(2, player_input)
        update_board(player_input, @symbol)
        @@turn_counter += 1

      else
        puts "Please enter a valid number for a field that isn't labeled yet."
      end

    else
      puts "Please enter a number between 1 and 9"
    end
  end

  def which_player?
    if @turn_counter.even?
      puts "Player 1: Your turn. Please enter a number between 1 and 9!"
      player = 1
    else
      puts "Player 2: Your turn. Please enter a number between 1 and 9!"
      player = 2
    end
  end
end

#######################################################################################################################
board = Board.new
player_one = Player.new(1, "X")
player_two = Player.new(2, "O")
game = Game.new

board.set_up
board.print_board

game.which_player?

player_one.get_player_input
playero_one.game


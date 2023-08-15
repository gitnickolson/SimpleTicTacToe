class Board
  attr_accessor :board_visual, :o_winner, :x_winner

  COLUMN_SIZE = 3
  ROW_SIZE = 3

  def initialize
    @board_visual = Array.new(COLUMN_SIZE) {Array.new(ROW_SIZE)}
    @x_winner = false
    @o_winner = false
  end

  def update_board(array, index, symbol)
    board_visual[array][index] = symbol
    print_board
  end

  def set_up
    board_visual.map! { |a, b, c| a = "", b = "", c = ""}
  end

  def print_board
    p board_visual[0].join(" | ")
    p board_visual[1].join(" | ")
    p board_visual[2].join(" | ")
  end

  def not_labeled?(board_index, player_input)
    # 3 = 0, 4 = 1, 5 = 2, 6 = 0, 7 = 1, 8 = 2
    player_input = player_input % 3
    board_visual[board_index][player_input] != "X" && board_visual[board_index][player_input] != "O"
  end

  def who_wins?
    diagonal = 0
    mirrored_diagonal = 2
    diagonal_array = Array.new
    mirrored_diagonal_array = Array.new
    first_row_vertical_array = Array.new
    second_row_vertical_array = Array.new
    third_row_vertical_array = Array.new

    board_visual.each_with_index do |h_array, board_index|
      board_visual
      diagonal_array << h_array[diagonal]
      mirrored_diagonal_array << h_array[mirrored_diagonal]
      first_row_vertical_array << h_array[0]
      second_row_vertical_array << h_array[1]
      third_row_vertical_array << h_array[2]
      diagonal += 1
      mirrored_diagonal -= 1

      if h_array.flatten.all?("X")
        x_winner = true
      elsif h_array.flatten.all?("O")
        o_winner = true
      end
    end

    if diagonal_array.all?("X") or mirrored_diagonal_array.all?("X") or
      first_row_vertical_array.all?("X") or second_row_vertical_array.all?("X") or
      third_row_vertical_array.all?("X")
      @x_winner = true
    elsif diagonal_array.all?("O") or mirrored_diagonal_array.all?("O") or
      first_row_vertical_array.all?("O") or second_row_vertical_array.all?("O") or
      third_row_vertical_array.all?("O")
      @o_winner = true
    end
  end
end


class Player
  attr_reader :symbol, :player_number

  def initialize (player_number, symbol)
    @player_number = player_number
    @symbol = symbol
  end

  def get_player_input
    @player_input = gets.chomp.to_i
  end
end


class Game
  attr_accessor :turn_counter

  def initialize
    @turn_counter = 0
  end

  def player_turn(player_input, symbol, board)
    # Zeile = /, Spalte = %, 93 - 117
    player_input -= 1
    if player_input.between?(0, 8)
      new_player_input = player_input / 3
      if board.not_labeled?(new_player_input, player_input % 3)
        case new_player_input
        when 0
          board.update_board(new_player_input, player_input % 3, symbol)
          @turn_counter += 1

        when 1
          board.update_board(new_player_input, player_input % 3, symbol)
          @turn_counter += 1

        when 2
          board.update_board(new_player_input, player_input % 3, symbol)
          @turn_counter += 1
        end

      else
        puts "Please enter the number of a field that has not been labeled yet."
      end
    else
      puts "Please enter a number between 1 and 9."
    end
  end

  def game_loop(player_one, player_two, board)
    game_ended = false

    board.who_wins?
    if board.x_winner == true or board.o_winner == true
      game_ended = true
      game_end(board.x_winner, board.o_winner)
    end

    if @turn_counter < 9 and game_ended == false
      if turn_counter.even?
        puts "Player 1: Your turn. Please enter a number between 1 and 9"
        player_turn(player_one.get_player_input, player_one.symbol, board)
      else
        puts "Player 2: Your turn. Please enter a number between 1 and 9"
        player_turn(player_two.get_player_input, player_two.symbol, board)
      end
      game_loop(player_one, player_two, board)
    end
    if @turn_counter >= 9 and game_ended == false
      game_end(board.x_winner, board.o_winner)
    end
  end

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

#######################################################################################################################

board = Board.new
player_one = Player.new(1, "X")
player_two = Player.new(2, "O")
game = Game.new

board.set_up
board.print_board
game.game_loop(player_one, player_two, board)

class Board
  attr_accessor :board_visual, :o_row, :x_row
  COLUMN_SIZE = 3
  ROW_SIZE = 3

  def initialize
    @board_visual = Array.new(COLUMN_SIZE) {Array.new(ROW_SIZE)}
    @x_row = false
    @o_row = false
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
    player_input = (player_input - 3) % 3
    board_visual[board_index][player_input] != "X" && board_visual[board_index][player_input] != "O"
  end

  def who_wins?
    diagonal = 0
    mirrored_diagonal = 2
    d_array = Array.new
    m_d_array = Array.new
    vertical0 = Array.new
    vertical1 = Array.new
    vertical2 = Array.new

    board_visual.each_with_index do |h_array, board_index|
      board_visual
      d_array << h_array[diagonal]
      m_d_array << h_array[mirrored_diagonal]
      vertical0 << h_array[0]
      vertical1 << h_array[1]
      vertical2 << h_array[2]
      diagonal += 1
      mirrored_diagonal -= 1

      # p h_array
      # p d_array
      # p m_d_array

      if h_array.flatten.all?("X")
        @x_row = true
      elsif h_array.flatten.all?("O")
        @o_row = true
      end
    end
    if d_array.all?("X") or m_d_array.all?("X") or
      vertical0.all?("X") or vertical1.all?("X") or vertical2.all?("X")
      @x_row = true
    elsif d_array.all?("O") or m_d_array.all?("O") or
      vertical0.all?("O") or vertical1.all?("O") or vertical2.all?("O")
      @o_row = true
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
  attr_reader :player, :game_won
  @turn_counter

  def initialize
    @turn_counter = 0
  end

  def player_turn(player_input, symbol, board)
    player_input -= 1
    if player_input.between?(0, 8)
      if player_input.between?(0, 2) && board.not_labeled?(0, player_input)
        board.update_board(0, player_input, symbol)
        @turn_counter += 1

      elsif player_input.between?(3, 5) && board.not_labeled?(1, player_input)
        case player_input
        when 3
          board.update_board(1, 0, symbol)
        when 4
          board.update_board(1, 1, symbol)
        when 5
          board.update_board(1, 2, symbol)
        end
        @turn_counter += 1

      elsif player_input.between?(6, 8) && board.not_labeled?(2, player_input)
        case player_input
        when 6
          board.update_board(2, 0, symbol)
        when 7
          board.update_board(2, 1, symbol)
        when 8
          board.update_board(2, 2, symbol)
        end
        @turn_counter += 1
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
    if board.x_row == true or board.o_row == true
      game_ended = true
      game_end(board.x_row, board.o_row)
    end

    if @turn_counter < 9 and game_ended == false
      if @turn_counter.even?
        puts "Player 1: Your turn. Please enter a number between 1 and 9"
        player_turn(player_one.get_player_input, player_one.symbol, board)
        game_loop(player_one, player_two, board)
      else
        puts "Player 2: Your turn. Please enter a number between 1 and 9"
        player_turn(player_two.get_player_input, player_two.symbol, board)
        game_loop(player_one, player_two, board)
      end
    end
    if @turn_counter >= 9 and game_ended == false
      game_end(board.x_row, board.o_row)
    end
  end

  def game_end(x_row, o_row)
    if x_row == true
      puts "The game ended after #{@turn_counter} turns! Player 1 wins!"
    elsif o_row == true
      puts "The game ended after #{@turn_counter} turns! Player 2 wins!"
    else
      puts "The board is full and there is no winner! It's a tie!"
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

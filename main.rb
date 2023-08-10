class Board
  @@Board_size = 3
  @@Row_size = 5

  def initialize
    @board_array = Array.new(@@Board_size) { Array.new(@@Row_size) }
    set_up
    game_loop(@board_array)
  end

  def set_up
    @board_array.each_with_index do |row_array, row_index|
      row_array.each_with_index do |slot, slot_index|
        if slot_index.odd?
          @board_array[row_index][slot_index] = "|"
        elsif slot_index.even?
          @board_array[row_index][slot_index] = " "
        end
      end
    end
    print_board
  end

  protected

  def game_loop(board)
    turn_counter = 0

    if turn_counter.even?
      puts "Player 1: Your turn! Please enter the number of the field you want to label (1-9)."
      player_one_input = gets.chomp.to_i - 1

      if player_one_input.between?(0, 8)
        case player_one_input
        when (0..2) && input_not_XO(0, player_one_input)
          board[0][player_one_input] = "X"
          print_board
          turn_counter += 1

        when (3..5) && input_not_XO(1, player_one_input)
          board[1][player_one_input] = "X"
          print_board
          turn_counter += 1

        when (6..8) && input_not_XO(2, player_one_input)
          board[2][player_one_input] = "X"
          print_board
          turn_counter += 1

        else
          puts "\bPlayer 1: Please enter the number of a field that wasn't labeled yet."
          game_loop(@board_array)
        end
      else
        puts "Player 1: Please input a number between 1 and 9"
        game_loop(@board_array)
      end
    elsif turn_counter.odd?
      puts "Player 2: Your turn! Please enter the number of the field you want to label (1-9)."
      player_two_input = gets.chomp.to_i - 1

      if player_two_input.between?(0, 8)
        case player_two_input
        when (0..2) && input_not_XO(0, player_two_input)
          board[0][player_two_input] = "O"
          print_board
          turn_counter += 1

        when (3..5) && input_not_XO(1, player_two_input)
          board[1][player_two_input] = "O"
          print_board
          turn_counter += 1

        when (6..9) && input_not_XO(2, player_two_input)
          board[2][player_two_input] = "O"
          print_board
          turn_counter += 1

        else
          puts "\bPlayer 2: Please enter the number of a field that wasn't labeled yet."
          game_loop(@board_array)
        end
      else
        puts "Player 2: Please input a number between 1 and 9"
        game_loop(@board_array)
      end
    end
  end

  def input_not_XO(board_index, player_input)
    @board_array[board_index][player_input] != "X" && @board_array[board_index][player_input] != "O"
  end

  def print_board
    p @board_array[0].join(" ")
    p @board_array[1].join(" ")
    p @board_array[2].join(" ")
  end
end

#######################################################################################################################
board = Board.new


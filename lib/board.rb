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
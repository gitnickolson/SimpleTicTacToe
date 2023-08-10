class Board
  @@Board_size = 3
  @@Row_size = 5

  def initialize
    @board_array = Array.new(@@Board_size) { Array.new(@@Row_size) }
    set_up
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
    p @board_array[0].join(" ")
    p @board_array[1].join(" ")
    p @board_array[2].join(" ")
  end

  def game_loop

  end
end

#######################################################################################################################
board = Board.new

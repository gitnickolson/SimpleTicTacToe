# frozen_string_literal: true

class Player
  attr_reader :symbol, :player_number

  def initialize(player_number, symbol)
    @player_number = player_number
    @symbol = symbol
  end

  def get_player_input
    @player_input = gets.chomp.to_i
  end
end

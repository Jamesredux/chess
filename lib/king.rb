require './lib/piece.rb'
require_relative 'moves'

class King < Piece 
	include Moves
	attr_accessor :color, :symbol

	KING_MOVE_SET = [KING_MOVES]

	def initialize(color)
		super
		@symbol = find_symbol
		@has_moved = false #for castling
		@in_check = false
	end

	def find_symbol
		@color == "white" ? "\u2654" : "\u265A"
	end	

	def move_check(move_array, new_cell)
		move_ok?(move_array, KING_MOVE_SET)
	end

end
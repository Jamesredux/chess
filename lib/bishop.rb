require './lib/piece.rb'
require_relative 'moves'

class Bishop < Piece 
	include Moves
	attr_accessor :color, :symbol

	BISHOP_MOVE_SET = [DIAG_UP_EAST, DIAG_UP_WEST, DIAG_DOWN_EAST, DIAG_DOWN_WEST]

	def initialize(color)
		super
		@symbol = find_symbol
	end

	def find_symbol
		@color == "white" ? "\u2657" : "\u265D"
	end	

	def move_check(move_array, new_cell)
		move_ok?(move_array, BISHOP_MOVE_SET)
	end

end
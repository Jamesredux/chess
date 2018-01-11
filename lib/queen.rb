require './lib/piece.rb'
require_relative 'moves'

class Queen < Piece 
	include Moves
	attr_accessor :color, :symbol

	QUEEN_MOVE_SET = [VERT_UP, VERT_DOWN, HORIZ_EAST, HORIZ_WEST, DIAG_UP_EAST, DIAG_UP_WEST, DIAG_DOWN_EAST, DIAG_DOWN_WEST]

	def initialize(color)
		super
		@symbol = find_symbol
		
	end

	def find_symbol
		@color == "white" ? "\u2655" : "\u265B"
	end	

	def move_check(move_array)
		move_ok?(move_array, QUEEN_MOVE_SET)
	end	

end
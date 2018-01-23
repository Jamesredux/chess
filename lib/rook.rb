require './lib/piece.rb'
require_relative 'moves'


class Rook < Piece
	include Moves
	attr_accessor :color, :symbol
		ROOK_MOVE_SET = [VERT_UP, VERT_DOWN, HORIZ_EAST, HORIZ_WEST	]

	def initialize(color)
		super
		@symbol = find_symbol
		@has_moved = false #for castling
	end

	def find_symbol
		@color == "white" ? "\u2656" : "\u265C"
	end	

	def move_check(move_array, new_cell)
		move_ok?(move_array, ROOK_MOVE_SET)
	end	

end	


require './lib/piece.rb'
require_relative 'moves'

class Knight < Piece 
	include Moves
	attr_accessor :color, :symbol

	KNIGHT_MOVE_SET = [KNIGHT_MOVES]


	def initialize(color)
		super
		@symbol = find_symbol
	end

	def find_symbol
		@color == "white" ? "\u2658" : "\u265E"
	end	

	def move_check(move_array)
		move_ok?(move_array, KNIGHT_MOVE_SET)
	end	

end
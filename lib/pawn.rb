require './lib/piece.rb'
require_relative 'moves'


class Pawn < Piece 
	include Moves
	attr_accessor :color, :symbol
		WHITE_PAWN_MOVE_SET = [[VERT_UP[0]]]
		BLACK_PAWN_MOVE_SET = [[VERT_DOWN[0]]]


	def initialize(color)
		super
		@symbol = find_symbol
		@first_move = true #still has first move
	end

	def find_symbol
		@color == "white" ? "\u2659" : "\u265F"
	end	


	#need to look into moving this or move_ok? to parent class.
	def move_check(move_array)
		if @color == 'white'
			move_ok?(move_array, WHITE_PAWN_MOVE_SET)
			
		else
			move_ok?(move_array, BLACK_PAWN_MOVE_SET)
		end		
		
	end	

	

end
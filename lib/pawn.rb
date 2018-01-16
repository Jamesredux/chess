require './lib/piece.rb'
require_relative 'moves'


class Pawn < Piece 
	include Moves
	attr_accessor :color, :symbol
		WHITE_PAWN_MOVE_SET = [[VERT_UP[0]], [DIAG_UP_EAST[0]], [DIAG_UP_WEST[0]]]  #this is ugly do I have to put single array in array
		BLACK_PAWN_MOVE_SET = [[VERT_DOWN[0]], [DIAG_DOWN_EAST[0]], [DIAG_DOWN_WEST[0]]]


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
		if move_array == [2,0] || move_array == [-2,0]
			first_move_check
		elsif @color == 'white'
			move_ok?(move_array, WHITE_PAWN_MOVE_SET)
			
		else
			move_ok?(move_array, BLACK_PAWN_MOVE_SET)
		end		
		
	end	

	def first_move_check
		true
		
	end

	

end
require './lib/piece.rb'
require_relative 'moves'


class Pawn < Piece 
	include Moves
	attr_accessor :color, :symbol
		WHITE_PAWN_MOVE_SET = [[VERT_UP[0]], [DIAG_UP_EAST[0]], [DIAG_UP_WEST[0]]]  #not using this at present
		BLACK_PAWN_MOVE_SET = [[VERT_DOWN[0]], [DIAG_DOWN_EAST[0]], [DIAG_DOWN_WEST[0]]]


	def initialize(color)
		super
		@symbol = find_symbol
		@first_move = true #still has first move
	end

	def find_symbol
		@color == "white" ? "\u2659" : "\u265F"
	end	

	

=begin
	#need to look into moving this or move_ok? to parent class.
	def move_check(move_array, new_cell)
		if move_array == [2,0] || move_array == [-2,0]
			puts new_cell.piece
			first_move_check
		elsif move_array == [1,0] || move_array == [-1,0]	
			puts new_cell.piece
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

#pawn just have array of moves, 
# if one forward check cell empty
# if two forward, check first move and cell empty
# if diag, check taking conditions are satisfied + en passent.

=end


def move_check(move_array, new_cell)
	
	if @color  == 'white'
		white_pawn_check(move_array, new_cell)
	else
		black_pawn_check(move_array, new_cell)
	end		

end

def white_pawn_check(move_array, new_cell)
	if move_array == [-1, 0] && new_cell.piece == 0
		true
	elsif move_array == [-2, 0]
		if @first_move == true && new_cell.piece == 0
			@first_move = false
			true
		else
			false
		end		
	elsif
		if move_array == [-1,1] || move_array == [-1, -1]
			pawn_take_check(new_cell)
		end
	else
		false	
	end
end

def black_pawn_check(move_array, new_cell)
	if move_array == [1, 0] && new_cell.piece == 0
		true
	elsif move_array == [2, 0]
		if @first_move == true && new_cell.piece == 0
			@first_move = false
			true
		else
			false
		end		
	elsif
		if move_array == [1,1] || move_array == [1, -1]
			pawn_take_check(new_cell)
		end
	else
		false	
	end
end

def pawn_take_check(new_cell)
	if new_cell.piece == 0
		false
	else
		true
	end		
	
end

end

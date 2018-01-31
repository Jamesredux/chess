
require_relative 'board'

class Piece

	attr_accessor :color, :moves, :first_move

	def initialize(color=0)
		@color = color
		@moves = []
		@first_move = true

	end

	def move_check(move_array)
		puts "parent method called"
		true
	end

	def move_ok?(move_array, moves)
		@valid = false
		moves.each do |x|
			x.each do |y|
				if move_array == y 
					@valid = true
				end
			end
		end			
	@valid
	end

	def piecetest
		puts 'test'
		puts Board.grid
	end	


end





#white chess king	♔	U+2654	
#white chess queen	♕	U+2655	
#white chess rook	♖	U+2656	
#white chess bishop	♗	U+2657	/
#white chess knight	♘	U+2658	
#white chess pawn	♙	U+2659	
#black chess king	♚	U+265A	
#black chess queen	♛	U+265B	
#black chess rook	♜	U+265C	
#black chess bishop	♝	U+265D	
#black chess knight	♞	U+265E	
#black chess pawn	♟	U+265F	

# "\u265B"

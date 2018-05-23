
require_relative 'board'

class Piece

	attr_accessor :color, :moves, :first_move

	def initialize(color=0)
		@color = color
		@moves = []
		@first_move = true

	end



end

class King < Piece 
	attr_accessor :color, :symbol

	def initialize(color)
		super
		@symbol = find_symbol
	end

	def find_symbol
		@color == "white" ? "\u2654" : "\u265A"
	end	
end


class Queen < Piece 

	attr_accessor :color, :symbol

	def initialize(color)
		super
		@symbol = find_symbol
		
	end

	def find_symbol
		@color == "white" ? "\u2655" : "\u265B"
	end	

end

class Rook < Piece

	attr_accessor :color, :symbol
	
	def initialize(color)
		super
		@symbol = find_symbol
	end

	def find_symbol
		@color == "white" ? "\u2656" : "\u265C"
	end	
end	


class Knight < Piece 
	attr_accessor :color, :symbol


	def initialize(color)
		super
		@symbol = find_symbol
	end

	def find_symbol
		@color == "white" ? "\u2658" : "\u265E"
	end	
end

class Bishop < Piece 

	attr_accessor :color, :symbol


	def initialize(color)
		super
		@symbol = find_symbol
	end

	def find_symbol
		@color == "white" ? "\u2657" : "\u265D"
	end	

end

class Pawn < Piece 

	attr_accessor :color, :symbol
	
	def initialize(color)
		super
		@symbol = find_symbol
	end

	def find_symbol
		@color == "white" ? "\u2659" : "\u265F"
	end	

end

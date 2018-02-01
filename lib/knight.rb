require './lib/piece.rb'

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
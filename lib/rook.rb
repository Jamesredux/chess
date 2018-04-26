require './lib/piece.rb'

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


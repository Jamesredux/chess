
require_relative 'board'

class Piece

	attr_accessor :color, :moves, :first_move

	def initialize(color=0)
		@color = color
		@moves = []
		@first_move = true

	end

end



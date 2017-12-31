#board will go here
require_relative 'cell'

class BoardClass

	attr_accessor :board

	def initialize
		@board = create_board

	end

	def create_board
		board = []
		64.times do |x|
			x = Cell.new
			board<<x 
		end
		board 

	end	

	def draw_board
		a = @board[0..7]
		b = @board[8..15]
		puts a.inspect
		bottom_line = []
		a.each do |x| 
			bottom_line << x.contents
		end
		puts bottom_line.inspect
	end



end	

x = BoardClass.new
x.draw_board
x.board[7].contents = 'pawn'
x.draw_board

#board will go here
require_relative 'cell'

class BoardClass

	attr_accessor :board

	def initialize
		@board = create_board
		set_up_board

	end

	def create_board
		board = []
		8.times do  |y|
			row = []
			8.times do |x|
				x = Cell.new
				row<<x 
			end
				board<< row
			end		
		 board
				
		
		

	end	

	def draw_board
		board.each do |x|
			line = []
			x.each do |x|
				line<<x.contents
			
			end
			puts line.inspect

		end	
		puts "\n"	
	end

	def set_up_board
		board[1].each do |x|
			x.contents = "\u265F"
		end
		board[6].each do |x|
			x.contents = "\u2659"
		end
	end



end	

x = BoardClass.new
x.draw_board
x.board[1][4].contents = 5
x.draw_board
x.board[7][0].contents = 7
x.draw_board
#x.draw_board
#x.board[7].contents = "\u2659"
#x.draw_board

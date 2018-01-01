require_relative 'cell'
require_relative 'draw'

class BoardClass
	include Draw
	
	attr_accessor :board

	def initialize
		@board = create_board
		set_up_board
	end

	def create_board
		board_array = []
		8.times do  |y|
			row_array = []
			8.times do |x|
				x = Cell.new
				row_array<<x 
			end
				board_array<< row_array
			end		
		 board_array
	end	



	def set_up_board
		black_start_positions
		white_start_positions		
	end



	def black_start_positions
		#also have to put piece
		board[0][0].contents, board[0][7].contents = "\u265C","\u265C"
		board[0][1].contents, board[0][6].contents = "\u265E","\u265E"
		board[0][2].contents, board[0][5].contents = "\u265D","\u265D"
		board[0][3].contents = "\u265B"
		board[0][4].contents = "\u265A"
		#add pawns
		board[1].each do |x|
			x.contents = "\u265F";
		end
	end

	def white_start_positions
		board[7][0].contents, board[7][7].contents = "\u2656","\u2656"
		board[7][1].contents, board[7][6].contents = "\u2658","\u2658"
		board[7][2].contents, board[7][5].contents = "\u2657","\u2657"
		board[7][3].contents = "\u2655"
		board[7][4].contents = "\u2654"
		#add pawns
		board[6].each do |x|
			x.contents = "\u2659"
		end
	end


	

end	

x = BoardClass.new
x.draw_board

x.board[1][4].contents = 5
x.draw_board
x.board[5][0].contents = 7
x.draw_board


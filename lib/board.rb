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
		update_cell(board[0][0], -3)#rook
		update_cell(board[0][7], -3)#rook
		update_cell(board[0][1], -5)#knight
		update_cell(board[0][6], -5)#knight
		update_cell(board[0][2], -4)#bishop
		update_cell(board[0][5], -4)#bishop
		update_cell(board[0][3], -2)#queen
		update_cell(board[0][4], -1)#king
		#add pawns
		(0..7).each do |x|
			update_cell(board[1][x], -6)
		end
	end

	def white_start_positions
		update_cell(board[7][0], 3)#rook
		update_cell(board[7][7], 3)#rook
		update_cell(board[7][1], 5)#knight
		update_cell(board[7][6], 5)#knight
		update_cell(board[7][2], 4)#bishop
		update_cell(board[7][5], 4)#bishop
		update_cell(board[7][3], 2)#queen
		update_cell(board[7][4], 1)#king
		#add pawns
		(0..7).each do |x|
			update_cell(board[6][x], 6)
		end
	end


	def update_board(new_cell, old_cell)
		piece = old_cell.piece
		empty_cell(old_cell)
		update_cell(new_cell, piece)

	end	

	def update_cell(cell, piece=0)
			if piece == 0
				symbol = ' '
			else
				symbol = symbol_check(piece)
				
			end

		color = color_check(piece)
		cell.piece = piece
		cell.piece_color = color
		cell.symbol = symbol
		
	end

	def empty_cell(cell) #just a simplified method for emptying a cell
		update_cell(cell)
	end
	

	def symbol_check(piece)
		case piece 
		when -1 #black king
			"\u265A"
		when -2 #black queen
			"\u265B"
		when -3 #black rook
			"\u265C"
		when -4 #black bishop
			"\u265D"
		when -5 #black knight
			"\u265E"
		when -6 #black pawn
			"\u265F"				

		when 1 #white king
			"\u2654"
		when 2 #white queen
			"\u2655"
		when 3 #white rook
			"\u2656"
		when 4 #white bishop
			"\u2657"
		when 5 #white knight
			"\u2658"
		when 6 #white pawn
			"\u2659"
		end

	end
		
		def color_check(piece)
			if piece == 0 
				nil
			else 
				piece < 0 ? "Black" : "White"
			end	
		end			

	def valid_move(move_choice, color)
		@coordinates = convert_choice(move_choice)
		puts @coordinates.inspect
		if players_piece?(@coordinates, color) == false
			puts "NO dummy you don't have a piece on that square..."
			 false
		elsif land_on_own_piece?(@coordinates, color) == false
			puts "You alread have a piece on the destination square"
				false	 
		else
			true
		end	

	end		

	def players_piece?(coordinates, color)
		x = coordinates[0]
		y = coordinates[1]
		board[x][y].piece_color == color ? true : false
		
	end	

	def land_on_own_piece?(coordinates, color)
		x = coordinates[2]
		y = coordinates[3]
		@board[x][y].piece_color == color ? false : true
	end	

	def convert_choice(choice)
		choice_array = choice.split('')
		converted = []
		choice_array.each do |x|
			converted << convert_element(x)
	end	
			
		reordered_choice = [converted[1], converted[0], converted[3], converted[2]]
		reordered_choice
	end

	def convert_element(x)
		number_coords = ['1','2','3','4','5','6','7','8']
		letter_coords = ['a','b','c','d','e','f','g','h']
		if number_coords.include? x 
			number_convert(x)
		elsif letter_coords.include? x 
			letter_convert(x)
		end		
	end	

	def number_convert(x)
		num = x.to_i
		new_num = 8 - num 
		new_num
	end
	
	def letter_convert(x)
		case x
		when 'a'	
			0
		when 'b'	
			1
		when 'c'	
			2
		when 'd'	
			3
		when 'e'	
			4
		when 'f'	
			5
		when 'g'	
			6
		when 'h'	
			7
		end
	end		
				


end	



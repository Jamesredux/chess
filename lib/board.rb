require_relative 'cell'
require_relative 'draw'
require_relative 'pawn'
require_relative 'rook'
require_relative 'queen'
require_relative 'king'
require_relative 'bishop'
require_relative 'knight'


class BoardClass
	include Draw
	
	attr_accessor :board

	def initialize
		@board = create_board
		#set_up_board
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
		  black_back_row_pieces = [-3, -5, -4, -2, -1, -4, -5, -3]
		  x = 0
		  black_back_row_pieces.each do |y|
		  	update_cell(board[0][x], y)
		  	x += 1
		  end		
		#add pawns
		(0..7).each do |x|
			update_cell(board[1][x], -6)
		end
	end

	def white_start_positions
			white_back_row_pieces = [3, 5, 4, 2, 1, 4, 5, 3]
		  x = 0
		  white_back_row_pieces.each do |y|
		  	update_cell(board[7][x], y)
		  	x += 1
		  end				
		#add pawns
		(0..7).each do |x|
			update_cell(board[6][x], 6)
		end
	end

	def update_board(move_choice)
		coordinates = convert_choice(move_choice)
		old_cell = board[coordinates[0]][coordinates[1]]
		new_cell = board[coordinates[2]][coordinates[3]]
		move_piece(new_cell, old_cell)
	end	


	def move_piece(new_cell, old_cell)  #add memory to this to remember move if it needs to be taken back.
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
		if correct_length(move_choice) == false 
			puts "Incorrect input! Please only input 4 characters eg. A6A5"
			false
		elsif valid_input(move_choice) == false
			puts "Invalid input - please use the format B3H5"
			false	
		elsif players_piece?(@coordinates, color) == false
			puts "You do not have a piece on that square."
			false
		elsif land_on_own_piece?(@coordinates, color) == false
			puts "You can not move to a square you alreay occupy"
			false	 
		else
			true
		end	

	end		

	def correct_length(move_choice)
		move_choice.size == 4? true :false
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

def valid_input(move_choice)
		choice_array = move_choice.split('')
		if letters_ok(choice_array[0], choice_array[2]) == false
			false
		elsif numbers_ok(choice_array[1], choice_array[3]) == false
			false
		elsif choice_array[0] == choice_array[2] && choice_array[1] == choice_array[3]
			false
		else
		 true
		end
	end 			

	def letters_ok(a,b)
		letter_coords = ['a','b','c','d','e','f','g','h']

		if letter_coords.include?(a) && letter_coords.include?(b) 
			true
		else
			false
		end
	end

	def numbers_ok(a, b)	
		number_coords = ['1','2','3','4','5','6','7','8']

		if  number_coords.include?(a) && number_coords.include?(b)
			true
		else
			false	
		end			 
	end

	def convert_choice(move_choice)
		choice_array = move_choice.split('')
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
		

#this is currently in piece  branch - 
#looking for way to update cells with piece objects 
#the below stuff works at what it does

	def add_pieces_test
		piece_test(board[7][0], Rook, "white")
		piece_test(board[7][7], Rook, "white")
		piece_test(board[7][2], Bishop, "white")
		piece_test(board[7][5], Bishop, "white")
		piece_test(board[7][1], Knight, "white")
		piece_test(board[7][6], Knight, "white")
		piece_test(board[7][3], Queen, "white")
		piece_test(board[7][4], King, "white")

		
		(0..7).each do |x|
			piece_test(board[6][x], Pawn, "white")
		end
	end



	def piece_test(cell, piece, color)
			
		
		cell.piece = piece.new(color)
		#cell.piece_color = cell.piece.color
		cell.symbol = cell.piece.symbol
	end

	def move_test(old_cell, new_cell)
		new_cell.piece = old_cell.piece
		new_cell.symbol = new_cell.piece.symbol #need to update this automatically
		empty_cell(old_cell)
	end
		
end	





bob = BoardClass.new
bob.draw_board

#bob.piece_test(bob.board[7][0])

bob.add_pieces_test
bob.draw_board
bob.move_test(bob.board[7][0], bob.board[0][0])
bob.draw_board


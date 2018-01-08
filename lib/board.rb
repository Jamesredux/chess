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

	#initialize and set up

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
		place_white_pieces
		place_black_pieces		
	end

	def place_white_pieces
		new_piece(board[7][0], Rook, "white")
		new_piece(board[7][7], Rook, "white")
		new_piece(board[7][2], Bishop, "white")
		new_piece(board[7][5], Bishop, "white")
		new_piece(board[7][1], Knight, "white")
		new_piece(board[7][6], Knight, "white")
		new_piece(board[7][3], Queen, "white")
		new_piece(board[7][4], King, "white")
		
		(0..7).each do |x|
			new_piece(board[6][x], Pawn, "white")
		end
	end

	def place_black_pieces
		new_piece(board[0][0], Rook, "black")
		new_piece(board[0][7], Rook, "black")
		new_piece(board[0][2], Bishop, "black")
		new_piece(board[0][5], Bishop, "black")
		new_piece(board[0][1], Knight, "black")
		new_piece(board[0][6], Knight, "black")
		new_piece(board[0][3], Queen, "black")
		new_piece(board[0][4], King, "black")

		(0..7).each do |x|
			new_piece(board[1][x], Pawn, "black")
		end
	end

	def new_piece(cell, piece, color)	
		cell.piece = piece.new(color)
		cell.symbol = cell.piece.symbol
	end

	#check moves

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
		if board[x][y].piece == 0 || board[x][y].piece.color != color
			false
		else
			true
		end		 	
	end	

	def land_on_own_piece?(coordinates, color)
		x = coordinates[2]
		y = coordinates[3]
		if board[x][y].piece == 0
			true
		elsif 
			board[x][y].piece.color == color 
		  false
		else
			true
		end		
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

	def update_board(move_choice)
		coordinates = convert_choice(move_choice)
		old_cell = board[coordinates[0]][coordinates[1]]
		new_cell = board[coordinates[2]][coordinates[3]]
		move_piece(old_cell, new_cell)
	end	

	def move_piece(old_cell, new_cell)
		#is it here that I will keep memorary of move in case I have to take back.
		piece = old_cell.piece
		update_cell(new_cell, piece)
		empty_cell(old_cell)
	end

	def update_cell(cell, piece=0)
			if piece == 0
				cell.piece = 0
				cell.symbol = ' '
			else
				cell.piece = piece 
				cell.symbol = piece.symbol	
			end	
	end

	def empty_cell(cell) #just a simplified method for emptying a cell
		update_cell(cell)
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

end	


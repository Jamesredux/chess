#require_relative 'board'

module Chess

	def create_players
		@player_1 = Player.new("Player_1", "white")
		@player_2 = Player.new("Player_2", "black")
		@player_turn = @player_1
	end

	def create_player_computer

		player_color = get_color 
		player_color == 'white' ? computer_color = 'black' : computer_color = 'white'
		
		@player_1 = Player.new("Player_1", player_color)
		@player_2 = Player.new("computer", computer_color)
		@player_2.computer = true
		player_color == 'white' ? @first_player = @player_1 : @first_player = @player_2
		@player_turn = @first_player
	end

	def get_color
		puts "Player 1 please choose what color you would like to be 'w' for white and 'b' for black"
		color_choice = gets.chomp.downcase
		if color_choice == 'w'
			player_color = 'white'
		elsif color_choice == 'b'
			player_color = 'black'
		else
			puts "I didn't understand that choice"
			get_color		
		end
	end

	def get_computer_move
		@pieces_with_move = []
		@pieces_with_take = []
		puts "pieces with move #{@pieces_with_move.inspect}"
		puts "pieces with move #{@pieces_with_take.inspect}"
		@pieces_with_move = @location_of_pieces.select { |x| has_moves(x)== true }
		@pieces_with_take = @pieces_with_move.select { |x| has_takes(x)== true }
		move = deep_thought
		move_mapped = convert_computer_move(move)
		puts "Computer has chosed #{move_mapped}."
		return move
		
	end

	def has_moves(coord)
		cell = @board.grid[coord[0]][coord[1]]
		cell.piece.moves.size>0 ? true : false		
	end

	def has_takes(coord)
		@has_take = false
		cell = @board.grid[coord[0]][coord[1]]
		cell.piece.moves.each do |x|
			if oppo_piece(x) == true
				cell.piece.takes<<x 
				@has_take = true 
			end	

		end	
			@has_take
			
	end

	def oppo_piece(coord)
		move_cell = @board.grid[coord[0]][coord[1]]
		move_cell.piece == 0 ? false : true 
		
	end

	def deep_thought
		if @pieces_with_take.size != 0
			move = choose_take
			puts "take move"
		else
			move = choose_move
			puts "normal move"
		end			
		move 
	end

	def choose_take
		piece_to_move = @pieces_with_take.sample
		move_cell = @board.grid[piece_to_move[0]][piece_to_move[1]]
		the_take = move_cell.piece.takes.sample
		move = piece_to_move + the_take
		move
	end

	def choose_move
		piece_to_move = @pieces_with_move.sample
		move_cell = @board.grid[piece_to_move[0]][piece_to_move[1]]
		the_move = move_cell.piece.moves.sample
		move = piece_to_move + the_move
		move
		
	end
		
	def correct_input(move_choice, color)
		if correct_length(move_choice) == false 
			puts "Incorrect input! Please only input 4 characters eg. A6A5"
			false
		elsif valid_input(move_choice) == false
			puts "Invalid input - please use the format B3H5"
			false	
		else
			true
		end	
	end		

	def correct_length(move_choice)
		move_choice.size == 4? true :false
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

	def legal_move(move_choice, color)
			@coordinates = convert_choice(move_choice)
			if players_piece?(@coordinates, color) == false  
				puts "You do not have a piece on that square."
				false
			elsif land_on_own_piece?(@coordinates, color) == false   
				puts "You can not move to a square you already occupy"
				false	 
			elsif
				old_cell = @board.grid[@coordinates[0]][@coordinates[1]]
				new_coordinates = [@coordinates[2], @coordinates[3]] 
				if old_cell.piece.moves.include?(new_coordinates) == true
					true
				else
					puts "That is an invalid move"
					false
				end	
			end
	end	

	def switch_player
		@player_turn.in_check = false
		@player_turn == @player_1 ? @player_turn = @player_2 : @player_turn = @player_1
		all_available_moves(@player_turn.color)
	end

	def change_square(startsquare, move)
			new_coordinates = [startsquare, move].transpose.map { |y| y.reduce(:+) }
	end

	### all available moves methods

	def all_available_moves(color) 
		@sum_of_moves = 0 #counter that goes up every time a move is added - if it stays at 0 then stalemate/checkmate
		squares = squares_with_piece(color)
		squares.each do |x|
			map_moves(x, color)
		end
	end	

	def squares_with_piece(color)
		@location_of_pieces = []

		@board.grid.each_with_index do |row, index|
			x_coord = index
			row.each_with_index do |cell, index|
				y_coord = index
				if cell.piece == 0
					next
				elsif cell.piece.color == color
						square = [x_coord, y_coord]
						@location_of_pieces<<square
				else
					next 
				end			
			end
		end
		@location_of_pieces
	end	

	def map_moves(coordinates, color)
		cell = @board.grid[coordinates[0]][coordinates[1]]
		if cell.piece.instance_of?(Pawn) 
			pawn_moves(coordinates, cell, color)
		else
			piece_moves(cell, coordinates, color)
		end 		
	end		

	def pawn_moves(coordinates, cell, color)
		cell.piece.moves = []	
			if color == 'white'
					@pawn_take_set =  [[-1,-1], [-1, 1]]
					@pawn_move = [-1, 0]
					@double_move = [-2, 0]
			else
					@pawn_take_set =  [[1,-1], [1, 1]]
					@pawn_move = [1, 0]
					@double_move = [2, 0]
			end 				
			@piece_can_move = true
				while @piece_can_move
					new_grid =  change_square(coordinates, @pawn_move)
						 if pawn_square_check(new_grid, false, color) == false
						 	@piece_can_move = false
						 elsif cell.piece.first_move == false
						 	add_move(cell, coordinates, new_grid)
						 	@piece_can_move = false
						 else
						 	add_move(cell, coordinates, new_grid)
						 		new_grid = change_square(coordinates, @double_move) 
						 			 if  pawn_square_check(new_grid, false, color) == true
						 			 	add_move(cell, coordinates, new_grid)
						 			 end
						 			@piece_can_move = false
						 	end		 
				end 

			@pawn_take_set.each do |move|
				new_grid = change_square(coordinates, move)
				 if pawn_square_check(new_grid, true, color)	== true
				 	add_move(cell, coordinates, new_grid)
				 end
			end
	end

	def pawn_square_check(coordinates, can_take, color)
		square = @board.grid[coordinates[0]][coordinates[1]]	
			if square_on_board(coordinates) == false
				false
			elsif can_take == false
				cell_empty(square) ? true : false
		 
			else				
				if square.enpassant != false && square.enpassant_color == color
					true	
				elsif cell_empty(square)
			   	false			
			 	elsif square.piece.instance_of?(King)
			 		false
			 	else		
			 	 square.piece.color == color ? false : true
				end		
			end
	end

	def piece_moves(cell, coordinates, color)
		piece = cell.piece
		log_moves(cell, coordinates, piece, color)		
	end	

	def log_moves(cell, coordinates, piece, color)		
		cell.piece.moves = []
		@single_move = single_move?(piece)
		@move_set = get_move_set(piece)
		
			@move_set.each do |move|
				start_grid = coordinates
				@piece_can_move =true
				while @piece_can_move
					
						new_grid = change_square(start_grid, move)
							if square_check(new_grid, color) == false #if next square is off board or own color(blocked)
								@piece_can_move = false
							else new_cell = @board.grid[new_grid[0]][new_grid[1]]	
								if cell_empty(new_cell) 
									add_move(cell, coordinates, new_grid)
									if @single_move == true
										@piece_can_move = false
									else
										start_grid = new_grid
									end	
								elsif new_cell.piece.instance_of?(King) #stops taking of king
									@piece_can_move = false												
								else
										add_move(cell, coordinates, new_grid)
										@piece_can_move = false
								end								
							end
				end 	
			end	
			#i have not added the add move method to castling as this method already checks if any of the possible moves put someone in check.
			if cell.piece.instance_of?(King) && cell.piece.first_move == true
					castle_move_set = [[0,2], [0,-2]]				
				if castle_check(coordinates, color, 'right')
					right_castle_position = change_square(coordinates, castle_move_set[0])
					cell.piece.moves<<right_castle_position
					@sum_of_moves+= 1
				end 	
				if castle_check(coordinates, color, 'left') == true
					left_castle_position = change_square(coordinates, castle_move_set[1])
					cell.piece.moves<<left_castle_position
					@sum_of_moves+= 1
				end 			
			end					
	end	

	def add_move(old_cell, start_grid, new_grid)
			new_cell = @board.grid[new_grid[0]][new_grid[1]]	
		  move_coordinates = start_grid + new_grid
			snapshot(old_cell, new_cell)
			@board.update_board(move_coordinates, old_cell, new_cell)

		  if	in_check?(@player_turn.color)
				revert_board(old_cell, new_cell)
			else
				revert_board(old_cell, new_cell)
				old_cell.piece.moves<<new_grid
				@sum_of_moves += 1	
			end		
	end

	def snapshot(old_cell, new_cell)
		@old_cell_snapshot = cell_memory(old_cell)
		@new_cell_snapshot = cell_memory(new_cell)
		
	end

	def cell_memory(cell)
		cell_contents =  []
		cell_contents<<cell.symbol
		cell_contents<<cell.enpassant
		cell_contents<<cell.enpassant_color
		cell_contents<<cell.piece
		if cell.piece != 0
			cell_contents<<cell.piece.first_move
		end	
		
		cell_contents
	end	

	def revert_board(old_cell, new_cell)
		revert_cell(old_cell, @old_cell_snapshot)
		revert_cell(new_cell, @new_cell_snapshot)
	end

	def revert_cell(cell, contents)
		cell.symbol = contents[0]
		if cell.enpassant != false && cell.enpassant.size == 3
			cell_coords = cell.enpassant[0..1]
			contents[2] == 'white' ? cell_color = 'black' : cell_color = 'white'
			replace_enpassant_pawn(cell_coords, cell_color)
		end
		cell.enpassant = contents[1]
		cell.enpassant_color = contents[2]
		cell.piece = contents[3]
		if cell.piece != 0
			cell.piece.first_move = contents[4]
		end	

	end	

	def replace_enpassant_pawn(coords, color)
		cell = @board.grid[coords[0]][coords[1]]
		@board.new_piece(cell, Pawn, color)	
	end




	def get_move_set(piece)
		if piece.instance_of?(Queen)
			@move_set = [[1,1],[-1,-1], [-1, 1], [1, -1],[1,0],[-1,0], [0,1], [0, -1]]
		elsif piece.instance_of?(Rook)
			@move_set = [[1,0],[-1,0], [0,1], [0, -1]]
		elsif piece.instance_of?(Bishop)
			@move_set = [[-1,-1],[-1, 1], [1, 1], [1, -1]]
		elsif piece.instance_of?(King)
			@move_set = [[1,1],[-1,-1], [-1, 1], [1, -1],[1,0],[-1,0], [0,1], [0, -1]]	 	
		elsif piece.instance_of?(Knight)
			@move_set = [[-2,-1],[-2,1],[-1,-2],[-1,2],[1,-2],[1,2],[2,-1],[2,1]]
		end	
		@move_set

	end

	def single_move?(piece)
		if piece.instance_of?(King) || piece.instance_of?(Knight)
			true
		else
			false
		end 		
	end


 def castle_check(coordinates, color, side)
 		side == 'right' ? squares = [4, 5, 6, 7] : squares = [4, 3, 2, 1, 0]

 	  row = coordinates[0]
		if castle_empty(row, squares[1..-2]) == true
			rook_square = @board.grid[row][squares[-1]]
			if rook_square.piece.instance_of?(Rook) && rook_square.piece.first_move == true
				squares_to_check = []
					squares[0..-2].each do |x|
						a = [row, x]
						squares_to_check<<a	
					end	
				if squares_clear(squares_to_check, color)
					true
				end
			end
		else
			 false	
		end			
	end

	def castle_empty(row, squares_array)
			@squares_empty = true
			squares_array.each do |x|
				square = @board.grid[row][x]
					if cell_empty(square) == false
						@squares_empty = false
					end 		
			end	
			@squares_empty
	end 	




	def squares_clear(squares_to_check, color) #for castling
			@all_clear = true

			squares_to_check.each do |square|
						 if under_attack?(square, color) == true
								@all_clear = false
							end
			end
		@all_clear
		#should find way to stop itteration after first under attack							
	end


	def square_check(coordinates, color)
		if square_on_board(coordinates) == false
		 false
		else
		 	square = @board.grid[coordinates[0]][coordinates[1]]	
				if cell_empty(square)
					true #do I need this
				elsif square.piece.color == color

			    false
			  end 	
		end
	end

	def take_square(coordinates, color)
		@take_opportunity = false  #need to add where you can't take king
			square = @board.grid[coordinates[0]][coordinates[1]]	
				if cell_empty(square) || square.piece.instance_of?(King)
					@take_opportunity = false
				
				elsif square.piece.color != color 
			   @take_opportunity = true
			  end 			
		@take_opportunity	  
	end	
	

	def square_on_board(coordinates)
		if coordinates[0] < 0 || coordinates[0] > 7
			false
		elsif coordinates[1] < 0 || coordinates[1] > 7
			false	
		else
			true
		end


	end	


	def under_attack?(coordinates, color)
		if attack_from_knight(coordinates, color) == true
			true
		elsif 
				straight_attack(coordinates, color) == true
				true
		elsif 
				diag_attack(coordinates, color) == true
				true
		elsif 
				pawn_attack(coordinates, color) == true
				true
		else	
			false
		end

	end	

	def attack_from_knight(coordinates, color)
		@knight_move_set = [[-2,-1],[-2,1],[-1,-2],[-1,2],[1,-2],[1,2],[2,-1],[2,1]]
		@attacked_by_knight = false
		 @knight_move_set.each do |move|
		 	threat_square = change_square(coordinates, move)
				if threat_from_square(threat_square, Knight, color) == true	
					@attacked_by_knight = true
				end

			end
			@attacked_by_knight
	end

	def straight_attack(coordinates, color)
		@rook_move_set = [[1,0],[-1,0], [0,1], [0, -1]]
		@straight_threat = false
		@rook_move_set.each do |move|
			start_square = coordinates
			@clear_path = true
			@distance = 1
				while @clear_path
					next_square = change_square(start_square, move)#[start_square, move].transpose.map { |y| y.reduce(:+) }	
						if square_check(next_square, color) == false	#checks if square is off board or occupied by piece of own color
							@clear_path = false
						else next_cell = @board.grid[next_square[0]][next_square[1]]
							if next_cell.piece.instance_of?(Rook) == true || next_cell.piece.instance_of?(Queen) == true
									@straight_threat = true
									@clear_path = false
							#need to stop if hit other opposition piece9
							elsif 
									next_cell.piece.instance_of?(King) == true && @distance == 1
									@clear_path = false

									@straight_threat = true
							elsif 
								cell_empty(next_cell) == true
								@distance += 1
								start_square = next_square
	
							else
								#the square is occupied by an opposition piece that can not take you.
								@clear_path = false		
							end
						end
				end		
		end
		@straight_threat			
	end

	def diag_attack(coordinates, color) #this will not include pawns at the moment - have to do a separate method for them.
		@bishop_move_set = [[-1,-1],[-1, 1], [1, 1], [1, -1]]
		@diag_threat = false
		@bishop_move_set.each do |move|
			start_square = coordinates
			@clear_path = true
			@distance = 1
				while @clear_path
					next_square = change_square(start_square, move)
						if square_check(next_square, color) == false	#checks if square is off board or occupied by piece of own color
							@clear_path = false
						else next_cell = @board.grid[next_square[0]][next_square[1]]
							if next_cell.piece.instance_of?(Bishop) == true || next_cell.piece.instance_of?(Queen) == true
								@diag_threat = true
								@clear_path = false
							elsif 
								next_cell.piece.instance_of?(King) == true && @distance == 1
								@clear_path = false
								@diag_threat = true
							elsif 
								cell_empty(next_cell) == true
								@distance += 1
								start_square = next_square
							else
								#this should only be called when piece on square is an opposition piece that can not take you.
								@clear_path = false		
							end
						end
				end
		end
		@diag_threat			
	end

	def pawn_attack(coordinates, color)
		@pawn_threat = false
		color == 'black' ? @take_set = [[1,-1], [1, 1]] : @take_set = [[-1,-1], [-1, 1]] #this is the reverse of what should be correct as I am looking
		#for where the threat is coming from so it is the  mirror image
		@take_set.each do |move|
			start_square = coordinates
				next_square = change_square(start_square, move)				
						if square_check(next_square, color) == false	#checks if square is off board or occupied by piece of own color
							next
						else next_cell = @board.grid[next_square[0]][next_square[1]]
							if next_cell.piece.instance_of?(Pawn) == true  
									@pawn_threat = true
							end
						end					
		end
		@pawn_threat			
	end

	def threat_from_square(coordinates, piece, color) #only used by knight check at present not a very good or clear method
		#only tells you if there is an opposition piece on that square
		@threat_present = false
		if square_on_board(coordinates) == false
			false
		else
			square = @board.grid[coordinates[0]][coordinates[1]]
			if cell_empty(square) == true
				@threat_present = false
			elsif
				square.piece.color != color && square.piece.instance_of?(piece) 
				@threat_present = true
			end

		end
		@threat_present		
		
	end

	def in_check?(color)
		king_coordinates = find_king(color)
		if under_attack?(king_coordinates, color)
			true
		else
			false	
		end		
	end

	def find_king(color)
		@board.grid.each_with_index do |row, index|
			x_coord = index
			row.each_with_index do |cell, index|
				y_coord = index
				if cell.piece == 0
					next
				elsif cell.piece.color == color && cell.piece.instance_of?(King)
						square = [x_coord, y_coord]
						@location_of_king = square
				else
					next 
				end			
			end
		end
		@location_of_king
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

 def players_piece?(coordinates, color)  #reruse this with other methods
		x = coordinates[0]
		y = coordinates[1]
		if @board.grid[x][y].piece == 0 || @board.grid[x][y].piece.color != color
			false
		else
			true
		end		 	
	end	

	def land_on_own_piece?(coordinates, color)   #incorporate this into legal move check - just add that last square is not own piece
		x = coordinates[2]
		y = coordinates[3]
		if @board.grid[x][y].piece == 0
			true
		elsif 
			@board.grid[x][y].piece.color == color 
		  false
		else
			true
		end		
	end	

	def cell_empty(cell)
		if cell.piece == 0
			true
		else
			false
		end		
	end


end	

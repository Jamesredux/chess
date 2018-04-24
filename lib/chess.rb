require_relative 'board'

module Chess
	

	def valid_move(move_choice, color)
		@coordinates = convert_choice(move_choice) 
		if correct_length(move_choice) == false 
			puts "Incorrect input! Please only input 4 characters eg. A6A5"
			false
		elsif valid_input(move_choice) == false
			puts "Invalid input - please use the format B3H5"
			false	
		elsif players_piece?(@coordinates, color) == false  #move to legal move with land on own piece so won't have to call convert_choice in this method
			puts "You do not have a piece on that square."
			false
		elsif land_on_own_piece?(@coordinates, color) == false    #logically this should be in legal move
			puts "You can not move to a square you already occupy"
			false	 
		else
			true
		end	
	end		

	def correct_length(move_choice)
		move_choice.size == 4? true :false
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


def legal_move(move_choice, color)
	#this runs all_available_moves at every turn logging
	#every available move for the color and then 
	#logging them by each cell with a piece on of that color in
	#its 'moves' method. This includes takes. It then checks 
	#the square that the player wants to move to and if it is in the moves from the cell it is 
	#moving from it is a legal move
	# 2 issues stalemate - if there are no moves this should stop game at stalemate - but this does not 
	#record king take, if you are putting someone in check then you can not be in stalemate - would this be an issue - 
	# when I create a check check it would run before a stalemate check really ?
	# It does let you take the king which is correct but if I could reuse this to check if someone is in check that would be useful.
	# the square check has a check if player 'could' take king - maybe from this I could trigger something?
		@coordinates = convert_choice(move_choice)
		old_cell = @board.grid[@coordinates[0]][@coordinates[1]]
		new_cell = @board.grid[@coordinates[2]][@coordinates[3]]
		all_available_moves(color)
		new_coordinates = [@coordinates[2], @coordinates[3]]
		if old_cell.piece.moves.include?(new_coordinates)
			true
		else
			puts "That is an invalid move"
			false
		end
				
	end	



	def cell_empty(cell)
		if cell.piece == 0
			true
		else
			false
		end		
		
		
	end


	def all_available_moves(color)  #this method won't take color when running in game
		@sum_of_moves = 0 #counter that goes up every time a move is added - if it stays at 0 then stalemate/checkmate
		#haven't finished this, would it be better to run a method for all piece moves to see it they are all empty.?
		squares = squares_with_piece(color)
		squares.each do |x|
			map_moves(x, color)
		end
		puts "this is the number of moves = #{@sum_of_moves}"
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

	def piece_check(coordinates, color)
		puts @board.grid[coordinates[0]][coordinates[1]].piece 
		
	end


	def map_moves(coordinates, color)
		cell = @board.grid[coordinates[0]][coordinates[1]]
		if cell.piece.instance_of?(Pawn) && color == 'white'
			white_pawn_moves(coordinates, cell)
		elsif cell.piece.instance_of?(Pawn) && color == 'black'
			black_pawn_moves(coordinates, cell)
		else
			piece_moves(cell, coordinates, color)
		end 		

	end		

	def white_pawn_moves(coordinates, cell)
			cell.piece.moves = []
			white_pawn_take_set =  [[-1,-1], [-1, 1]]
			@route_clear = true
				while @route_clear
					new_square = [coordinates, [-1, 0]].transpose.map { |y| y.reduce(:+) }
						 if pawn_square_check(new_square, false, 'white') == false
						 	@route_clear = false
						 elsif cell.piece.first_move == false
						 	cell.piece.moves<<new_square
						 	@sum_of_moves+= 1
						 	@route_clear = false
						 else
						 	cell.piece.moves<<new_square
						 	@sum_of_moves += 1
						 		new_square = [coordinates, [-2, 0]].transpose.map { |y| y.reduce(:+) }	 
						 			 if  pawn_square_check(new_square, false, 'white') == true
						 			 	cell.piece.moves<<new_square
						 			 	@sum_of_moves += 1
						 			 end
						 			@route_clear = false
						 	end		 
				end 

 	#in here I will have to put a method that adds the possible moves if there is an en passant take available
			white_pawn_take_set.each do |move|
				new_square = [coordinates, move].transpose.map {  |y| y.reduce(:+) }
				 if pawn_square_check(new_square, true, 'white')	== true
				 	cell.piece.moves<<new_square
				 	@sum_of_moves+= 1
				 end
			end
	end

	def black_pawn_moves(coordinates, cell)
			cell.piece.moves = []
			black_pawn_take_set =  [[1,-1], [1, 1]]
			@route_clear = true
				while @route_clear
					new_square = [coordinates, [1, 0]].transpose.map { |y| y.reduce(:+) }
						 if pawn_square_check(new_square, false, 'black') == false
						 	@route_clear = false
						 elsif cell.piece.first_move == false
						 	
						 	cell.piece.moves<<new_square
						 	@sum_of_moves+= 1
						 	@route_clear = false
						 else
						 	cell.piece.moves<<new_square
						 	@sum_of_moves += 1
						 		new_square = [coordinates, [2, 0]].transpose.map { |y| y.reduce(:+) }	 
						 			 if  pawn_square_check(new_square, false, 'black') == true
						 			 	cell.piece.moves<<new_square
						 			 	@sum_of_moves+= 1
						 			 end
						 			@route_clear = false
						 	end		 
				end 

				#in here I will have to put a method that adds the possible moves if there is an en passant take available
			black_pawn_take_set.each do |move|
				new_square = [coordinates, move].transpose.map {  |y| y.reduce(:+) }
				 if pawn_square_check(new_square, true, 'black')	== true
				 	cell.piece.moves<<new_square
				 	@sum_of_moves+= 1
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
			#if square.enpass = true then return true? would that work?
			#would the only pawns that were looking to move into the square during this method
			#be ones that had the right to take en pass I think so. remember that this method is just listing the available 
			#moves
				
			 if cell_empty(square)

			   	false			
			 elsif square.piece.instance_of?(King)
			 		false
			 else		
			 	 square.piece.color == color ? false : true
			end		
		end
	end



	def piece_moves(cell, coordinates, color)
		color == 'white' ? other_color = 'black': other_color = 'white'
		piece = cell.piece

		if piece.instance_of?(Rook) 
			rook_moves(cell, coordinates, color)
		elsif piece.instance_of?(Knight)
			knight_moves(cell, coordinates, color)
		elsif piece.instance_of?(Bishop)
			bishop_moves(cell, coordinates, color)
		elsif piece.instance_of?(Queen)
			queen_moves(cell, coordinates, color)
		elsif piece.instance_of?(King)
			king_moves(cell, coordinates, color)	
		end				

	end	

	def rook_moves(cell, coordinates, color)
		cell.piece.moves = []
		@rook_move_set = [[1,0],[-1,0], [0,1], [0, -1]]
			@rook_move_set.each do |move|
				start_square = coordinates
				@clear_path =true
				while @clear_path
					
						new_position = [start_square, move].transpose.map { |y| y.reduce(:+)}
							if square_check(new_position, color) == false
								@clear_path = false
							elsif take_square(new_position, color) == true
								cell.piece.moves<<new_position
								@sum_of_moves += 1
								@clear_path = false
									
							else
								cell.piece.moves<<new_position
								@sum_of_moves += 1
								start_square = new_position	
							end	
								

				end 	
			end			
	end



	def knight_moves(cell, coordinates, color)
			cell.piece.moves = []
				@knight_move_set = [[-2,-1],[-2,1],[-1,-2],[-1,2],[1,-2],[1,2],[2,-1],[2,1]]
				
				@knight_move_set.each do |move|
					start_square = coordinates
					new_position  = [start_square, move].transpose.map { |y| y.reduce(:+)}
						if square_check(new_position, color) == false
							next 
						elsif take_square(new_position, color) == true
							cell.piece.moves<<new_position
						else
							cell.piece.moves<<new_position
						end
				end				
								
	end

	def bishop_moves(cell, coordinates, color)
		cell.piece.moves = []
		@bishop_move_set = [[-1,-1],[-1, 1], [1, 1], [1, -1]]
			@bishop_move_set.each do |move|
				start_square = coordinates
				@clear_path =true
				while @clear_path
					
						new_position = [start_square, move].transpose.map { |y| y.reduce(:+)}
							if square_check(new_position, color) == false
								@clear_path = false
								
							elsif take_square(new_position, color) == true
								puts "take_square returned"
								cell.piece.moves<<new_position
								@clear_path = false
							else
								cell.piece.moves<<new_position
								start_square = new_position	
							
							end	
								

				end 	
			end			
	end

	def queen_moves(cell, coordinates, color)
		cell.piece.moves = []
		@queen_move_set = [[1,1],[-1,-1], [-1, 1], [1, -1],[1,0],[-1,0], [0,1], [0, -1]]
			@queen_move_set.each do |move|
				start_square = coordinates
				@clear_path =true
				while @clear_path
					
						new_position = [start_square, move].transpose.map { |y| y.reduce(:+)}
							if square_check(new_position, color) == false
								@clear_path = false
							elsif take_square(new_position, color) == true
								cell.piece.moves<<new_position
								@clear_path = false
									
							else
								cell.piece.moves<<new_position
								start_square = new_position	
							end	
								

				end 	
			end			
	end

	def king_moves(cell, coordinates, color)
		cell.piece.moves = []
		king_move_set = [[1,1],[-1,-1], [-1, 1], [1, -1],[1,0],[-1,0], [0,1], [0, -1]]
			king_move_set.each do |move|
				start_square = coordinates
						new_position = [start_square, move].transpose.map { |y| y.reduce(:+)}
							if square_check(new_position, color) == false
								next
							elsif take_square(new_position, color) == true
								cell.piece.moves<<new_position
							else
								cell.piece.moves<<new_position	
							end	
			end
			#castling check
			if cell.piece.first_move == true
					puts "king has not moved"
					castle_move_set = [[0,2], [0,-2]]
					right_castle_position = [coordinates, castle_move_set[0]].transpose.map { |y| y.reduce(:+)}
					left_castle_position = [coordinates, castle_move_set[1]].transpose.map { |y| y.reduce(:+)}
				if right_castle_check(cell, coordinates, color) == true
					cell.piece.moves<<right_castle_position
					puts cell.piece.moves.inspect
				end 	
				if left_castle_check(cell, coordinates, color) == true
					cell.piece.moves<<left_castle_position
					puts cell.piece.moves.inspect
				end 			

			end



					


			#if cell.piece.first_move == true
			# castling_check(cell, color, coordinates)
			#add castling check here		
	end

	def right_castle_check(cell, coordinates, color)
		row = coordinates[0]
		column = coordinates[1]
		r_square = @board.grid[row][column+1]
		second_r_square = @board.grid[row][column+2]
		if cell_empty(r_square) == true  && cell_empty(second_r_square) == true
			puts "both right squares empty"
			rook_square = @board.grid[row][column+3]
			if rook_square.piece.instance_of?(Rook)
				puts "its a rook"
				if rook_square.piece.first_move == true
					puts "rook has not moved"

						squares_to_check = [[row,4],[row,5],[row,6]]
						
						if squares_clear(squares_to_check, color)
							puts "no square under attack"
						
						end	
					#if squares under attact is false return true
					true
				end	
			end 	
			
		else
			false
		end 	
		
		#false
		
	end

	def left_castle_check(cell, coordinates, color)
		row = coordinates[0]
		column = coordinates[1]
		l_square = @board.grid[row][column-1]
		second_l_square = @board.grid[row][column-2]
		third_l_square = @board.grid[row][column-3]
		if cell_empty(l_square) == true  && cell_empty(second_l_square) == true && cell_empty(third_l_square)
			puts "all left squares empty"
			rook_square = @board.grid[row][column-4]
			if rook_square.piece.instance_of?(Rook)
				puts "its a rook"
				if rook_square.piece.first_move == true
					puts "rook has not moved"
						squares_to_check = [[row,4],[row,3],[row,2],[row,1]]
							if squares_clear(squares_to_check, color)
								puts "no left square under attack"
							end	
					#if squares under attact is false return true
					true
				end	
			end 	
			
		else
			false
		end 	
		
		#false
		
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
					true
				elsif square.piece.color == color
			    false
			  #elsif square.piece.instance_of?(King)
			  #	puts "**** I PUT YOU IN CHECK  *****"
			  	#this doesn't work at present at this is called before each move -
			  	# to work it would have to be called after each move.
			  #	false  
			  end 	
		end
	end

	def take_square(coordinates, color)  #need to add where you can't take king
			square = @board.grid[coordinates[0]][coordinates[1]]	
				if cell_empty(square)
					false
				elsif square.piece.instance_of?(King)
					puts "king take"
					false	
				elsif square.piece.color != color 
			    true
			  end 			

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

	#is square  under attack method at the moment I plan to make it that this will return true or false on whether
	# a cell is under attact. Stored in the cell object. I could also add what it is under attack from and where 
	# but I am not sure if I need this at the moment.
	# for checking check  mate i plan to go through all the possible moves for the side under attact until I find 
	# a situation when the king is not under attack.

	def under_attack?(coordinates, color)
		puts "checking if #{coordinates.inspect} is under attack"
		
		if attack_from_knight(coordinates, color) == true
			true
		elsif 
				straight_attack(coordinates, color) == true
				puts "straight attack!!"
				true
		elsif 
				diag_attack(coordinates, color) == true
				puts "diag attack"
				true		
		else	
			false
		end
			
		


		

	end	

	def attack_from_knight(coordinates, color)
		@attacked_by_knight = false
		 @knight_move_set.each do |move|
		 	threat_square = [coordinates, move].transpose.map { |y| y.reduce(:+)}
				if threat_from_square(threat_square, Knight, color) == true
					@attacked_by_knight == true
				end
			end
			@attacked_by_knight
	end

	def straight_attack(coordinates, color)
		@straight_threat = false
		@rook_move_set.each do |move|
			start_square = coordinates
			@clear_path = true
			@distance = 1
				while @clear_path
					next_square = [start_square, move].transpose.map { |y| y.reduce(:+) }
						puts "straight check next square #{next_square.inspect}"
						
						if square_check(next_square, color) == false	#checks if square is off board or occupied by piece of own color
							@clear_path = false
						else next_cell = @board.grid[next_square[0]][next_square[1]]
							if next_cell.piece.instance_of?(Rook) == true || next_cell.piece.instance_of?(Queen) == true
									puts  "a square is under straight threat" 
									@straight_threat = true
									@clear_path = false
							#need to stop if hit other opposition piece9
							elsif 
									next_cell.piece.instance_of?(King) == true && @distance == 1
									puts "the king threatens the square"
									@clear_path = false

									@straight_threat = true
							elsif 
								cell_empty(next_cell) == true
								@distance += 1
								puts "distance#{@distance}"
								start_square = next_square
	
							else
								puts "this method DOES get called sometimes"
							@clear_path = false		
							end
						end
				end
				puts  "straight threat is #{@straight_threat}"
						
		end
		@straight_threat			
	end

	def diag_attack(coordinates, color) #this will not include pawns at the moment - have to do a separate method for them.
		@diag_threat = false
		@bishop_move_set.each do |move|
			start_square = coordinates
			@clear_path = true
			@distance = 1
				while @clear_path
					next_square = [start_square, move].transpose.map { |y| y.reduce(:+) }
						puts "diag check next square #{next_square.inspect}"
						
						if square_check(next_square, color) == false	#checks if square is off board or occupied by piece of own color
							@clear_path = false
						else next_cell = @board.grid[next_square[0]][next_square[1]]
							if next_cell.piece.instance_of?(Bishop) == true || next_cell.piece.instance_of?(Queen) == true
									puts  "a square is under diagonal threat" 
									@diag_threat = true
									@clear_path = false
							#need to stop if hit other opposition piece9
							elsif 
									next_cell.piece.instance_of?(King) == true && @distance == 1
									puts "the king threatens the square diagonally"
									@clear_path = false

									@diag_threat = true
							elsif 
								cell_empty(next_cell) == true
								@distance += 1
								puts "distance#{@distance}"
								start_square = next_square
	
							else
								puts "this method DOES get called sometimes"
							@clear_path = false		
							end
						end
				end
				puts  "diag_threat is #{@diag_threat}"
						
		end
		@diag_threat			
	end

	def threat_from_square(coordinates, piece, color) #is this being used by anything
		if square_on_board(coordinates) == false
			false
		else
			square = @board.grid[coordinates[0]][coordinates[1]]
			if cell_empty(square) == true
				false
			elsif
				square.piece.color != color && square.piece.instance_of?(piece) 
				puts "your threatened by a #{piece}"

				true
			end

		end		
				
		
	end

end	


module Computer

	#need computer to promote

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

				@pieces_with_move = @location_of_pieces.select { |x| has_moves(x)== true }
				@pieces_with_take = @pieces_with_move.select { |x| has_takes(x)== true }
			move = deep_thought
			move_mapped = convert_computer_move(move)
			puts "Computer has moved from #{move_mapped[0..1].join.upcase} to #{move_mapped[2..3].join.upcase}."
			return move
		end

		def has_moves(coord)
			cell = @board.grid[coord[0]][coord[1]]
			cell.piece.moves.size>0 ? true : false		
		end

		def has_takes(coord)
			@has_take = false
			cell = @board.grid[coord[0]][coord[1]]
			cell.piece.takes = []
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
				puts "The computer has taken your piece"
			else
				move = choose_move
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

		def convert_computer_move(move_choice)
		
			converted = []
			converted[0] = convert_col(move_choice[1])
			converted[1] = convert_row(move_choice[0])
			converted[2] = convert_col(move_choice[3])
			converted[3] = convert_row(move_choice[2])
	
			converted
		end

		def convert_col(x)
			case x
			when 0	
				'a'
			when 1	
				'b'
			when 2	
				'c'
			when 3	
				'd'
			when 4	
				'e'
			when 5	
				'f'
			when 6	
				'g'
			when 7	
				'h'
			end	
		end

		def convert_row(x)
		
			new_num = (8 - x).to_s
			new_num	
		end







end 
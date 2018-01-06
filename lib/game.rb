require_relative 'board'
require_relative 'player'

class Game
	attr_accessor :player_turn	

	def new_game
		@board = BoardClass.new
		@board.draw_board




	end

	def create_players
		@player_1 = Player.new("Player_1", "White")
		@player_2 = Player.new("Player_2", "Black")
		@player_turn = @player_1
	end		



	def move_piece
		@board.empty_cell(@board.board[7][1]) #try to move this to board class? so that only thing that is input is coordinates.
		@board.update_cell(@board.board[5][2], 5)
		@board.draw_board
	#there needs to be something in the method that converts address? 
	end	

	

	def play_game
		game_over = false
		until game_over
		puts "#{@player_turn.player_name} Input your choice"
		choice = get_choice
		move = convert_choice(choice)  #get rid of this so I can get rid of convert choice method from this page
		#will have to send over a1a3 etc to update board method and it can be converted over there.
		@board.update_board(@board.board[move[2]][move[3]], @board.board[move[0]][move[1]])
		switch_player
		@board.draw_board
		end
	end
	
	def get_choice
		move_choice = gets.downcase.chomp
		
		if correct_length(move_choice) == false
			puts "Incorrect input! Please only input 4 characters eg. A6A5"
			move_choice = get_choice
		elsif valid_input(move_choice) == false
			puts "Invalid input - please use the format B3H5"
			move_choice = get_choice
		elsif @board.valid_move(move_choice, @player_turn.color) == false #this method will be a number of methods that give 
				#there own reasons for the invalid input.
			move_choice = get_choice	
		#elsif players_piece(move_choice) == false    #this should be in board class
		#	puts "You don't have a piece on that square!"
		#	move_choice = get_choice
		#elsif land_on_own_piece(move_choice) == false  #so should this!
		#	puts "You can't move there, you already have a piece on that square."
		#	move_choice = get_choice		
		end
			move_choice
	end	

	def correct_length(input)
		input.size == 4 ? true : false
	end	 


	def valid_input(input)
		choice_array = input.split('')
		if letters_ok(choice_array[0], choice_array[2]) ==false
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

		if letter_coords.include? a && b 
			true
		else
			false
		end
	end

	def numbers_ok(a, b)	
		number_coords = ['1','2','3','4','5','6','7','8']

		if  number_coords.include? a && b
			true
		else
			false	
		end			 
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

=begin
	 #method to check that square selected has one of the players pieces on it.
	def players_piece(choice)
		coordinates = convert_choice(choice)
		x = coordinates[0]
		y = coordinates[1]
		@board.board[x][y].piece_color == @player_turn.color ? true : false
	end	

		#method to check that square player wants to move to doesn't have one of his pieces already there
		#this could be included in the valid move method when created as I will also have to check if the route
		#to the square is clear.
	def land_on_own_piece(choice)
		coordinates = convert_choice(choice)
		x = coordinates[2]
		y = coordinates[3]
		@board.board[x][y].piece_color == @player_turn.color ? false : true
	end	

=end
	def switch_player
		if @player_turn == @player_1
			@player_turn = @player_2
		else
			@player_turn = @player_1
		end
	end





end	


bob = Game.new
bob.create_players
bob.new_game

bob.play_game
bob.play_game	

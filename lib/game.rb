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

	def play_game
		game_over = false
		until game_over
		puts "#{@player_turn.player_name} Input your choice"
		choice = get_choice
		@board.update_board(choice)
		switch_player
		@board.draw_board
		end
	end
	
	def get_choice
		move_choice = gets.downcase.chomp
		
		#if correct_length(move_choice) == false
		#	puts "Incorrect input! Please only input 4 characters eg. A6A5"
		#	move_choice = get_choice
	#	if valid_input(move_choice) == false
	#		puts "Invalid input - please use the format B3H5"
	#		move_choice = get_choice
		if @board.valid_move(move_choice, @player_turn.color) == false #this method will be a number of methods that give 
				#there own reasons for the invalid input.
			move_choice = get_choice		
		end
			move_choice
	end	

=begin
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
	

#new_position = [x.square, y].transpose.map { |y| y.reduce(:+)} 



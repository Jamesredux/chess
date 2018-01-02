require_relative 'board'

class Game

	def new_game
		@board = BoardClass.new
		@board.draw_board


	end	

	def move_piece
		@board.empty_cell(@board.board[7][1]) #try to move this to board class? so that only thing that is input is coordinates.
		@board.update_cell(@board.board[5][2], 5)
		@board.draw_board
	#there needs to be something in the method that converts address? 
	end	

	def play_game
		puts "input your choice"
		choice = get_choice
		
	end
	
	def get_choice
		move_choice = gets.downcase.chomp
		
		if correct_length(move_choice) == false
			puts "Incorrect input! Please only input 4 characters eg. A6A5"
			move_choice = get_choice
		elsif valid_input(move_choice) == false
			puts "Invalid input - please use the format B3H5"
			move_choice = get_choice
		end

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













end	


bob = Game.new
bob.new_game
bob.move_piece
bob.play_game
bob.play_game

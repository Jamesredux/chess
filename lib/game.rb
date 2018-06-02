require_relative 'board'
require_relative 'player'
require_relative 'chess'
require_relative 'load'
require "yaml" 

class Game

	include Chess
	include Load
	attr_accessor :player_turn, :board

	def start_chess 
		puts "Welcome to chess, please select N for a new game, C to play the computer or L to load a previous game."

		choice = gets.chomp.downcase
		if choice == 'n'
			new_game
		elsif choice == 'c'
			new_computer_game	
		elsif choice == 'l'
			start_loading
		else
			puts "I didn't understand that choice"
			start_chess
		end	
	end	



	def new_game
		create_players
		@board = Board.new
		@board.draw_board
		@game_over = false
		play_chess
	end

	def new_computer_game
		create_player_computer
		@board = Board.new
		@board.draw_board
		@game_over = false
		play_chess
	end


		
	def play_chess
		all_available_moves(@player_turn.color)
		until @game_over
			play_game
		end		
	end

	def play_game
		player_greeting
		if @player_turn.computer ==  true 
			move = get_computer_move
		else	
			player_choice = get_choice #skip this if computer put computer move in player move?
				if player_choice == 'r'
					resign_game
				elsif player_choice == 's'
					save_game
				else 
					move = convert_choice(player_choice)
				end	
			end	
			player_move(move)
			@board.clean_board(@player_turn.color) #this removes enpassant tags at the moment
			switch_player
			@board.draw_board
			status_check
		

	end

	def player_greeting
		if @player_turn.computer == true
			puts "The computer is making his move."
		elsif @player_turn.in_check == false 
			puts "#{@player_turn.player_name} Input your choice or press 'R' to resign or 'S' to save"
		else
			puts "******#{@player_turn.player_name} IS IN CHECK****** \n#{@player_turn.player_name} Input your choice or press 'R' to resign or 'S' to save"
		end	
	end



	def player_move(coordinates)
			#coordinates = convert_choice(player_choice)
			vertical_move =  (coordinates[0] - coordinates[2]).abs
			old_cell = @board.grid[coordinates[0]][coordinates[1]]
			new_cell = @board.grid[coordinates[2]][coordinates[3]]
			@board.update_board(coordinates, old_cell, new_cell)
			if new_cell.piece.instance_of?(Pawn) && vertical_move == 2
				@board.enpassant_check(coordinates, old_cell, new_cell, @player_turn.color)
			elsif new_cell.piece.instance_of?(Pawn) && @board.last_row(coordinates)
				@board.promote(new_cell)
			end	
	end

	def get_choice

			player_input = gets.downcase.chomp
				if player_input == 'r'
		 		player_input
				elsif player_input == 's'
				player_input	
				elsif correct_input(player_input, @player_turn.color) == false 
				player_input = get_choice		
				elsif legal_move(player_input, @player_turn.color) == false
				player_input = get_choice 
			end
				player_input		
	end	


	def status_check
		if in_check?(@player_turn.color) && @sum_of_moves == 0
				checkmate
		elsif @sum_of_moves == 0
				stalemate		
		elsif in_check?(player_turn.color)
				@player_turn.in_check = true		
		end		
	end

	def stalemate
			puts "Stalemate #{player_turn.player_name} has no legal moves the game ends in a draw."	
			@game_over = true
	end

	def checkmate
		@player_turn.color == 'black' ? winning_color = 'white' : winning_color = 'black'
		puts "CHECKMATE #{player_turn.player_name} cannot escape #{winning_color} is the winner"
		@game_over = true
		
	end

	def resign_game
		puts "Are  you sure you wish to resign, press 'Y' to confirm resignation or any other key to continue playing"
		confirmation = gets.downcase.chomp
			if confirmation == 'y'
				@player_turn.color == 'black' ? winning_color = 'white' : winning_color = 'black'
				puts "#{@player_turn.player_name} has resigned #{winning_color} is the winner."
				@game_over = true
			end
	end

	def save_game
		prog_string = "Chess Game" #may change this, give player option to name game.
		
		saved_data = YAML::dump(self)

		Dir.mkdir("saves") unless Dir.exists?("saves")

		puts "saving game.."
		filename = "saves/<>#{prog_string}<>#{Time.now.strftime('%d-%m-%y_%H:%M')}.yaml"  
		File.open(filename, "w") do |file|
			file.puts YAML::dump(self)

		end 

		puts "Game Saved. If You wish to quit press 'Q', any other key to continue playing."
		choice = gets.downcase.chomp
		if choice == 'q'
			@game_over = true
		end	

	end

	def start_loading
			@save_names = []
			@save_id = 1
			list_saves
			get_load_choice
		end

	def list_saves
		puts "List of Saved Games:"
			Dir.glob("./saves/*").each do |file|
				@save_names<<file 
				file = file[8..-6]
					puts "Save Number #{@save_id} #{file}"
					@save_id += 1
			end
			
		if @save_id == 1
		puts "*****************"
		puts "There are no saved games. Hit the 'N' key to start a new game."
		puts "*****************"

		end	
				
	end

	def get_load_choice
		puts "Please choose which game you would like to load (number), or type \"N\" for a new game or \"D\" to delete all your saved games:"
		
		choice = gets.chomp
		
		if choice.downcase == "n"  
			new_game
		elsif choice.downcase == "d"	
			delete_saves	
		elsif choice.to_i.between?(1, @save_id-1)	
			load_game(@save_names, choice)	
		else
			puts "Sorry, I didn't understand that:"
			choice = get_load_choice
		end				

	end



	
end	


#to auto start
game = Game.new
game.start_chess






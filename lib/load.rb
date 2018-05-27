require_relative 'board'

	module Load

	def load_game(save_names, game_choice) 
		puts "Loading save number #{game_choice} please wait:\n"
		game_choice = game_choice.to_i
					
		file_index = game_choice - 1
		file_name = find_file(save_names, file_index)
		puts file_name
		puts "Welcome Back\n\n" 
			
			loaded_game = YAML::load(File.open(file_name))

		loaded_game.board.draw_board
		loaded_game.play_chess

	end

	def find_file(save_names, file_index)
		save_names.each_with_index do |value, index|
			if index == file_index
				return value
			end
		end
		
	end

	def delete_saves
		puts "Are you sure you want to delete all files, this can not be undone: Confirm 'Y' to delete \n or any other key to continue: "
			confirm_choice = gets.downcase.chomp
				if confirm_choice == "y"
					Dir.glob("./saves/*").each do |file|
					File.delete(file)
					end
				else
					choice = get_load_choice
				end
			puts ""
	end		

end	

module Draw

	TOP_LINE = "\u2554\u2550\u2550\u2566\u2550\u2550\u2566\u2550\u2550\u2566\u2550\u2550\u2566\u2550\u2550"\
  						"\u2566\u2550\u2550\u2566\u2550\u2550\u2566\u2550\u2550\u2557"

  BOTTOM_LINE = "\u255A\u2550\u2550\u2569\u2550\u2550\u2569\u2550\u2550\u2569\u2550\u2550\u2569"\
								"\u2550\u2550\u2569\u2550\u2550\u2569\u2550\u2550\u2569\u2550\u2550\u255D"

	INTER_LINE =	"\u2560\u2550\u2550\u256C\u2550\u2550\u256C\u2550\u2550\u256C\u2550"\
							"\u2550\u256C\u2550\u2550\u256C\u2550\u2550\u256C\u2550\u2550\u256C\u2550\u2550\u2563" 								


 	def draw_board
   	puts TOP_LINE

		(0..6).each do |x|
			create_row(@board[x])
			puts INTER_LINE
		end
			create_row(@board[7])
			puts BOTTOM_LINE
	end

	def create_row(array)
		row = []
			array.each do |x|
				row<< x.symbol
			end
		puts "\u2551#{row[0]} \u2551#{row[1]} \u2551#{row[2]} \u2551#{row[3]} "\
				 "\u2551#{row[4]} \u2551#{row[5]} \u2551#{row[6]} \u2551#{row[7]} \u2551"		
	end	 	

end



	
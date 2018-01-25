
module Draw

	TOP_LINE = "  \u2554\u2550\u2550\u2566\u2550\u2550\u2566\u2550\u2550\u2566\u2550\u2550\u2566\u2550\u2550"\
  						"\u2566\u2550\u2550\u2566\u2550\u2550\u2566\u2550\u2550\u2557"

  BOTTOM_LINE = "  \u255A\u2550\u2550\u2569\u2550\u2550\u2569\u2550\u2550\u2569\u2550\u2550\u2569"\
								"\u2550\u2550\u2569\u2550\u2550\u2569\u2550\u2550\u2569\u2550\u2550\u255D"
								
	LETTERS_LABLE =	"   A  B  C  D  E  F  G  H"

	INTER_LINE =	"  \u2560\u2550\u2550\u256C\u2550\u2550\u256C\u2550\u2550\u256C\u2550"\
							"\u2550\u256C\u2550\u2550\u256C\u2550\u2550\u256C\u2550\u2550\u256C\u2550\u2550\u2563" 								


 	def draw_board
 		puts LETTERS_LABLE
   	puts TOP_LINE

		(0..6).each do |x|
			row_number = row_convert(x)
			create_row(@grid[x], row_number)
			puts INTER_LINE
		end
			create_row(@grid[7], 1)
			puts BOTTOM_LINE
			puts LETTERS_LABLE
	end

	def create_row(array, row_number)
		row = []
			array.each do |x|
				row<< x.symbol
			end
		puts "#{row_number} \u2551#{row[0]} \u2551#{row[1]} \u2551#{row[2]} \u2551#{row[3]} "\
				 "\u2551#{row[4]} \u2551#{row[5]} \u2551#{row[6]} \u2551#{row[7]} \u2551"		
	end	 	


	def row_convert(x)
		new_num = 8 - x 
		new_num
	end
end



	

#cell_1, cell_8 = "\u265C","\u265C"
#cell_2, cell_7 = "\u265E","\u265E"
#cell_3, cell_6 = "\u265D","\u265D"
#cell_4 = "\u265B"
#cell_5 = "\u265A"

#array_0 = ["\u265C", "\u265E", "\u265D", "\u265B", "\u265A", "\u265D", "\u265E", "\u265C"]


#row = [cell_1, cell_2, cell_3, cell_4, cell_5, cell_6, cell_7, cell_8]



row = ["\u265C", "\u265E", "\u265D", "\u265B", "\u265A", "\u265D", "\u265E", "\u265C"]


def draw_row
	
	#row = [1, 2, cell3, cell_4, cell_5, cell_6, cell_7, cell_8]
	array_index = 0
	y = 1
	row = []
	(1..8).each do |x|
		"cell_" + x.to_s = array_0[array_index]
		row << var
		array_index += 1
		y += 1
	end
end



puts "\u2551#{row[0]} \u2551#{row[1]} \u2551#{row[2]} \u2551#{row[3]} "\
		 "\u2551#{row[4]} \u2551#{row[5]} \u2551#{row[6]} \u2551#{row[7]} \u2551"


def draw_board
	@board.each do |x|
		create_row(x)
	end

def create_row(array)
	row = []
	array.each do |x|
		row<< x.symbol
	end
		puts "\u2551#{row[0]} \u2551#{row[1]} \u2551#{row[2]} \u2551#{row[3]} "\
		 "\u2551#{row[4]} \u2551#{row[5]} \u2551#{row[6]} \u2551#{row[7]} \u2551"
end	 	
					 

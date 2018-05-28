
require "./lib/cell"

describe Cell do 
	cell_1 = Cell.new
	context "initialized cell" do 
		it "has a space for a symbol" do 
			expect(cell_1.symbol).to eql(" ")
		end	
	end
end	
	

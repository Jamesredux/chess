Chess 

This is my solution to the Chess problem in the odin project.

How the game works

There is a board class that creates the board, this is an array of 8 rows, each row has 8 cells. The cell class contains the piece and the symbol and enpassent information.

The piece is it's own class and in this object we store the moves the piece can take and the 'take moves' it can execute (for when playing the computer).

At the start of each move the 'all available moves' method is run, this goes through all the pieces of the color that is about to move and stores in each piece class the moves that that piece can make.

If the move would leave the color in check than it is not a valid move and is not stored in the 'moves' array. As a result, if the player is already in check when the all available moves method is calls. It only stores moves that would take the player out of check. If there are none, then the number of moves is zero and the player is in checkmate. If the number of available moves is zero but the player is not in check then the game is a stalemate draw.

I have  not implemented the rule about a draw through threefold repition or the 50 move draw rule. 


When the player choses a move the computer first checks that it is a valid input. Then it checks if the move is one of the players available moves. If it is not it returns invalid move, if it is it makes the move.

Castling, enpassent and pawn promotion are all included.

Computer


The computer is basic ai. 
It creates a new player class, when it is the computers moves it first searches for any available
opportunites to take an opposition piece. If there are any it chooses one at random. If there  are none 
then it chooses one of the other available moves at random.

##

Things that still need to be done.

Announce when computer is in check
Make possible to label saved games
Make clearer what move computer has made 
Have checkerboard show up in terminal

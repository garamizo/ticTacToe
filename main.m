% main file, for random minded players
%     create game
%     while all( game status == nothing )
%         for each player i
%             moves = moves available (i)
%             move = moves( random )
%             apply move( move, i )
%     print winner

clear; clc

game = TicTacToe();
while isempty( game.winner )
    
    movesAvail = game.getMovesAvailable();
    
    move = TicTacToe.randomMove( movesAvail );
    [game, nextPlayer] = game.makeMove( move );
    
    game.print();
    
    pause(0.2)
end

if game.winner == 0
    disp('Game ended in a tie!');
else
    disp(['Winner is player ' num2str(game.winner)])
end
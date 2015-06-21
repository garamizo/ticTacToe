
clear

global count
count = 0;

game = TicTacToe();
nextPlayer = 1;

[game, nextPlayer] = game.makeMove( 2, 1 );
[game, nextPlayer] = game.makeMove( 2, 2 );
[game, nextPlayer] = game.makeMove( 2, 1 );
[game, nextPlayer] = game.makeMove( 3, 2 );
[game, nextPlayer] = game.makeMove( 3, 1 );
[game, nextPlayer] = game.makeMove( 4, 1 );
game.print
tic
moveK = game.expertMove3( 2 )
toc
%game.checkMove( 1, 4 )

%%

while isempty( game.winner )
    
    if nextPlayer == 1
        moveK = game.expertMove3( nextPlayer );
        %score
    else
        moveK = game.expertMove( nextPlayer );
    end
    
    %move = game.expertMove2( nextPlayer );
    if isempty( moveK )
        print('Stalemate!')
        break
    end

    [game, nextPlayer] = game.makeMove( moveK, nextPlayer );
    
    game.print();
    pause(0.2)
end

if game.winner == 0
    disp('Game ended in a tie!');
else
    disp(['Winner is player ' num2str(game.winner)])
end
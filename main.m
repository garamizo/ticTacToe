
clear

game = TicTacToe();
nextPlayer = 1;

while isempty( game.winner )
    
    if nextPlayer == 1
        moveK = game.expertMove( nextPlayer );
    else
        moveK = game.userMove(  );
    end
    
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
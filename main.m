% main file, for random minded players
%     create game
%     while all( game status == nothing )
%         for each player i
%             moves = moves available (i)
%             move = moves( random )
%             apply move( move, i )
%     print winner

game = TicTacToe.create();
while isempty( game.state.winner )
    for k = 1 : length( game.player )
        moves = game.getMovesAvailable( k );
        idx = randi(length(moves));
        game = game.makeMove( moves(idx), k );
        game.disp();
    end
end

if game.state.winner == 0
    disp('Game ended in a tie!');
else
    disp(['Winner is player ' num2str(game.state.winner)])
end
function mainGUI

f = figure( 'Visible', 'off', 'Position', [-500 100 190 220] );

nextPlayer = 1;
while true
    for i = 1 : 3
        for j = 1 : 3
            buttons(i,j) = uicontrol( 'Style', 'pushbutton', 'String', '', ...
                'Position', [10+(j-1)*60 220-(30+i*60) 50 50], ...
                'Callback', {@buttonCallback} );
        end
    end
    
    text = uicontrol( 'Style', 'Text', 'String', ['Player ' num2str(nextPlayer) ' turn'], ...
        'Position', [10 220-30 170 20] );

    game = TicTacToe();

    f.Visible = 'on';
    
    while isempty( game.winner )
        pause(0.5)
        if nextPlayer == 2 && isempty( game.winner )
            computerMove();
        end
        if ~ishandle(f)
            return
        end
    end
    
    if game.winner == 0
        text.String = 'Its a tie!';
    else
        text.String = ['Player ' num2str(game.winner) ' wins'];
    end
    pause(1)
    
    f.Visible = 'off';
end

    function buttonCallback( source, event )
        [row,col] = find( source == buttons );
        
        for k = 1 : size( game.moves, 1 )
            if all( [row col] == game.moves(k,:) )
                source.String = 'X';
                [game, nextPlayer] = game.makeMove( k, nextPlayer );
                break
            end
        end
        text.String = ['Player ' num2str(nextPlayer) ' turn'];
    end

    function computerMove()
        moveK = game.expertMove( nextPlayer );
        if ~isempty( moveK )
            buttons(game.moves(moveK,1),game.moves(moveK,2)).String = 'O';
            [game, nextPlayer] = game.makeMove( moveK, nextPlayer );
            text.String = ['Player ' num2str(nextPlayer) ' turn'];
        end
    end
end

classdef TicTacToe
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        matrix
        winner
        player
        lastPlayer
    end
    
    methods (Static)
        function move = expertMove( moves )
            move = moves(1);
        end
        
        function move = randomMove( moves )
            idx = randi(length(moves));
            move = moves(idx);
        end
    end
    
    methods
        function obj = TicTacToe()
            obj.matrix = zeros(3);
            obj.winner = [];
            obj.player(1).marker = 1;
            obj.player(2).marker = 2;
            obj.lastPlayer = 0;
        end
            
        function moves = getMovesAvailable( obj )
            
            [rows,cols] = find( obj.matrix == 0 );
            
            if ~isempty( obj.winner )
                moves = [];
                return;
            end
            
            nextPlayer = (obj.lastPlayer == 1 ) + 1;
            moves = struct( 'i', num2cell(rows), 'j', num2cell(cols), 'marker', nextPlayer );
            
            if obj.lastPlayer == 0
                moves2 = moves;
                [moves2.marker] = deal(2);
                moves = [moves; moves2];
            end
        end
        
        function [gamepp, nextPlayer] = makeMove( obj, move )
            gamepp = obj;
            gamepp.matrix( move.i, move.j ) = move.marker;
            
            nextPlayer = (move.marker == 1 ) + 1;
            
            A = gamepp.matrix;
            m = obj.player(move.marker).marker;
            
            if all( A(:,1) == m ) || all( A(:,2) == m ) || all( A(:,3) == m ) ||...
               all( A(1,:) == m ) || all( A(2,:) == m ) || all( A(3,:) == m ) || ...
               all( diag(A) == m ) || all( diag(fliplr(A)) == m )
                gamepp.winner = move.marker;
            elseif all( A ~= 0 )
                gamepp.winner = 0;
            end
        end
        
        function print( obj )
            disp( obj.matrix )
        end
    end
    
end


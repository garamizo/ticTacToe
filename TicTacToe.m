classdef TicTacToe
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        winner
    end
        
    properties
        matrix
        lastPlayer
        moves
    end
    
    methods
        function obj = TicTacToe()
            obj.matrix = zeros(3);
            obj.winner = [];
            obj.lastPlayer = 0;
            
            [rows,cols] = find( obj.matrix == 0 );
            obj.moves = [rows cols];
        end
        
        function [gamepp, nextPlayer] = makeMove( obj, moveK, playerK )
            
            gamepp = obj;
            gamepp.matrix( obj.moves(moveK,1), obj.moves(moveK,2) ) = playerK;
            gamepp.lastPlayer = playerK;
            
            nextPlayer = (playerK == 1 ) + 1;
            
            % Check if game has ended
            A = gamepp.matrix;
       
            % a winner
            if any( all( A == playerK, 1 ) ) || any( all( A == playerK, 2 ) ) || ...
               all( [A(1,1) A(2,2) A(3,3)] == playerK ) || all( [A(3,1) A(2,2) A(1,3)] == playerK )
                gamepp.winner = playerK;
            elseif all( A ~= 0 ) % stalemate
                gamepp.winner = 0;
            end
            
            gamepp.moves( moveK, : ) = [];
        end
        
        function print( obj )
            disp( obj.matrix )
        end
        
        function score = checkMove( obj, me, moveK )
            
            [gameP1, him] = makeMove( obj, moveK, me );
            if gameP1.winner == me
                score = 1;
                return
            end
            
            if isempty( gameP1.moves )
                score = 0;
                return
            end
            
            hisScores = zeros( [ size( gameP1.moves, 1 ) 1 ] );
            for hisMove = 1 : size( gameP1.moves, 1 )
                scoreHim = checkMove( gameP1, him, hisMove );
                if scoreHim == 1
                    score = -1;
                    return
                end
                hisScores(hisMove) = scoreHim;
            end
            if any( hisScores == 0 )
                score = 0;
            else
                score = 1;
            end
        end
        
        function moveK = expertMove( obj, me )
            
            if size( obj.moves, 1 ) == 9 % Too many options
                moveK = randi( 9 );
                return
            elseif isempty( obj.moves ) % Too few options
                moveK = [];
                return
            end
            
            scores = zeros( [ size( obj.moves, 1 ) 1 ] );
            for k = 1 : size( obj.moves, 1 )
                scores(k) = obj.checkMove( me, k );
            end

            % propagate scores
            if any( scores == 1 )
                idx = find( scores == 1 );
            elseif any( scores ~= -1 )
                idx = find( scores ~= -1 );
            else
                idx = obj.moves;
            end
            
            moveK = idx( randi(length(idx)) );
        end
        
        function [moveK, joy] = smartMove( obj, me )

            if isempty( obj.moves )
                moveK = [];
                joy = 0;
                return
            end

            scores = zeros( [ size( obj.moves, 1 ) 1 ] );
            
            for k1 = 1 : size( obj.moves, 1 )
                [gameP1, other] = obj.makeMove( k1, me );
                if gameP1.winner == me % instant win
                    scores(k1) = 2;
                    continue
                end

                for k2 = 1 : size( gameP1.moves, 1 )
                    gameP2 = gameP1.makeMove( k2, other );
                    if gameP2.winner == other % next lose, defend
                    	scores(k1) = -2;
                        break
                    end
                end
            end
            
            % choose one of the best
            for grade = [2 1 0 -1 -2]
                len = sum( scores == grade );
                if len > 0
                    goodK = find( scores == grade );
                    moveK = goodK(randi(length(goodK)));
                    joy = grade;
                    return
                end
            end
        end
        
        function moveK = randomMove( obj )

            if ~isempty( obj.moves )
                idx = randi( size( obj.moves, 1 ) );
                moveK = idx;
            else
                moveK = [];
            end
        end
        
        function moveK = userMove( obj )

            n = 0;
            while n < 1 && n <= size( obj.moves, 1 )
                n = round( input( ['Enter "n" (1-' num2str(size( obj.moves, 1 )) '): '] ) );
            end
            
            moveK = n;
        end
            
    end
    
end


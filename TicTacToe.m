classdef TicTacToe
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        state
        player
    end
    
    methods
        function obj = TicTacToe()
            obj.state.matrix = zeros(3);
            obj.state.winner = [];
            player(1).marker = 1;
            player(2).marker = 2;
        end
            
        function moves = getMovesAvailable( obj, playerIdx )
            moves = [];
        end
        
        function gamepp = makeMove( obj, move, playerIdx )
            gamepp = obj;
        end
        
        function disp( obj )
        end
    end
    
end


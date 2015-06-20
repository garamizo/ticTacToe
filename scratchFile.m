% Scratch file

class game:
    const properties
        struct moves
    properties
        struct state
        array struct players
    method
        moves available (player i), returns array of moves
        game status, returns array of typedef victory
        apply move (move m, player i)
        
        
main file, for random minded players
    create game
    while all( game status == nothing )
        for each player i
            moves = moves available (i)
            move = moves( random )
            apply move( move, i )
    print winner
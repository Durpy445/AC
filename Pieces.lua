local Template = {
    Name = nil,
    MovementMatrix = nil,
    Moves = nil,
    Weight = nil,
}

local Pieces = {
    Knight = {
        Name = "Knight",
        MovementMatrix = nil,
        Moves = {
            { -1, 2 },
            { 1,  2 },
            { -2, 1 },
            { 2,  1 },
            { -1, -1 },
            { 1,  -1 },
            { -2, -2 },
            { 2,  -2 },
        },
        Weight = 4
    },

    King = {
        Name = "King",
        MovementMatrix = {
            { 1, 1, 1 },
            { 1, 9, 1 },
            { 1, 1, 1 },
        },
        Moves = nil,
        Weight = 9,
    },

    Rook = {
        Name = "Rook",
        MovementMatrix = {
            { 0, 2, 0 },
            { 2, 9, 2 },
            { 0, 2, 0 }
        },
        Moves = nil,
        Weight = 7,
    },

    Queen = {
        Name = "Queen",
        MovementMatrix = {
            { 2, 2, 2 },
            { 2, 9, 2 },
            { 2, 2, 2 }
        },
        Moves = nil,
        Weight = 8,
    },

    Bishop = {
        Name = "Bishop",
        MovementMatrix = {
            { 2, 0, 2 },
            { 0, 9, 0 },
            { 2, 0, 2 }
        },
        Moves = nil,
        Weight = 6,
    },

    Pawn = {
        Name = "Pawn",
        MovementMatrix = {
            { 3 },
            { 9 },
            { 4 },
        },
        Moves = nil,
        Weight = 1,
    },

}
return Pieces

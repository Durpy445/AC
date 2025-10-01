local Templates = {
    TileTemplate = {
        Piece = nil,
        TileID = nil,
        Position = {},
        SquarebuildList = {}
    },

    TeamLookup = {
        "White",
        "Black"
    },

    PieceLookup = {
        K = "King",
        R = "Rook",
        H = "Knight",
        B = "Bishop",
        Q = "Queen",
        P = "Pawn"
    },

    PieceTemplate = {
        Position = { nil, nil },
        PieceID = nil,
        Team = nil,
        Effects = {},
        PieceType = nil,
    },

    TeamTemplate = {
        Pieces = {},
        LoseCondition = nil,
        Players = nil,
    },

    PlayerTemplate = {
        Team = nil,
        PlayerID = nil,
        PiecePossesing = nil,
    },

    SquarebuildTemplate = {
        SquareBuildID = nil,
        Name = nil,
        SquarebuildType = nil,
        Data = {}
    },

    SquarebuildTypeTemplate = {
        Type = nil,
        SquarebuildFunction = nil
    },


    ModifierTemplate = {
        StartingFunction = nil,
        TurnFunction = nil,
        Intensity = nil,
        GenerationFunction = nil,
    },

    EventTemplate = {
        EventFunction = {}
    },

    BoardTemplate = {
        LayoutFunction = nil,
        ForcedLayout = nil,
    },

    VoteTemplate = {
        PlayerID = "Empty",
        Type = "Empty",
    },
}
return Templates

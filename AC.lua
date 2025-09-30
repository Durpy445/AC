local Board = {
    BoardSize = { nil, nil },
    TurnNumber = nil,
    AmountOfTeams = nil,
    TeamsTurn = nil,
    MofifierAmount = nil,
    NewEventChance = nil,
    MaxEvents = nil,
    Teams = {

    },
    Tiles = {},
    AllTiles = {},
    Dictionary = {
        PieceList = {
            AllPieces = {},
            PiecesWithEffects = {},
        },
        Players = {

        },
        SquarebuildList = {

        }
    },
    Events = {
        EventQueue = {
            Admin = {

            },
            Robux = {},
            Tix = {},
            Random = {},
        }
    },
    Modifiers = {

    },

    Votes = {

    },
    ChangeLog = {}
}
local Basics = require("Basics")
local Generators = require("Generators")

Board.Tiles = Generators.FormatTable(Board, require("Boards").Deafult, { 8, 8 })
for index, Piece in ipairs(Generators.GetAllPieces(Board)) do
    Generators.RemovePiece(Board, Piece.PieceID)
end
print(Basics.dump(Generators.GetAllTiles(Board)))

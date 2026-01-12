local Board = {
    BoardSize = { nil, nil },
    TurnNumber = nil,
    AmountOfTeams = nil,
    TeamsTurn = nil,
    MofifierAmount = nil,
    NewEventChance = nil,
    MaxEvents = nil,
    IDs = {},
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
            AllSquarebuilds = {},
            TimedSquarebuilds = {}
        }
    },
    Events = {
        EventQueue = {
            Admin = {},
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

Generators.FormatTable(Board, require("Boards").Deafult, { 8, 8 })
Generators.AddEvent(Board, require("Events").AddTripmine)
--print(Basics.dump(Board))
--print(Basics.dump(Board.ChangeLog))
Generators.RunNextEvent(Board)
for index, value in pairs(Board.ChangeLog) do
    print("z", Basics.dump(value))
    print(Basics.dump(Generators.LogToNotation(value)))
end

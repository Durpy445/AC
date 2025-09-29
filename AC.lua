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
    Dictionary = {
        PieceList = {
            Teams = {
                Empty = {}
            },
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



Board.Tiles = Generators.FormatTable(require("Boards").Deafult, { 8, 8 })

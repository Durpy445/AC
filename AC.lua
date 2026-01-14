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
Generators.RunNextEvent(Board)
Generators.AddEvent(Board, require("Events").AddTripmine)
Generators.RunNextEvent(Board)
Generators.AddEvent(Board, require("Events").AddTripmine)
Generators.RunNextEvent(Board)
Generators.AddEvent(Board, require("Events").AddTripmine)
Generators.RunNextEvent(Board)
Generators.AddEvent(Board, require("Events").AddTripmine)
Generators.RunNextEvent(Board)
Generators.AddEvent(Board, require("Events").AddTripmine)
Generators.RunNextEvent(Board)
Generators.AddEvent(Board, require("Events").AddTripmine)
Generators.RunNextEvent(Board)

for index, value in pairs(Board.ChangeLog) do
end

local String = ""

for index, value in ipairs(Board["Tiles"]) do
    for index, value in ipairs(value) do
        local Squarebuild = Basics.RandomFromTable(value["SquarebuildList"])
        if value["Piece"] then
            String = String .. string.sub(value["Piece"]["PieceType"]["Name"], 1, 1)
        elseif Squarebuild ~= nil then
            String = String .. string.sub(Squarebuild["SquarebuildType"], 1, 1)
        else
            String = String .. " "
        end
    end
    String = String .. "\n"
end

print(String)

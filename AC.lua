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
local Pieces = require("Pieces")
local Templates = require("Templates")
local Basics = require("Basics")
local PieceLookup = {
    K = "King",
    R = "Rook",
    H = "Knight",
    B = "Bishop",
    Q = "Queen",
    P = "Pawn"
}
local TeamLookup = {
    "White",
    "Black"
}

local BoardTemplate = Templates.BoardTemplate
local PieceTemplate = Templates.PieceTemplate

local function FormatTable(PassedTable, Size)
    local New = {}
    local Forced = PassedTable.ForcedLayout
    if PassedTable.LayoutFunction ~= nil then
        local LayoutFunction = PassedTable.LayoutFunction
        Forced = LayoutFunction(Size)
    end


    local Y = Size[1]
    local X = Size[2]
    for i = 1, X, 1 do
        Row = {}
        for i = 1, Y, 1 do
            table.insert(Row, Basics.shallow_copy(Templates.TileTemplate))
        end
        table.insert(New, Row)
    end

    for y, value in ipairs(Forced) do
        for x, Small in ipairs(value) do
            local PieceName = PieceLookup[Small[1]]
            local Team = TeamLookup[Small[2]]
            local Piece = Basics.shallow_copy(PieceTemplate)
            Piece.Location = { y, x }
            Piece.Team = Team
            Piece.PieceType = Pieces[PieceName]
            print(Piece.PieceType)
            New[y][x].Piece = Piece
        end
    end
    return New
end


Board.Tiles = FormatTable(require("Boards").Deafult, { 8, 8 })
print(Basics.dump(Board.Tiles[1][1]))

local Generators = {}

local Pieces = require("Pieces")
local Templates = require("Templates")
local Basics = require("Basics")
local PieceLookup = Templates.PieceLookup
local TeamLookup = Templates.TeamLookup

local BoardTemplate = Templates.BoardTemplate
local PieceTemplate = Templates.PieceTemplate


Generators.FormatTable = function(PassedTable, Size)
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
            New[y][x].Piece = Piece
        end
    end
    return New
end
return Generators

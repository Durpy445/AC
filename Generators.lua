local Generators = {}

local Pieces = require("Pieces")
local Templates = require("Templates")
local Basics = require("Basics")
local PieceLookup = Templates.PieceLookup
local TeamLookup = Templates.TeamLookup

local BoardTemplate = Templates.BoardTemplate
local PieceTemplate = Templates.PieceTemplate


Generators.FormatTable = function(Board, PassedTable, Size)
    local New = {}
    local Forced = PassedTable.ForcedLayout
    if PassedTable.LayoutFunction ~= nil then
        local LayoutFunction = PassedTable.LayoutFunction
        Forced = LayoutFunction(Size)
    end


    local Y = Size[1]
    local X = Size[2]
    for x = 1, X, 1 do
        Row = {}
        for y = 1, Y, 1 do
            local Tile = Basics.shallow_copy(Templates.TileTemplate)
            Tile.TileID = Generators.GenerateID()
            Tile.Position = { x, y }
            table.insert(Row, Tile)
            Board.AllTiles[Tile.TileID] = Tile
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
            Piece.PieceID = Generators.GenerateID()
            New[y][x].Piece = Piece
            Generators.AddPieceToLists(Board, Piece)
        end
    end
    return New
end

Generators.GenerateID = function()
    return math.random(1, 15215254)
end

Generators.AddPieceToLists = function(Board, Piece)
    Board.Dictionary.PieceList.AllPieces[Piece.PieceID] = Piece

    if Board.Teams[Piece.Team] == nil then
        Board.Teams[Piece.Team] = {}
    end

    Board.Teams[Piece.Team][Piece.PieceID] = Piece
end

Generators.GetAllPieces = function(Board)
    return Board.Dictionary.PieceList.AllPieces
end

Generators.GetAllTiles = function(Board)
    return Board.AllTiles
end

Generators.RemovePiece = function(Board, PieceID)
    local Piece = Board.Dictionary.AllPieces[PieceID]
end

Generators.GetAllEmptyTiles = function(Board)
    local AllPieces = Generators.GetAllPieces(Board)
    local AllTiles = Basics.shallow_copy(Board.AllTiles)
    --print(Basics.dump(AllPieces))
    for index, Piece in pairs(AllPieces) do
        local Taken = Piece.Location
        local Tile = Board.Tiles[Taken[1]][Taken[2]]
        AllTiles[Tile.TileID] = nil
    end
    return AllTiles
end





return Generators

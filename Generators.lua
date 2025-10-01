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
            Tile.TileID = Generators.GenerateID(Board)
            Tile.Position = { x, y }
            table.insert(Row, Tile)
            Board.AllTiles[Tile.TileID] = Tile
        end
        table.insert(New, Row)
    end
    Board.Tiles = New
    for y, value in ipairs(Forced) do
        for x, Small in ipairs(value) do
            local PieceName = PieceLookup[Small[1]]
            local Team = TeamLookup[Small[2]]
            local Piece = Basics.shallow_copy(PieceTemplate)
            Piece.Position = { y, x }
            Piece.Team = Team
            Piece.PieceType = Pieces[PieceName]
            Piece.PieceID = Generators.GenerateID(Board)
            Generators.AddPieceToLists(Board, Piece)
        end
    end
end

Generators.GenerateID = function(Board)
    while true do
        local ID = math.random(1, 10000)
        if Board.IDs[ID] == nil then
            Board.IDs[ID] = true
            return ID
        end
    end
end

Generators.AddPieceToLists = function(Board, Piece)
    Board.Dictionary.PieceList.AllPieces[Piece.PieceID] = Piece

    if Board.Teams[Piece.Team] == nil then
        Board.Teams[Piece.Team] = Basics.deep_copy(Templates.TeamTemplate)
    end
    Board.Teams[Piece.Team].Pieces[Piece.PieceID] = Piece
    print(Basics.dump(Board.Tiles))
    Board.Tiles[Piece.Position[1]][Piece.Position[2]].Piece = Piece
end

Generators.GetAllPieces = function(Board)
    return Board.Dictionary.PieceList.AllPieces
end

Generators.GetAllTiles = function(Board)
    return Board.AllTiles
end

Generators.RemovePiece = function(Board, PieceID)
    local Piece = Board.Dictionary.PieceList.AllPieces[PieceID]
    local Tile = Board.Tiles[Piece.Position[1]][Piece.Position[2]]
    Board.Dictionary.PieceList.AllPieces[PieceID] = nil
    Board.Dictionary.PieceList.PiecesWithEffects[PieceID] = nil
    Board.Teams[Piece.Team].Pieces[PieceID] = nil
    if Board.Dictionary.Players[Piece.PlayerID] then
        Board.Dictionary.Players[Piece.PlayerID].PiecePossesing = nil
    end
    Tile.Piece = nil
    Board.IDs[PieceID] = nil
end

Generators.RemoveSquarebuild = function(Board, SquarebuildID)
    local Squarebuild = Board.Dictionary.SquarebuildList.AllSquarebuilds[SquarebuildID]
    Board.Dictionary.SquarebuildList.AllSquarebuilds[SquarebuildID] = nil
    Board.Dictionary.SquarebuildList.TimedSquarebuilds[SquarebuildID] = nil
    local Tile = Board.Tiles[Squarebuild.Position[1]][Squarebuild.Position[2]]
    Tile.SquarebuildList[SquarebuildID] = nil
    Board.IDs[SquarebuildID] = nil
end

Generators.AddSquarebuildToLists = function(Board, Squarebuild)
    Board.Dictionary.AllSquarebuilds[Squarebuild.SquarebuildID] = Squarebuild
    if Squarebuild.SquarebuildType.Type == "Timed" then
        Board.Dictionary.TimedSquarebuilds[Squarebuild.SquarebuildID] = Squarebuild
    end
    local Tile = Board.Tiles[Squarebuild.Position[1]][Squarebuild.Position[2]]
    Tile.SquarebuildList[Squarebuild.SquarebuildID] = Squarebuild
end

Generators.GetAllEmptyTiles = function(Board)
    local AllPieces = Generators.GetAllPieces(Board)
    local AllTiles = Basics.shallow_copy(Board.AllTiles)
    for index, Piece in pairs(AllPieces) do
        local Taken = Piece.Position
        local Tile = Board.Tiles[Taken[1]][Taken[2]]
        AllTiles[Tile.TileID] = nil
    end
    return AllTiles
end





return Generators

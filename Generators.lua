local Generators = {}

local Pieces = require("Pieces")
local Templates = require("Templates")
local SquarebuildTypes = require("SquarebuildTypes")
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
    --print(Basics.dump(Board.Tiles))
    Board.Tiles[Piece.Position[1]][Piece.Position[2]].Piece = Piece
    Generators.GenAddPieceLog(Board, Piece)
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
    Generators.GenRemovePieceLog(Board, Piece)
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
    Generators.GenRemoveSquarebuildLog(Board, Squarebuild)
    Board.Dictionary.SquarebuildList.AllSquarebuilds[SquarebuildID] = nil
    Board.Dictionary.SquarebuildList.TimedSquarebuilds[SquarebuildID] = nil
    local Tile = Board.Tiles[Squarebuild.Position[1]][Squarebuild.Position[2]]
    Tile.SquarebuildList[SquarebuildID] = nil
    Board.IDs[SquarebuildID] = nil
end

Generators.CreateSquarebuild = function(Name)
    local SquarebuildTemplate = Basics.deep_copy(Templates.SquarebuildTemplate)
    SquarebuildTemplate.SquarebuildType = SquarebuildTypes[Name]
    return SquarebuildTemplate
end

Generators.AddSquarebuildToLists = function(Board, Squarebuild)
    if Squarebuild.SquarebuildID == nil then
        Squarebuild.SquarebuildID = Generators.GenerateID(Board)
    end
    Board.Dictionary.AllSquarebuilds[Squarebuild.SquarebuildID] = Squarebuild
    if Squarebuild.SquarebuildType.Type == "Timed" then
        Board.Dictionary.TimedSquarebuilds[Squarebuild.SquarebuildID] = Squarebuild
    end
    local Tile = Board.Tiles[Squarebuild.Position[1]][Squarebuild.Position[2]]
    Tile.SquarebuildList[Squarebuild.SquarebuildID] = Squarebuild
    Generators.GenAddSquarebuildLog(Board, Squarebuild)
end

Generators.RunSquarebuild = function(Board, SquarebuildID)
    local Squarebuild = Board.Dictionary.AllSquarebuilds[SquarebuildID]
    local RunFunction = Squarebuild.SquarebuildType.SquarebuildFunction
    RunFunction(Board, Squarebuild)
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


Generators.GenAddPieceLog = function(Board, Piece)
    local Pos = Piece.Position
    local PieceType = Piece.PieceType
    local Log = { "Add", "Piece", PieceType, Basics.shallow_copy(Pos) }
    Generators.AddToChangeLog(Board, Log)
end
Generators.GenRemovePieceLog = function(Board, Piece)
    local Pos = Piece.Position
    local PieceType = Piece.PieceType
    local Log = { "Remove", "Piece", PieceType, Basics.shallow_copy(Pos) }
    Generators.AddToChangeLog(Board, Log)
end
Generators.GenMovePieceLog = function(Board, Piece, OldPos)
    local Pos = Piece.Position
    local PieceType = Piece.PieceType
    local Log = { "Move", "Piece", PieceType, Basics.shallow_copy(OldPos), Basics.shallow_copy(Piece.Position) }
    Generators.AddToChangeLog(Board, Log)
end
Generators.GenAddSquarebuildLog = function(Board, Squarebuild)
    local Pos = Squarebuild.Position
    local SquarebuildType = Squarebuild.SquarebuildType
    local Log = { "Add", "Squarebuild", SquarebuildType, Basics.shallow_copy(Pos) }
    Generators.AddToChangeLog(Board, Log)
end
Generators.GenRemoveSquarebuildLog = function(Board, Squarebuild)
    local Pos = Squarebuild.Position
    local SquarebuildType = Squarebuild.SquarebuildType
    local Log = { "Remove", "Squarebuild", Squarebuild, Basics.shallow_copy(Pos) }
    Generators.AddToChangeLog(Board, Log)
end
Generators.LogToNotation = function(Log)
    local Command = Templates.NotationLookup[Log[1]]
    local Type = string.sub(Log[2], 1, 1)
    local TypeOf = Templates.ReversePieceLookup[Log[3].Name]
    local Arg1 = Log[4]
    local Arg2 = Log[5]
    return (Command .. Type .. TypeOf .. Basics.dump(Arg1))
end

Generators.AddToChangeLog = function(Board, ToAdd)
    table.insert(Board.ChangeLog, ToAdd)
end



return Generators

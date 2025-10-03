local SquarebuildTypes = {}
local Generators = require("Generators")

SquarebuildTypes.Mine = {
    Name = "Mine",
    Type = "Trigger",
    SquarebuildFunction = function(Board, Squarebuild)
        local Tile = Board.Tiles[Squarebuild.Position[1]][Squarebuild.Position[2]]
        local PieceID = Tile.Piece.PieceID
        Generators.RemovePiece(Board, PieceID)
        Generators.RemoveSquarebuild(Board, Squarebuild.SquarebuildID)
    end,
}


return SquarebuildTypes

local SquarebuildTypes = {}
local Generators = require("Generators")
local Basics = require("Basics")

SquarebuildTypes.Mine = {
    Name = "Mine",
    Type = "Trigger",
    SquarebuildFunction = function(Board, Squarebuild)
        Generators.RemoveSquarebuild(Board, Squarebuild.SquarebuildID)
        for x = -1, 1 do
            for y = -1, 1 do
                if not (x == 0 and y == 1) then
                    if Basics.Inbounds(Board.BoardSize, Squarebuild.Position, { x, y }) then
                        local Tile = Board.Tiles[Squarebuild.Position[1] + x][Squarebuild.Position[2] + y]
                        if Tile.Piece.PieceID then
                            local PieceID = Tile.Piece.PieceID
                            Generators.RemovePiece(Board, PieceID)
                        end
                    end
                end
            end
        end
    end,
}


return SquarebuildTypes

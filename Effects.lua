local Effects = {}
local Generators = require("Generators")
local Basics = require("Basics")

Effects.Fire = {
    EffectFunction = function(Board, Piece)
        local EffectData = Piece.Effects.Fire.EffectData
        local TimeTill = EffectData[1]
        if TimeTill <= Board.TurnNumber then
            Generators.RemovePiece(Board, Piece.PieceID)
        end
    end,
    EffectData = {}
}

return Effects

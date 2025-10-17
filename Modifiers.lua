--[[
ModifierTemplate = {
    StartingFunction = nil,
    TurnFunction = nil,
    GenerationFunctiPon = nil,
},
]]
local Generators = require("Generators")
local Basics = require("Basics")
local Modifiers = {}
Modifiers.Minefield = {
    StartingFunction = function(Board)
        local EmptyTiles = Generators.GetAllEmptyTiles(Board)
        local Choosing = 4
        for i = 1, Choosing, 1 do
            local Mine = Generators.CreateSquarebuild("Mine")
            Generators.AddSquarebuildToLists(Mine)
            local Tile = Basics.RandomFromTable(EmptyTiles)
            table.insert(Tile.SquarebuildList, Mine)
        end
    end,
    TurnFunction = nil,
}
return Modifiers

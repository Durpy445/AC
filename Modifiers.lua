--[[
ModifierTemplate = {
    StartingFunction = nil,
    TurnFunction = nil,
    Intensity = nil,
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
        local Chose = {}
        for i = 1, Choosing, 1 do
            table.insert(Chose, Basics.RandomFromTable(EmptyTiles))
        end
    end,
    TurnFunction = nil,
    GenerationFunction = nil,
}

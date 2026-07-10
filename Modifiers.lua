local Generators = require("Generators")
local Basics = require("Basics")
local Modifiers = {}
Modifiers.Minefield = {
    Weight = 1,
    StartingFunction = function(Board)
        local Choosing = 4
        for i = 1, Choosing, 1 do
            EmptyTiles = Generators.GetAllEmptyTiles(Board)
            local Tile = Basics.RandomFromTable(EmptyTiles)
            local Mine = Generators.CreateSquarebuild("Mine")
            if Tile ~= nil then
                Mine["Position"] = Basics.shallow_copy(Tile["Position"])
                Generators.AddSquarebuildToLists(Board, Mine)
                print("AZ")
            end
        end
    end,
    TurnFunction = nil,
    Description = "The board is a Minefield"
}
return Modifiers

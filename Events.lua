local Generators   = require("Generators")
local Basics       = require("Basics")
local Events       = {}

Events.AddTripmine = {
    Weight = 1,
    EventFunction = function(board)
        EmptyTiles = Generators.GetAllEmptyTiles(board)
        local Tile = Basics.RandomFromTable(EmptyTiles)
        local Mine = Generators.CreateSquarebuild("Mine")
        if Tile ~= nil then
            Mine["Position"] = Basics.shallow_copy(Tile["Position"])
            Generators.AddSquarebuildToLists(board, Mine)
            print("AZ")
        end
    end,
    DisplayName = "Add Tripmine",
    Description = "Adds Tripmine to a random spot on the board"
}

return Events

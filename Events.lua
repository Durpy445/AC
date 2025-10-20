local Generators   = require("Generators")
local Basics       = require("Basics")
local Events       = {}

Events.AddTripmine = {
    Weight = 1,
    EventFunction = function(board)
        EmptyTiles = Generators.GetAllEmptyTiles(board)
        local Mine = Generators.CreateSquarebuild("Mine")
        Generators.AddSquarebuildToLists(Mine)
        local Tile = Basics.RandomFromTable(EmptyTiles)
        table.insert(Tile.SquarebuildList, Mine)
    end,
    DisplayName = "Add Tripmine",
    Description = "Adds Tripmine to a random spot on the board"
}

return Events

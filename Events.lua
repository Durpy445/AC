local Generators   = require("Generators")
local Basics       = require("Basics")
local Events       = {}

Events.AddTripmine = {
    Weight = 1,
    EventFunction = function(board)
        EmptyTiles = Generators.GetAllEmptyTiles(board)
        print(Basics.dump(EmptyTiles))
        local Tile = Basics.RandomFromTable(EmptyTiles)
        local Mine = Generators.CreateSquarebuild("Mine")
        print(Basics.dump(Tile))
        Mine["Position"] = Basics.shallow_copy(Tile["Position"])
        Generators.AddSquarebuildToLists(board, Mine)
    end,
    DisplayName = "Add Tripmine",
    Description = "Adds Tripmine to a random spot on the board"
}

return Events

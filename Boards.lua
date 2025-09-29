local Boards = {}
Boards.Deafult = {
    LayoutFunction = nil,
    ForcedLayout = {
        { { "R", 2 }, { "H", 2 }, { "B", 2 }, { "Q", 2 }, { "K", 2 }, { "B", 2 }, { "H", 2 }, { "R", 2 } },
        { { "P", 2 }, { "P", 2 }, { "P", 2 }, { "P", 2 }, { "P", 2 }, { "P", 2 }, { "P", 2 }, { "P", 2 } },
        {},
        {},
        {},
        {},
        { { "P", 1 }, { "P", 1 }, { "P", 1 }, { "P", 1 }, { "P", 1 }, { "P", 1 }, { "P", 1 }, { "P", 1 } },
        { { "R", 1 }, { "H", 1 }, { "B", 1 }, { "Q", 1 }, { "K", 1 }, { "B", 1 }, { "H", 1 }, { "R", 1 } },
    }
}


Boards.DeafultFunction = {
    LayoutFunction = function(Size)
        local Board = {}
        local Y = Size[1]
        local X = Size[2]
        for i = 1, X, 1 do
            Row = {}
            for i = 1, Y, 1 do
                table.insert(Row, {})
            end
            table.insert(Board, Row)
        end
        local Mid = X / 2 + X % 2
        Mid = math.floor(Mid)
        Board[1][Mid] = { "K", 2 }
        Board[Y][Mid] = { "K", 1 }
        return Board
    end,
    ForcedLayout = nil,
}

return Boards

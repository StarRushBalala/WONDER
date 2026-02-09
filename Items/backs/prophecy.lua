local backInfo = {
    key = "prophecy",
    pos = {x = 0, y = 3},
    atlas = "PLH2",
    unlocked = true,

    apply = function(self)
        for k, v in pairs(G.GAME.probabilities) do
            G.GAME.probabilities[k] = 1000
        end
    end,
}

return backInfo
local jokerInfo = {
    key = "crash",
    pos = {x = 6, y = 1},
    rarity = 1,
    atlas = "jokers",
    cost = 1,
    unlock = true,
    blueprint_compat = false,
    pools = { ["dydb_additions"] = true },

    calculate = function (self, card, context)
        if next(context.poker_hands["Fuck"]) then
        end
    end,
}

return jokerInfo
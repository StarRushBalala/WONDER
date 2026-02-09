local jokerInfo = {
    key = "ena",
    pos = { x = 3, y = 0},
    atlas = "PLH",
    rarity = 1,
    cost = 5,
    unlocked = true,
    blueprint_compat = true,
    config = { extra = { prob = 2, prob_tot = 1, mult = 7, chips = 40 } },
    pools = { ["dydb_additions"] = true },

    loc_vars = function(self, info_queue, card)
        return { vars = { (G.GAME.probabilities.normal or 2), card.ability.extra.prob, card.ability.extra.mult, card.ability.extra.chips} }
    end,
    --calculate = function(self, card, context)
        --if context.joker_main then
            --if pseudorandom('dream_bbq') < (G.GAME.probabilities.normal or 2) / card.ability.extra.prob then
                ---return {mult = }
        --end
    --end
}

return jokerInfo
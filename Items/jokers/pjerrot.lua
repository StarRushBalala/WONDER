local jokerInfo = {
    key = "pjerrot",
    pos = {x = 0, y = 15},
    soul_pos = {x = 1, y = 15},
    rarity = 4,
    atlas = "jokers",
    cost = 10,
    unlock = true,
    blueprint_compat = true,
    config = { extra = {
        x_mult = 3,
        odds = 2,
    }},
    pools = { ["dydb_additions"] = true },

    loc_vars = function (self, info_queue, card)
        return { vars = { 
            card.ability.extra.x_mult,
            (G.GAME.probabilities.normal or 1), 
            card.ability.extra.odds, 
        } }
    end,
    calculate = function (self, card, context)
        if context.cardarea == G.play and context.individual and context.other_card:is_suit('Clubs') then
            if pseudorandom('dydb_pjerrot') < (G.GAME.probabilities.normal or 1) / card.ability.extra.odds then
                return {x_mult = card.ability.extra.x_mult}
            end
        end
    end,
}

return jokerInfo
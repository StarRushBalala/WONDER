local jokerInfo = {
    key = "tourist",
    pos = {x = 6, y = 5},
    atlas = "PLH",
    rarity = 2,
    cost = 7,
    unlocked = true,
    blueprint_compat = true,
    pools = { ["dydb_additions"] = true },
    config = { extra = { perma_bonus = 1, odds = 2} },

    loc_vars = function(self, info_queue, card)
        return { vars = { 
            card.ability.extra.perma_bonus,
            card.ability.extra.odds,
            (G.GAME.probabilities.normal or 1), 
            } 
        }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if pseudorandom('dydb_tourist') < (G.GAME.probabilities.normal or 1) / card.ability.extra.odds then
                context.other_card.ability.perma_p_dollars = context.other_card.ability.perma_p_dollars or 0
                context.other_card.ability.perma_p_dollars = context.other_card.ability.perma_p_dollars + card.ability.extra.perma_bonus
                return {
                    extra = { message = localize('k_upgrade_ex'), colour = G.C.MONEY },
                    card = card
                }
            end
        end
    end
}

return jokerInfo
local jokerInfo = {
    key = "day_of_2",
    pos = { x = 3, y = 5 },
    atlas = "PLH",
    rarity = 2,
    cost = 6,
    unlocked = true,
    blueprint_compat = true,
    pools = { ["dydb_additions"] = true },
    config = { extra = { perma_bonus = 30, odds = 4} },

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
            if context.other_card.base.id == 2 then
                if pseudorandom('dydb_day_of_2') < (G.GAME.probabilities.normal or 1) / card.ability.extra.odds then
                    context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus or 0
                    context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus + card.ability.extra.perma_bonus
                    return {
                        extra = { message = localize('k_upgrade_ex'), colour = G.C.CHIPS },
                        card = card
                    }
                end
            end
        end
    end
}

return jokerInfo
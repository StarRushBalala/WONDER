local jokerInfo = {
    key = "traveller",
    pos = {x = 9, y = 2},
    atlas = "jokers",
    rarity = 3,
    cost = 6,
    unlocked = true,
    blueprint_compat = true,
    pools = { ["dydb_additions"] = true },
    config = { extra = { perma_mult = 2} },

    loc_vars = function(self, info_queue, card)
        return { vars = { 
            card.ability.extra.perma_mult,
            } 
        }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            context.other_card.ability.perma_mult = context.other_card.ability.perma_mult or 0
            context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + card.ability.extra.perma_mult
            return {
                extra = { message = localize('k_upgrade_ex'), colour = G.C.MULT },
                card = card
            }
        end
    end,
}

return jokerInfo
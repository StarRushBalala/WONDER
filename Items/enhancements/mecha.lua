local enhancementInfo = {
    key = "mecha",
    config = { 
        mult = 0,
        mult_mod = 3
    },
    pos = {x = 2, y = 5},
    atlas = "PLH2",

    loc_vars = function(self, info_queue, card)
        return { vars = { 
            card.ability.mult, 
            card.ability.mult_mod
        } }
    end,
    calculate = function(self, card, context)
        if context.discard and context.other_card == card then
            card.ability.mult = card.ability.mult + card.ability.mult_mod
            return {
                message = "Upgraded !", colour = G.C.MULT
            }
        end
        if context.individual and context.cardarea == G.play then
            return { mult = card.ability.mult }
        end
    end,
}

return enhancementInfo
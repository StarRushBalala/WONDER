local enhancementInfo = {
    key = "aqua",
    pos = {x = 0, y = 5},
    atlas = "PLH2",
    config = { x_chips = 1.3 },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.x_chips } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            return { 
                xchips = card.ability.x_chips, 
                message = 'X'..card.ability.x_chips,
                colour = G.C.CHIPS,
            }
        end
    end,
}

return enhancementInfo
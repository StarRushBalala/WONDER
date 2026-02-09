local enhancementInfo = {
    key = "freeze",
    pos = {x = 3, y = 5},
    atlas = "PLH2",
    config = { h_x_chips = 1.5 },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.h_x_chips } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            return { h_x_chips = card.ability.h_x_chips, colour = G.C.CHIPS }
        end
    end,
}

return enhancementInfo
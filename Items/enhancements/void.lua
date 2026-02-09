local enhancementInfo = {
    key = "void",
    config = { e_mult = 1.1 },
    pos = {x = 1, y = 5},
    atlas = "PLH2",

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.e_mult } }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.main_scoring then
            return { 
                e_mult = card.ability.e_mult,
                colour = G.C.DARK_EDITION,
            }
        end
    end,
}

return enhancementInfo
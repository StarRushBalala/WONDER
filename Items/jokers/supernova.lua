local jokerInfo = {
    key = "supernova",
    pos = {x = 2, y = 4},
    rarity = 2,
    atlas = "PLH",
    cost = 5,
    unlock = true,
    blueprint_compat = true,
    pools = { ["dydb_additions"] = true },
    config = { 
        extra = {
            xmult = 1,
            xmult_mod = 0.3,
            resets = 1,
        } 
    },
    Dumb_yet_Dumber = {
    	requires_stars = true
  	},
    loc_vars = function (self, info_queue, card)
        return { 
            vars = {
                card.ability.extra.xmult, 
                card.ability.extra.xmult_mod
            } 
        }
    end,
    calculate = function (self, card, context)

        if context.discard and context.other_card:is_suit('dydb_Stars') then
            card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
            return {
                message = "Upgraded !"
            }
        end

        if context.cardarea == G.play and context.individual then 
            if context.other_card:is_suit('dydb_Stars') then
                card.ability.extra.xmult = card.ability.extra.resets
                return {
                    message = "Reset !",
                    colour = G.C.MULT
                }
            end
        end

        if context.cardarea == G.jokers and context.joker_main and (card.ability.extra.xmult > 1) then 
            return {
                xchips = card.ability.extra.xmult,
            }
        end
    end,
}

return jokerInfo
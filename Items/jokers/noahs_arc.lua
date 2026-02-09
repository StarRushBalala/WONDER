local jokerInfo = {
    key = "noahs_arc",
    pos = {x = 5, y = 2},
    rarity = 3,
    atlas = "jokers",
    cost = 5,
    unlock = true,
    blueprint_compat = true,
    pools = { ["dydb_additions"] = true },
    config = { 
        extra = {
            x_mult = 1,
            x_mult_mod = 0.2,
        } 
    },
    
    loc_vars = function (self, info_queue, card)
        return { 
            vars = {
                card.ability.extra.x_mult,
                card.ability.extra.x_mult_mod,
            },
        }
    end,
    calculate = function (self, card, context)
        if context.before and not context.blueprint and not context.retrigger then
			local eval = evaluate_poker_hand(context.full_hand)
			if next(eval["Pair"]) then
				card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_mod
			    return {
				    message = "Upgrade !",
			    }
            else
				card.ability.extra.x_mult = 1
			    return {
				    message = "sploutch", colour = G.C.CHIPS
			    }
            end
        end
		if context.joker_main then
            return { 
                xmult = card.ability.extra.x_mult
            }
        end
    end,
}

return jokerInfo
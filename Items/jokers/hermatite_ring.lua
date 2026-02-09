local jokerInfo = {
    key = "hermatite_ring",
    pos = {x = 1, y = 0},
    atlas = "jokers",
    rarity = 2,
    cost = 6,
    unlocked = true,
    blueprint_compat = true,
    pools = { ["dydb_additions"] = true },
    config = { extra = { xmult = 1, xmult_mod = 0.2, xmult_reset = 1} },

    loc_vars = function(self, info_queue, card)
        return { vars = { 
            card.ability.extra.xmult,
            card.ability.extra.xmult_mod,
            } 
        }
    end,

	calculate = function(self, card, context)
		if context.pseudorandom_result and not context.result and not context.blueprint then
            card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
            return {
                message = 'Upgrade !', colour = G.C.CHIPS
            }
        
        elseif context.pseudorandom_result and context.result and not context.blueprint then
            card.ability.extra.xmult = card.ability.extra.xmult_reset
            return {
                message = 'Reset !', colour = G.C.MULT
            }

        end

		if context.joker_main then
			return {
				xmult = card.ability.extra.xmult,
			}
		end
	end,
}

return jokerInfo
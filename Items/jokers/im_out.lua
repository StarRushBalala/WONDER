local jokerInfo = {
	key = "im_out",
	config = {
		extra = {
			xmult = 2,
			xmult_bad = 0.5
		},
	},
	pos = { x = 8, y = 2 },
	rarity = 1,
	cost = 5,
	blueprint_compat = true,
	atlas = "PLH",
    pools = { ["dydb_additions"] = true },
    unlock = true,

    loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.xmult,
				card.ability.extra.xmult_bad
			},
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			if G.GAME.current_round.hands_played == 0 then
				return {
					xmult = card.ability.extra.xmult
				}
			else
				return{
					xmult = card.ability.extra.xmult_bad
				}
			end
		end
	end,
}

return jokerInfo
local jokerInfo = {
    key = "four",
    pos = {x = 0, y = 2},
    rarity = 1,
    atlas = "PLH",
    cost = 5,
    unlock = true,
    blueprint_compat = true,
    pools = { ["dydb_additions"] = true },
    config = {
		extra = {
            Xmult = 4,
		},
	},

    loc_vars = function(self, info_queue, center)
		return { vars = { number_format(center.ability.extra.Xmult) } }
	end,
	calculate = function(self, card, context)
		if context.joker_main and context.scoring_hand then
			local fours = 0
			for i = 1, #context.scoring_hand do
				if context.scoring_hand[i]:get_id() == 4 then
					fours = fours + 1
				end
			end
			if fours == 4 then
				return {
					message = 'X'..card.ability.extra.Xmult..' Mult',
                    colour = G.C.MULT,
					Xmult_mod = lenient_bignum(card.ability.extra.Xmult),
				}
			end
		end
    end,
}

return jokerInfo
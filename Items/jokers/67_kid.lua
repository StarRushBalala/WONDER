local jokerInfo = {
	key = "67_kid",
	config = {
		extra = {
            xmult = 6.7,
        }
	},
	pos = { x = 0, y = 3 },
	rarity = 3,
	cost = 9,
	blueprint_compat = true,
	atlas = "PLH",
    pools = { ["dydb_additions"] = true },
    unlock = true,

	loc_vars = function(self, info_queue, center)
		return { vars = { number_format(center.ability.extra.xmult) } }
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.joker_main then

			local a, b = nil, nil
			for i = 1, #context.full_hand do
				if context.full_hand[i]:get_id() == 6 then
					a = true
				end
				if context.full_hand[i]:get_id() == 7 then
					b = true
				end
			end

			if a and b then
				if not context.retrigger and not context.blueprint then
					local i = math.random()
					if i >= 0.5 then
						play_sound("dydb_tuff1", 1, 100)
					else
						play_sound("dydb_tuff2", 1, 100)
					end
				end
				return {
					xmult = lenient_bignum(card.ability.extra.xmult),
				}
			end

		end
	end,
}

return jokerInfo
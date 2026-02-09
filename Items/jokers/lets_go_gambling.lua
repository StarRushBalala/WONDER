local jokerInfo = {
	key = "lets_go_gambling",
	pos = { x = 6, y = 3 },
	config = {
		extra = {
			mult_mod = 0.25,
			x_mult = 1,
		},
	},
	rarity = 2,
	cost = 5,
	blueprint_compat = true,

    add_to_deck = function(self, card, from_debuff)
    	play_sound('dydb_gambling', 1, 0.5)
    end,

	loc_vars = function(self, info_queue, center)
		local aaa, bbb = SMODS.get_probability_vars(nil, 1, 4, "wheel_of_fortune")
		info_queue[#info_queue + 1] = { key = "c_wheel_of_fortune" , set = "Other", specific_vars = { aaa, bbb } }
		return {
			vars = {
				center.ability.extra.mult_mod,
				center.ability.extra.x_mult,
			},
		}
	end,
	atlas = "PLH",
	calculate = function(self, card, context)
	--main context
		if context.joker_main and (card.ability.extra.x_mult > 1) then
			return {
				play_sound('dydb_gambling', 1, 0.8),
				x_mult = card.ability.extra.x_mult
			}
		end
	--losing
		if context.pseudorandom_result and context.result then
			if context.identifier and context.identifier == "wheel_of_fortune" then
				return {
					play_sound('dydb_winning', 1, 0.8),
					message = "I can't stop winning !", 
					colour = G.C.MULT,
				}
			end
		end
	--winning
		if context.pseudorandom_result and not context.result then
            if context.identifier and context.identifier == "wheel_of_fortune" then
				card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.mult_mod
				return {
					play_sound('dydb_dang', 1, 0.8),
    				message = "Aw dang it !", 
					colour = G.C.CHIPS,
				}
			end
		end
	end,
}

return jokerInfo
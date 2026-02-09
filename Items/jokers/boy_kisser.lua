local jokerInfo = {
    key = "boy_kisser",
    pos = {x = 5, y = 0},
    rarity = 1,
    atlas = "PLH",
    cost = 5,
    unlock = true,
    blueprint_compat = true,
    config = { extra = {xmult = 2}},
    pools = { ["dydb_additions"] = true },

	loc_vars = function(self, info_queue, center)
		if not center.edition or (center.edition and not center.edition.polychrome) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
		end
		return { vars = { number_format(center.ability.extra.xmult) } }
	end,
	calculate = function(self, card, context)
		if
			context.other_joker
			and context.other_joker.edition
			and context.other_joker.edition.polychrome == true
			and card ~= context.other_joker
		then
			if not Talisman.config_file.disable_anims then
				G.E_MANAGER:add_event(Event({
					func = function()
						context.other_joker:juice_up(0.5, 0.5)
						return true
					end,
				}))
			end
			return {
				message = localize({
					type = "variable",
					key = "a_xmult",
					vars = { number_format(card.ability.extra.xmult) },
				}),
				Xmult_mod = lenient_bignum(card.ability.extra.xmult),
			}
		end
		if context.individual and context.cardarea == G.play then
			if context.other_card.edition and context.other_card.edition.polychrome == true then
				return {
					x_mult = lenient_bignum(card.ability.extra.xmult),
					colour = G.C.MULT,
					card = card,
				}
			end
		end
		if
			context.individual
			and context.cardarea == G.hand
			and context.other_card.edition
			and context.other_card.edition.polychrome == true
			and not context.end_of_round
		then
			if context.other_card.debuff then
				return {
					message = "debuffed",
					colour = G.C.RED,
					card = card,
				}
			else
				return {
					x_mult = lenient_bignum(card.ability.extra.xmult),
					card = card,
				}
			end
		end
	end,
}

return jokerInfo
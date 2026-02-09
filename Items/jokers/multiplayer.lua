local jokerInfo = {
    key = "multiplayer",
    pos = {x = 0, y = 2},
    rarity = 1,
    atlas = "PLH",
    cost = 5,
    unlock = true,
    blueprint_compat = true,
    pools = { ["dydb_additions"] = true },
	config = { extra = { xmult = 1, xmult_mod = 0.03 } },
	--loc_txt = {
		--name = "multiplayer",
		--text = "#1# mult",
	--},

	calculate = function(self, card, context)
		if context.joker_main and (to_big(card.ability.extra.xmult) > to_big(1)) then
			return {
				xmult = card.ability.extra.xmult,
			}
		end
	end,
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				center.ability.extra.xmult_mod,
				center.ability.extra.xmult,
			},
		}
	end,
	init = function(self)
		-- Hook for scaling
		local scie = SMODS.calculate_individual_effect
		function SMODS.calculate_individual_effect(effect, scored_card, key, amount, from_edition)
			local ret = scie(effect, scored_card, key, amount, from_edition)
			if
				(
					key == "x_mult"
					or key == "xmult"
					or key == "Xmult"
					or key == "x_mult_mod"
					or key == "xmult_mod"
					or key == "Xmult_mod"
				)
				and amount ~= 1
				and mult
			then
				card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
			end
			return ret
		end
	end,
}

return jokerInfo
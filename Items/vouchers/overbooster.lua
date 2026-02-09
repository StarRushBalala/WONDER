local voucherInfo = { -- tier 1
	key = "overbooster",
	config = { extra = 1 },
	atlas = "PLH2",
	pos = { x = 0, y = 2 },
	loc_vars = function(self, info_queue, card)
		return { vars = { (card and card.ability.extra or self.config.extra) } }
	end,
	redeem = function(self, card)
		local mod = math.floor(card and card.ability.extra or self.config.extra)
		SMODS.change_booster_limit(mod)
	end,
}

return voucherInfo
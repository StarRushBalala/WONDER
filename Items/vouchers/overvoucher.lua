local voucherInfo = { -- tier 2
	key = "overvoucher",
	config = { extra = 1 },
	atlas = "PLH2",
	pos = { x = 1, y = 2 },
	requires = { "v_dydb_overbooster" },
	loc_vars = function(self, info_queue, card)
		return { vars = { (card and card.ability.extra or self.config.extra) } }
	end,
	redeem = function(self, card)
		local mod = math.floor(card and card.ability.extra or self.config.extra)
		SMODS.change_voucher_limit(mod)
	end,
}

return voucherInfo
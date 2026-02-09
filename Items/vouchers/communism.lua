local voucherInfo = { -- tier 3
	key = "overall",
	config = { extra = 1 },
	atlas = "PLH2",
	pos = { x = 2, y = 2 },
	requires = { "v_overstock_plus", "v_dydb_overvoucher"},
	loc_vars = function(self, info_queue, card)
		return { vars = { (card and card.ability.extra or self.config.extra) } }
	end,
	redeem = function(self, card)
		local mod = math.floor(card and card.ability.extra or self.config.extra)
		SMODS.change_booster_limit(mod)
		G.E_MANAGER:add_event(Event({
			func = function() --card slot
				change_shop_size(mod)
				return true
			end,
		}))
		SMODS.change_voucher_limit(mod)
	end,
}

return voucherInfo
SMODS.Voucher {
	key = "test",
	atlas = "PLH2",
	pos = { x = 6, y = 1 },
	pools = { ["Tier3"] = true },
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.e_dydb_misprint.weight = G.GAME.e_dydb_misprint.weight
                return true
            end
        }))
    end,
	get_weight = function(self)
		return G.GAME.edition_rate * self.weight
	end,
}

return voucherInfo
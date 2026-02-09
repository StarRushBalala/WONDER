local jokerInfo = {     --// just stole the twitter code lol
	key = "supercluster",
	config = {
		extra = {
            mod = 0.1,
        }
	},
	pos = { x = 1, y = 4 },
	rarity = 3,
	cost = 9,
	blueprint_compat = true,
	atlas = "PLH",
    pools = { ["dydb_additions"] = true },
    unlock = true,
    Dumb_yet_Dumber = {
    	requires_stars = true
  	},
	loc_vars = function(self, info_queue, card)
		local chips_amount = 1
		for k, v in pairs(G.playing_cards or {}) do
			if v:is_suit('dydb_Stars') then 
				chips_amount = chips_amount + card.ability.extra.mod
			end
		end
		return { vars = { 
			card.ability.extra.mod,
            chips_amount,
        } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
            local chips_amount = 1
            for k, v in pairs(G.playing_cards) do
                if v:is_suit('dydb_Stars') then 
                    chips_amount = chips_amount + card.ability.extra.mod
                end
            end
			if chips_amount > 1 then
				return {
					Emult_mod = chips_amount,
					message = '^'..chips_amount, 
					colour = G.C.DARK_EDITION
				}
			end
		end
    end,
}

return jokerInfo
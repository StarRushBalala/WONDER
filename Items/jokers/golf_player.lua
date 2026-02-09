local jokerInfo = {
	key = "golf_player",
	config = {
		extra = {
            x_chips = 1.3,
        }
	},
	pos = { x = 0, y = 0 },
	rarity = 3,
	cost = 7,
	blueprint_compat = true,
	atlas = "PLH",
    pools = { ["dydb_additions"] = true },
    unlock = true,

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.x_chips }  }
	end,

    calculate = function(self, card, context)
        if context.other_joker then
            if context.other_joker.config.center.rarity == 3 and self ~= context.other_joker then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        context.other_joker:juice_up(0.5, 0.5)
                        return true
                    end
                })) 
                return {
                    x_chips = card.ability.extra.x_chips
                }
            end
        end
    end,
}

return jokerInfo
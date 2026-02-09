local jokerInfo = {
	key = "jo",
	config = {
		extra = {
            obtained = 1,
        }
	},
	pos = { x = 9, y = 0 },
	rarity = 1,
	cost = 6,
	blueprint_compat = true,
	atlas = "PLH",
    loc_vars = function(self, info_queue, card)
        return { vars = { 
            card.ability.extra.obtained,
            } 
        }
    end,
    pools = { ["dydb_additions"] = true },
    unlock = true,
    loc_txt = {
        name = "Jo",
        text = { 
            "{C:inactive}Does nothing.",
            "{C:inactive,s:0.2}Or does he ?",
        }
    },
	calculate = function(self, card, context)
		if context.before and context.cardarea == G.jokers and (not context.blueprint) then
			change_operator(card.ability.extra.obtained)
			return {
				message = 'Upgraded!',
				card = card
			}
		end
    end,
}

return jokerInfo
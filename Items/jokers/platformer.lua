local jokerInfo = {
    key = "platformer",
    pos = {x = 2, y = 2},
    rarity = 1,
    atlas = "jokers",
    cost = 5,
    unlock = true,
    blueprint_compat = true,
    pools = { ["dydb_additions"] = true },
	config = { extra = { dollar = 1 } },

	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				center.ability.extra.dollar,
			},
		}
	end,

	calculate = function(self, card, context)
		if context.selling_card then
			return {
				ease_dollars(card.ability.extra.dollar),
				message = '+'..card.ability.extra.dollar..'$',
				colour = G.C.MONEY,
			}
		end
	end,
}

return jokerInfo
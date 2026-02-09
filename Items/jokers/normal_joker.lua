local jokerInfo = {
	key = "normal_joker",
	pos = { x = 4, y = 1 },
	config = {
		extra = {
			chips_mod = 1,
			chips = 0,
			h_size = 1,
		},
	},
	atlas = "jokers",
	pools = { ["dydb_additions"] = true },
	rarity = 2,
	cost = 7,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.chips,
				card.ability.extra.chips_mod,
				card.ability.extra.h_size,
			},
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main and (card.ability.extra.chips > 0) then
			return {
                chips = card.ability.extra.chips
			}
		end
		if context.cardarea == G.play and context.individual and not context.blueprint then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_mod
            return {
                message = 'Upgrade !', colour = G.C.CHIPS
            }
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		G.hand:change_size(card.ability.extra.h_size)
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.hand:change_size(-1 * card.ability.extra.h_size)
	end,
}

return jokerInfo
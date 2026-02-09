local jokerInfo = {
	key = "ai_joker",
	config = {
		extra = {
			h_size = 4,
            odds = 20,
		},
	},
	pos = { x = 2, y = 1 },
	rarity = 1,
	atlas = "jokers",
    blueprint_compat = false,
	loc_vars = function(center, info_queue, card)
        local normal, odds = SMODS.get_probability_vars(card, (G.GAME.probabilities.normal or 1), card.ability.extra.odds, "A.I. Joker")
		return {
			vars = {
				card.ability.extra.h_size, 
                normal, 
                odds,
			},
		}
	end,
	calculate = function(self, card, context)
		if (context.end_of_round and not context.individual and not context.repetition and not context.blueprint) then
            if SMODS.pseudorandom_probability(card, "dydb_ai_joker", G.GAME.probabilities.normal, card.ability.extra.odds, "A.I. Joker") then
                G.hand:change_size(-1 * card.ability.extra.h_size)
                return { message = 'Oupsies !', colour = G.C.RED}
            else
                return { message = 'Nope !', colour = G.C.CHIPS}
            end
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
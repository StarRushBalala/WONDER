local jokerInfo = {
	key = 'bank_heist',
	config = { extra = { mult = 20, money = 20 } },
	rarity = 3,
	atlas = 'jokers',
	blueprint_compat = true,
	demicoloncompat = false,
	pos = { x = 3, y = 1 },
	cost = 7,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.money } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if context.other_card.ability.name == 'Lucky Card' then
				local first_dissolve = nil
				return {
					mult = card.ability.extra.mult,
                    money = card.ability.extra.money,
					card = context.other_card,
				}
			end
		end
		if context.destroying_card and not context.blueprint then
			if context.other_card.ability.name == 'Lucky Card' then
				return { 
					remove = not SMODS.is_eternal(context.destroying_card),
					message = 'DRIIIING !', 
					colour = G.C.MULT,
				}
			end
		end
	end
}

return jokerInfo
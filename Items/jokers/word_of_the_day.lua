local jokerInfo = {
    key = "word_of_the_day",
    pos = {x = 5, y = 1},
    atlas = "jokers",
    rarity = 1,
    cost = 6,
    unlocked = true,
    blueprint_compat = true,
    pools = { ["dydb_additions"] = true },
    config = { extra = { dollar = 5, selected_rank = '2'} },
	
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.dollar, card.ability.extra.selected_rank } }
	end,

	set_ability = function(self, card, initial, delay_sprites)
		card.ability.extra.selected_rank = "2"
		if G.playing_cards then
			local selected_card = pseudorandom_element(G.playing_cards, "word_of_the_day")
			if selected_card and selected_card.base and selected_card.base.value then
				card.ability.extra.selected_rank = selected_card.base.value
			end
		end
	end,
	calculate = function(self, card, context)
		if 
			context.individual
			and not context.end_of_round
			and context.cardarea == G.hand
			and not context.blueprint
			and not context.before
			and not context.after
			and context.other_card.base.value == card.ability.extra.selected_rank 
		then
			return {
				ease_dollars(card.ability.extra.dollar),
				message = '+'..card.ability.extra.dollar..'$',
				colour = G.C.MONEY,
			}
		elseif context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
			local selected_card = pseudorandom_element(G.playing_cards, "word_of_the_day")
			card.ability.extra.selected_rank = selected_card.base.value
		end
	end
}

return jokerInfo
local tarotInfo = {
	set = "Spectral",
	key = "infinity",
	pos = { x = 1, y = 1 },
	cost = 4,
	atlas = "tarots",
	can_use = function(self, card)
		local cards = get_highlighted_cards({ G.jokers, G.hand }, card, 1, 1, function(card) return true end)
		return #cards == 1
	end,

	use = function(self, card, area, copier)
		local cards = get_highlighted_cards({ G.jokers, G.hand }, card, 1, 1)

		if #cards == 1 then
			if cards[1].area == G.jokers then
				cards[1]:remove_from_deck(true)
				cards[1]:set_eternal(true)
				cards[1]:add_to_deck(true)
				G.jokers:remove_from_highlighted(cards[1])
			end
		end
	end,
}

return tarotInfo
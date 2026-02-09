local tarotInfo = {
	set = "Spectral",
	key = "the_whatsapp",
	order = 9,
	pos = { x = 8, y = 0 },
	cost = 4,
	atlas = "PLH2",
	can_use = function(self, card)
		local cards = get_highlighted_cards({ G.jokers, G.hand }, card, 1, 1, function(card)
			return not card.edition
		end)
		return #cards == 1
	end,
	loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = G.P_CENTERS.e_dydb_whatsapp
    info_queue[#info_queue + 1] = G.P_CENTERS.e_dydb_evil_whatsapp
	end,
	use = function(self, card, area, copier)

		local cards = get_highlighted_cards({ G.jokers, G.hand }, card, 1, 1)
    local i = math.random()

		if #cards == 1 then
			if cards[1].area == G.jokers then
				cards[1]:remove_from_deck(true)
        if i > 0.5 then
				  cards[1]:set_edition({dydb_whatsapp = true })
        else
          cards[1]:set_edition({dydb_evil_whatsapp = true })
        end
				cards[1]:add_to_deck(true)
				G.jokers:remove_from_highlighted(cards[1])
			else
				if i > 0.5 then
				  cards[1]:set_edition({ dydb_whatsapp  = true })
        else
          cards[1]:set_edition({ dydb_evil_whatsapp  = true })
        end
				G.hand:remove_from_highlighted(cards[1])
			end
		end
	end,
}

return tarotInfo
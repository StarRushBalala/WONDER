local tarotInfo = {
	set = "Spectral",
	key = "essence",
	config = {
		max_highlighted = 1,
	},
	loc_vars = function(self, info_queue, center)
		if not center.edition or (center.edition and not center.edition.dydb_galactic) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_dydb_galactic
		end
		if not center.edition or (center.edition and not center.edition.whatsapp) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
		end
		if not center.edition or (center.edition and not center.edition.dydb_vintage) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_dydb_vintage
		end
		return { vars = { center.ability.max_highlighted } }
	end,
	cost = 5,
	atlas = "PLH2",
	pos = { x = 7, y = 0 },
	can_use = function(self, card)
		local cards = get_highlighted_cards({ G.hand }, card, 1, card.ability.max_highlighted, function(card)
			return not card.edition and not card.will_be_editioned
		end)
		return #cards > 0 and #cards <= card.ability.max_highlighted
	end,
	use = function(self, card, area, copier)
		local used_consumable = copier or card
		local cards = get_highlighted_cards({ G.hand }, card, 1, card.ability.max_highlighted, function(card)
			return not card.edition and not card.will_be_editioned
		end)
		for i = 1, #cards do
			local highlighted = cards[i]
			if highlighted ~= card then
				highlighted.will_be_editioned = true
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound("tarot1")
						highlighted:juice_up(0.3, 0.5)
						return true
					end,
				}))
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.1,
					func = function()
						if highlighted then
							local random_result = pseudorandom(pseudoseed("Ritual"))
							if random_result >= 2 / 3 then
								highlighted:set_edition({ dydb_galactic = true })
							else
								if random_result >= 1 / 3 then
									highlighted:set_edition({ dydb_vintage = true })
								else
									highlighted:set_edition({ negative = true })
								end
							end
							highlighted.will_be_editioned = nil
						end
						return true
					end,
				}))
				delay(0.5)
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.2,
					func = function()
						G.hand:unhighlight_all()
						return true
					end,
				}))
			end
		end
	end,
}

return tarotInfo
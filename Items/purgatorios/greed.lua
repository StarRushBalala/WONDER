local tarotInfo = {		--ENVY // détruit un j_ aléatoire, créé un joker épique
	key = 'greed',
	set = 'purgatorio',
	pos = { x = 0, y = 0 },
	soul_pos = { x = 0, y = 4 },
	atlas = 'PLH2',
	cost = 10,
	unlocked = true,
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
			},
		}
	end,
	can_use = function(self, card)
		return G.STATE == G.STATES.SELECTING_HAND
	end,
	discovered = true,
	use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'before', func = function()
			G.GAME.blind.chips = G.GAME.blind.chips ^ 1.5
			G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
			G.hand_text_area.blind_chips:juice_up()
		return true end}))
		delay(0.4)
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("timpani")
				local card = create_card("Joker", G.jokers, nil, nil, nil, nil, 'j_dydb_wheathered_mask', "dydb_godseeker")
				card:add_to_deck()
				G.jokers:emplace(card)
				card:juice_up(0.3, 0.5)
				return true
			end,
		}))
		delay(0.6)
	end,
}

return tarotInfo
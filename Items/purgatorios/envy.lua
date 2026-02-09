local tarotInfo = {
	key = 'envy',
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
		return true
	end,
	discovered = true,
	use = function(self, card, area, copier)
        local check = false
        for i = 1, #G.jokers.cards do
            if not (G.jokers.cards[i] == card) then
                if not Card.no(G.jokers.cards[i], "immutable", true) then
                    check = true
                    Cryptid.with_deck_effects(G.jokers.cards[i], function(cards)
                        Cryptid.manipulate(G.jokers.cards[i], { value = 0.2 })
                    end)
                end
            end
        end

		delay(0.4)

		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("timpani")
				local card = create_card("Joker", G.jokers, nil, nil, nil, nil, 'j_dydb_not_oil_lamp', "dydb_name")
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
if CardSleeves then
	local prophecysleeve = CardSleeves.Sleeve({
		key = "prophecy_sleeve",
		name = "Pochette de la Prophecie",
		atlas = "sleeves",
		pos = { x = 1, y = 0 },
		config = { },
		unlocked = true,
		apply = function(self)
			for k, v in pairs(G.GAME.probabilities) do
				G.GAME.probabilities[k] = 1000
			end
		end,
	})

	local nightsleeve = CardSleeves.Sleeve({
		key = "night_sleeve",
		name = "Pochette Nocturne",
		atlas = "sleeves",
		pos = { x = 0, y = 0 },
		config = { },
		unlocked = true,
	    Dumb_yet_Dumber = {
			requires_stars = true
		},
		apply = function(self)
			G.E_MANAGER:add_event(Event({
				func = function()
					for k, v in pairs(G.playing_cards) do
						if v.base.suit == "Clubs" or v.base.suit == "Hearts" or v.base.suit == "Diamonds" or v.base.suit == "Spades" then
							v:change_suit("dydb_Stars")
						end
					end
					return true
				end,
			}))
		end,
	})

	local powersleeve = CardSleeves.Sleeve({
		key = "power_sleeve",
		name = "Pochette de la Puissance",
		atlas = "sleeves",
		pos = { x = 0, y = 0 },
		config = { size = 10e5 },
		unlocked = true,
		apply = function(self)
			G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling * self.config.size
			G.E_MANAGER:add_event(Event({func = function()
				SMODS.set_scoring_calculation('dydb_exponent')
			return true end}))
		end,
	})

	local magiciansleeve = CardSleeves.Sleeve({
		key = "magician_sleeve",
		atlas = 'sleeves',
		pos = { x = 2, y = 0 },
		apply = function(self)
			G.E_MANAGER:add_event(Event({func = function()
				local card2 = create_card('Joker', G.jokers, nil, nil, false, nil, 'j_ring_master', 'magician')
				G.jokers:emplace(card2)
				card2:set_edition({negative = true}, false, false)
				card2:set_eternal(true)
				card2:add_to_deck()
				play_sound('holo1')
			return true end}))
		end,
	})

	local sleeveitems = {}
	if CardSleeves then
		sleeveitems = {
			prophecysleeve,
			nightsleeve,
			powersleeve,
			magiciansleeve,
		}
	end
end
return { name = "Sleeves", init = function() end, items = { sleeveitems } }

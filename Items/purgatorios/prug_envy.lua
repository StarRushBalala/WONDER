local tarotInfo = {		--ENVY // détruit un j_ aléatoire, créé un joker épique
    set = "purgatorio",
	key = "purg_envy",
    pools = {['purgatorio_cons'] = true},
	pos = { x = 0, y = 3 },
	cost = 4,
	atlas = "PLH2",
	loc_txt = {
		name = "L'Envie",
		text = {
			"Créé un Joker {C:attention}épique{}.",
			"{C:attention}Détruit{} un autre Joker aléatoire.",
			"{C:inactive}(doit avoir de la place.)"
		},
	},
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
			},
		}
	end,
	can_use = function(self, card)
		return #G.jokers.cards <= G.jokers.config.card_limit
	end,
	use = function(self, card, area, copier)
		local used_consumable = copier or card
		local deletable_jokers = {}
		for k, v in pairs(G.jokers.cards) do
			if not SMODS.is_eternal(v) then
				deletable_jokers[#deletable_jokers + 1] = v
			end
		end
		local chosen_joker = pseudorandom_element(G.jokers.cards, pseudoseed("dydb_envy"))
		local value = "dydb_epic" or 0.99
		local _first_dissolve = nil
		G.E_MANAGER:add_event(Event({
			trigger = "before",
			delay = 0.75,
			func = function()
				for k, v in pairs(deletable_jokers) do
					if v == chosen_joker then
						v:start_dissolve(nil, _first_dissolve)
						_first_dissolve = true
					end
				end
				return true
			end,
		}))
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("timpani")
				local card = create_card("Joker", G.jokers, nil, value, nil, nil, nil, "dydb_envy")
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
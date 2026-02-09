local tarotInfo = {		-- PRIDE // détruit tous les j_, crée un joker légendaire
	set = "purgatorio",
	key = "purg_pride",
    pools = {['purgatorio_cons'] = true},
	pos = { x = 4, y = 1 },
	cost = 4,
	atlas = "IDK",
	loc_txt = {
        name = "Orgueil",
        text = {
            "{C:mult}Détruit{} tous vos {C:attention}Jokers{}.",
            "Créé un Joker {C:legendary}Légendaire{}.",
			""
        }
    },
	hidden = true, --default soul_set and soul_rate of 0.3% in spectral packs is used
	can_use = function(self, card)
		--Don't allow use if everything is eternal and there is no room
		return #G.jokers.cards <= G.jokers.config.card_limit
	end,
	use = function(self, card, area, copier)
		local deletable_jokers = {}
		for k, v in pairs(G.jokers.cards) do
			if not SMODS.is_eternal(v) then
				deletable_jokers[#deletable_jokers + 1] = v
			end
		end
		local _first_dissolve = nil
		G.E_MANAGER:add_event(Event({
			trigger = "before",
			delay = 0.75,
			func = function()
				for k, v in pairs(deletable_jokers) do
					v:start_dissolve(nil, _first_dissolve)
					_first_dissolve = true
				end
				return true
			end,
		}))
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("timpani")
				local card = create_card(
					"Joker", 
					G.jokers, 
					true, 
					nil, 
					nil, 
					nil, 
					nil, 
					"dydb_pride"
				)
				card:add_to_deck()
				G.jokers:emplace(card)
				card:juice_up(0.3, 0.5)
				return true
			end,
		}))
		delay(0.6)
	end,
	demicoloncompat = true,
}

return tarotInfo
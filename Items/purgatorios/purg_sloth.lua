local tarotInfo = {
	set = "purgatorio",
  	key = "purg_sloth",
    pools = {['purgatorio_cons'] = true},
  	pos = { x = 2, y = 2 },
  	cost = 3, 
  	atlas = "IDK",
  	loc_txt = {
    	name = "La Paresse",
		text = {
			"ballz",
		},
  	}, 
  	config = { extra = {}},
  	
  	loc_vars = function(self, info_queue, card) 
	  	return { vars = { } }
	end,

  	can_use = function(self, card) 
		return #SMODS.find_card('j_dydb_theotime', 'j_dydb_wheathered_mask') > 0
	end,

	use = function(self, card, area, copier)
		local deletable_jokers = {'dydb_theotime', 'dydb_wheathered_mask'}
		local chosen_joker = {'dydb_theotime', 'dydb_wheathered_mask'}
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
				local card = create_card("Joker", G.jokers, nil, nil, nil, nil, 'dydb_governor', "dydb_sloth")
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
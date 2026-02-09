local tarotInfo = {
  set = "Spectral",
  key = "time_loop",
  pos = { x = 0, y = 1 }, 
  cost = 3, 
  atlas = "tarots",
	config = { dollars = 0, ante = -1 },

	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.dollars, card.ability.ante or self.config.ante} }
	end, 

	can_use = function(self, card)
		return true
	end,

	use = function(self, card, area, copier)

    local deletable_jokers = {}                   --resets jokers
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

		local mod = -G.GAME.round_resets.ante           --resets ante
		ease_ante(mod + 1)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.round_resets.blind_ante = mod + 1
				return true
			end,
		}))

		G.GAME.dollars = card.ability.dollars            --resets money
	end
}

return tarotInfo
local planetInfo = {
	set = "Planet",
	key = "luna",
	pos = { x = 0, y = 5 },
	atlas = "PLH2",
	aurinko = true,

	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge("Moon", get_type_colour(self or card.config, card), nil, 1.2)
	end,

	can_use = function(self, card)
		return true
	end,

	loc_vars = function(self, info_queue, center)
		return { vars = { } }
	end,
	use = function(self, card, area, copier)
		local used_consumable = copier or card
		local neutronhand = get_random_hand(nil, "luna" .. G.GAME.round_resets.ante) --Random poker hand
		update_hand_text({ sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 }, {
			handname = localize(neutronhand, "poker_hands"),
			chips = G.GAME.hands[neutronhand].chips,
			mult = G.GAME.hands[neutronhand].mult,
			level = G.GAME.hands[neutronhand].level,
		})
		--level up once for each neutron star used this run
		level_up_hand(used_consumable, neutronhand, nil, 1)
		update_hand_text(
			{ sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
			{ mult = 0, chips = 0, handname = "", level = "" }
		)
	end,

	init = function(self)
		function get_random_hand(ignore, seed, allowhidden)
			--From JenLib's get_random_hand
			local chosen_hand
			ignore = ignore or {}
			seed = seed or "randomhand"
			if type(ignore) ~= "table" then
				ignore = { ignore }
			end
			while true do
				chosen_hand = pseudorandom_element(G.handlist, pseudoseed(seed))
				if G.GAME.hands[chosen_hand].visible or allowhidden then
					local safe = true
					for _, v in pairs(ignore) do
						if v == chosen_hand then
							safe = false
						end
					end
					if safe then
						break
					end
				end
			end
			return chosen_hand
		end
	end,
}

return planetInfo
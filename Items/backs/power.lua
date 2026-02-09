local backInfo = {
    key = "power",
    pos = {x = 0, y = 3},
    atlas = "PLH2",
    unlocked = true,
    config = {size = 5},

	apply = function(self)
		G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling * G.GAME.starting_params.ante_scaling
	    --[[G.E_MANAGER:add_event(Event({trigger = 'before', func = function()
			G.GAME.blind.chips = G.GAME.blind.chips ^ 5
			G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
			G.hand_text_area.blind_chips:juice_up()
		return true end}))]]
		G.E_MANAGER:add_event(Event({func = function()
			SMODS.set_scoring_calculation('dydb_exponant')
		return true end}))
	end,
}

return backInfo
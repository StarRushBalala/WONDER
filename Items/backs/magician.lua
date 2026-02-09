local backInfo = {
    key = "magician",
    atlas = 'PLH2',
    pos = { x = 2, y = 3 },
	apply = function(self)
		G.E_MANAGER:add_event(Event({func = function()
			local card2 = create_card('Joker', G.jokers, nil, nil, false, nil, 'j_ring_master', 'magician')
			G.jokers:emplace(card2)
            card2:set_edition({negative = true}, false, false)
            card2:set_eternal(true)
			card2:add_to_deck()
			play_sound('holo1')
		return true end}))
	end
}
return backInfo

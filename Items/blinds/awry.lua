local blindInfo = {
	key = 'awry',
	config = { pre_hands = 0, pre_size = 0 },
	boss_colour = HEX('f38f65'),
	dollars = 5,
	mult = 2,
	atlas = "blinds",
	pos = {x = 0, y = 2},
	disable = function(self)
		ease_hands_played(self.config.pre_hands - G.GAME.round_resets.hands)
		G.hand:change_size(self.config.pre_size - G.hand.config.card_limit)
	end,
	set_blind = function(self)
		self.config.pre_hands = G.GAME.round_resets.hands
		self.config.pre_size = G.hand.config.card_limit
		G.hand:change_size(G.GAME.round_resets.hands - G.hand.config.card_limit)
		G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + (G.GAME.round_resets.hands - G.hand.config.card_limit)
		ease_hands_played(G.hand.config.card_limit - G.GAME.round_resets.hands)
	end,
	boss = {
		min = 1
	}, 
}

return blindInfo
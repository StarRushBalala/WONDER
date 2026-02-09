local sealInfo = {
	key = 'banana_seal',
    config = { extra = {xmult = 3, odds = 6}},
	atlas = 'PLH2',
	pos = { x = 7, y = 5 },
	badge_colour = HEX('F5D953'),
	loc_txt = {
		name = 'Banana Seal',
		label = 'Banana',
        text = {
            "{C:green}#1# in 6{} chance to",
            "{C:attention}destroy{} this card.",
            "{X:mult,C:white}X3{} Mult.",
			" ",
            "{C:inactive}Idea, Art and Code",
			"{C:inactive}by {C:dark_edition}StarRush{}.", 
        },
	},

	loc_vars = function(self, info_queue, card)
		return { 
			vars = { 
            	(G.GAME.probabilities.normal or 1), 
			} 
		}
	end, 
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.main_scoring then
			 return {
                xmult = 3, colour = G.C.MONEY,
				card = card
			}
		end
		if context.destroying_card and context.cardarea == G.play and context.destroy_card == card then
			if pseudorandom('dydb_banana_seal') < (G.GAME.probabilities.normal or 1) / 6 then
				card.will_shatter = true
				G.E_MANAGER:add_event(Event({
					trigger = "before",
					delay = 0.0,
					func = function()
						if G.GAME.last_hand_played then
						end
						return true
					end,
				}))
				return {
					remove = true,
				}
			end
		end
	end,
}

return sealInfo
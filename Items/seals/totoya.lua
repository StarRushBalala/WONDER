local sealInfo = {
	key = "totoya_seal",
	badge_colour = HEX("000000"),
	config = {extra = {Emult = 2,},},
	atlas = "PLH2",
	pos = { x = 4, y = 5 },
    loc_txt = {
        name = "Totoya Seal",
		label = 'Totoya',
        text = {
            "{X:mult,C:dark_edition}^2{}",
            "{C:attention}Destroy{} the card.",
			" ",
            "{C:inactive}Idea, Art and Code",
			"{C:inactive}by {C:dark_edition}StarRush{}.", 
        },
    },

    loc_vars = function(self, info_queue, center)
		return {
			vars = {
				center.ability.Emult,
			},
		}
	end,
	calculate = function(self, card, context)
		if context.destroying_card and context.cardarea == G.play and context.destroy_card == card then
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
		if context.cardarea == G.play and context.main_scoring then
			return {
				Emult_mod = 2,
				message = localize({
					colour = G.C.DARK_EDITION,
					type = "variable",
					key = "a_powmult",
					vars = { number_format(card.ability.Emult) },
				}),
            }
		end
	end,
}

return sealInfo
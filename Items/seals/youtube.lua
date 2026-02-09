local sealInfo = {
	key = 'youtube_seal',
    config = { extra = {x_mult = 1}},
	atlas = 'PLH2',
	pos = { x = 6, y = 5 },
	badge_colour = HEX('E62117'),
	sound = { sound = 'dydb_youtube', per = 1.2, vol = 0.5 },
	loc_txt = {
        name = 'Youtube Seal',
		label = 'Youtube',
        text = {
            "{X:mult,C:white}+X0.1{} Mult for every card with a",
            "{C:mult}Youtube{} {C:attention}seal{} in your {C:attention}deck{}.",
            "{C:inactive}Currently {X:mult,C:white}X#1#{} Mult.",
			" ",
            "{C:inactive}Idea, Art and Code",
			"{C:inactive}by {C:dark_edition}StarRush{}.", 
        },
	},

	loc_vars = function(self, info_queue, card)
        local mult_amount = 1
		for k, v in pairs(G.playing_cards or {}) do
			if v.seal == 'dydb_youtube_seal' then 
                mult_amount = mult_amount + 0.1
			end
		end
		return { vars = { 
            number_format(mult_amount)
        } }
	end, 
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.main_scoring then
        local mult_amount = 1
			for k, v in pairs(G.playing_cards) do
				if v.seal == 'dydb_youtube_seal' then 
                mult_amount = mult_amount + 0.1
				end
			end
			 return {
				play_sound('dydb_youtube', 1, 0.7),
                x_mult = mult_amount,
				card = card
			}
		end
	end,
}

return sealInfo
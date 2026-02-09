local sealInfo = {
	key = 'twitter_seal',
    config = { extra = {x_chips = 1}},
	loc_txt = {
        name = 'Twitter Seal',
		label = 'Twitter',
        text = {
            "{X:chips,C:white}+X0.1{} Chips for every card with a",
            "{C:chips}Twitter{} {C:attention}seal{} in your {C:attention}deck{}.",
            "{C:inactive}Currently {X:chips,C:white}X#1#{} Chips.",
			" ",
            "{C:inactive}Idea, Art and Code",
			"{C:inactive}by {C:dark_edition}StarRush{}.", 
        },
	},
	atlas = 'PLH2',
	pos = { x = 5, y = 5 },
	badge_colour = HEX('08a0e9'),
	sound = { sound = 'dydb_twitter', per = 1.2, vol = 0.5 },
	loc_vars = function(self, info_queue, card)
		local chips_amount = 1
		for k, v in pairs(G.playing_cards or {}) do
			if v.seal == 'dydb_twitter_seal' then 
				chips_amount = chips_amount + 0.1
			end
		end
		return { vars = { 
            number_format(chips_amount)
        } }
	end, 
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.main_scoring then
		local chips_amount = 1
			for k, v in pairs(G.playing_cards) do
				if v.seal == 'dydb_twitter_seal' then 
				chips_amount = chips_amount + 0.1
				end
			end
			 return {
				play_sound('dydb_twitter', 1, 0.7),
				x_chips = chips_amount,
				card = card
			}
		end
	end,
}

return sealInfo
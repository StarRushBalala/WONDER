local jokerInfo = {
	key = 'glitch',
	rarity = 2,
	atlas = 'jokers',
	blueprint_compat = false,
	demicoloncompat = true,
	pos = { x = 0, y = 0 },
	config = { extra = { } },
	loc_vars = function(self, info_queue, card)
		return { vars = { } }
	end,
	cost = 4,
	calculate = function(self, card, context)
		if context.before and context.cardarea == G.jokers then
			local enhance = {}

			for k, v in ipairs(G.P_CENTER_POOLS['Enhanced']) do
				if v.key ~= 'm_stone' then
					table.insert(enhance, v)
				end
			end

			for k, v in ipairs(context.scoring_hand) do
				v:set_ability(pseudorandom_element(enhance, pseudoseed('dydb_glitch')), nil, true)
				v:set_ability(pseudorandom_element(seal, pseudoseed('dydb_glitch')), nil, true)
			end

			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('holo1')
			return true end}))

			return {
				card = card,
				message = "Enhancements!",
				colour = G.C.DARK_EDITION
			}
		end
	end

}
return jokerInfo
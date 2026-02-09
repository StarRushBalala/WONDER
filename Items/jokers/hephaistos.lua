local jokerInfo = {
	key = "hephaistos",
	pos = { x = 4, y = 2 },
	rarity = 3,
	cost = 9,
	atlas = "jokers",
	config = { extra = { } },
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
		info_queue[#info_queue + 1] = G.P_CENTERS.m_gold
		info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
        info_queue[#info_queue + 1] = G.P_CENTERS.m_dydb_freeze
        info_queue[#info_queue + 1] = G.P_CENTERS.m_dydb_void
		return { vars = { } }
	end,
	blueprint_compat = false,
	calculate = function(self, card, context)
		if 
			context.cardarea == G.jokers
			and context.before
			and not context.blueprint_card
			and not context.retrigger_joker
			and context.scoring_hand
        then
            _card = context.scoring_hand
            local enhancement = { "m_stone", "m_gold", "m_steel",  "m_dydb_freeze", "m_dydb_void"}
            for k, v in ipairs(context.scoring_hand) do
                v:set_ability(pseudorandom_element(enhancement, pseudoseed('dydb_hephaistos')), nil, true)
                G.E_MANAGER:add_event(Event({
					func = function()
						card:juice_up()
						return true
					end,
				}))
            end

            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
				play_sound('holo1')
			return true end}))
		end
	end,
}

return jokerInfo
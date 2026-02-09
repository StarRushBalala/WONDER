local jokerInfo = {
    key = "joker_exe",
    pos = {x = 8, y = 0},
    rarity = 1,
    atlas = "PLH",
    cost = 4,
    unlock = true,
    blueprint_compat = true,
    pools = { ["dydb_additions"] = true },
    config = {},

    calculate = function(self, card, context)
		if
			context.end_of_round
			and not context.individual
			and not context.repetition
			and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit
		then
			local roundcreatejoker = math.min(1, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
			G.GAME.joker_buffer = G.GAME.joker_buffer + roundcreatejoker
			G.E_MANAGER:add_event(Event({
				func = function()
					if roundcreatejoker > 0 then
						local card = create_card("Joker", G.jokers, nil, nil, nil, nil, nil, "joker.exe")
						card:add_to_deck()
						G.jokers:emplace(card)
						card:start_materialize()
						G.GAME.joker_buffer = 0
					end
					return true
				end,
			}))
			card_eval_status_text(
				context.blueprint_card or card,
				"extra",
				nil,
				nil,
				nil,
				{ message = "ALIVE ???", colour = G.C.BLUE }
			)
			return nil, true
		end
        if not context.blueprint and context.cardarea == G.jokers and context.after then
            if G.GAME.current_round.hands_played > 0 then
                local destructable_jokers = {}
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i] ~= self and not G.jokers.cards[i].ability.eternal and not G.jokers.cards[i].getting_sliced then destructable_jokers[#destructable_jokers+1] = G.jokers.cards[i] end
                end
                local joker_to_destroy = #destructable_jokers > 0 and pseudorandom_element(destructable_jokers, pseudoseed('joker.exe')) or nil

                if joker_to_destroy and not (context.blueprint_card or self).getting_sliced then 
                    joker_to_destroy.getting_sliced = true
                    G.E_MANAGER:add_event(Event({func = function()
                        joker_to_destroy:start_dissolve({G.C.RED}, nil, 1.6)
                    return true, { message ="DEAD ???", color = G.C.MULT } end }))
                end
            end
        end
	end,
}

return jokerInfo
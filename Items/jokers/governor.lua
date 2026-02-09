local jokerInfo = {
    key = "governor",
    pos = {x = 0, y = 5},
    soul_pos = { x = 2, y = 5, extra = { x = 1, y = 5 } },
    rarity = 'dydb_transcendant',
    atlas = "PLH",
    cost = 1000,
    unlock = true,
    blueprint_compat = true,
    pools = { ["dydb_additions"] = true },
    config = { extra = {retriggers = 0, retriggers_mod = 1} },
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.retriggers, card.ability.extra.retriggers_mod}}
	end,
    calculate = function(self, card, context)
		if not context.blueprint_card and not context.retrigger_joker then

			if context.retrigger_joker_check and not (context.other_card.ability and context.other_card.ability.key == "governor")  and (card.ability.extra.retriggers > 0) then
				return {
					message = 'Again !', colour = G.C.DARK_EDITION,
					repetitions = card.ability.extra.retriggers,
					card = card
				}
            end

			if context.cardarea == G.play and context.individual and context.other_card.base.id == 13 then
                card.ability.extra.retriggers = card.ability.extra.retriggers + card.ability.extra.retriggers_mod
				return {
                    message = '+1 Retrigger', 
                    colour = G.C.DARK_EDITION,
                }
            end
            if context.cardarea == G.play and context.individual and context.other_card.base.id == 13 then
                G.E_MANAGER:add_event(Event({
                    trigger = "before",
                    delay = 0.0,
                    func = function()
                        if G.GAME.last_hand_played then
						end
                        SMODS.destroy_cards(context.other_card)
                        return true
                    end,
                }))
                return {
                    remove = true,
                    message = "Banished !",
                    colour = G.C.DARK_EDITION
                }
            end
		end
	end,
}

return jokerInfo
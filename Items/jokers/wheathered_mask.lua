local jokerInfo = {
	key = "wheathered_mask",
	pos = { x = 4, y = 5 },
	soul_pos = { x = 5, y = 5 },
	config = { extra = { 
		retriggers = 1, 
        odds = 2,
		active = "Missing Ingredient : a lunatic politician",
	} },
	pools = { ["dydb_additions"] = true },
	rarity = "dydb_ascendant",
	cost = 10,
	blueprint_compat = true,

	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				math.min(card.ability.extra.retriggers, 25),
            	(G.GAME.probabilities.normal or 1), 
            	card.ability.extra.odds, 
				card.ability.extra.active,
			}
		}
	end,
	atlas = "PLH",
	calculate = function(self, card, context)
		if
			context.retrigger_joker_check
			and not context.retrigger_joker
			and not (context.other_card.ability and context.other_card.ability.key == "wheathered_mask")
		then
			if pseudorandom('dydb_wheathered_mask') < (G.GAME.probabilities.normal or 1) / card.ability.extra.odds then
				return {
					message = 'AGAIN !', colour = G.C.MONEY,
					repetitions = math.min(card.ability.extra.retriggers*2, 25),
					card = card,
				}
			else
				return {
					message = 'Again !', colour = G.C.MONEY,
					repetitions = math.min(card.ability.extra.retriggers, 25),
					card = card,
				}
			end
		end
		if #SMODS.find_card('j_dydb_theotime') > 0 then
			card.ability.extra.active = "Ritual is ready to beggin."
			if context.selling_self then
				G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.4,
				func = function()
					play_sound("timpani")
					local card = create_card("Joker", G.jokers, nil, nil, nil, nil, 'j_dydb_governor', "dydb_wheathered_mask")
					card:add_to_deck()
					G.jokers:emplace(card)
					card:juice_up(0.3, 0.5)
					return true
				end,
			}))
			delay(0.6)
			debuff = true
			end
		else
			card.ability.extra.active = "Missing Ingredient : a lunatic politician"
		end
	end,
}

return jokerInfo
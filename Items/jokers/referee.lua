local jokerInfo = {
    key = "referee",
    pos = {x = 2, y = 3},
    atlas = "jokers",
    rarity = 3,
    cost = 10,
    unlocked = true,
    blueprint_compat = true,
    pools = { ["dydb_additions"] = true },
    config = { extra = { xmult = 1, xmult_mod = 0.02, selected_rank = '10'} },
    loc_txt = {
        name = 'prout',
        text =  {'#3#', "#1#"}
    },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_mod, card.ability.extra.selected_rank } }
	end,

	set_ability = function(self, card, initial, delay_sprites)
		card.ability.extra.selected_rank = "10"
		if G.playing_cards then
			local selected_card = pseudorandom_element(G.playing_cards, "referee")
			if selected_card and selected_card.base and selected_card.base.value then
				card.ability.extra.selected_rank = selected_card.base.value
			end
		end
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and not context.blueprint and not context.retrigger then
			if context.other_card.base.value == card.ability.extra.selected_rank then
				card.ability.extra.xmult = 1
				return {
					message = 'Reset !', colour = G.C.MULT
				}
			else
				card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
				return {
					message = 'Upgrade !'
				}
			end

		elseif context.joker_main then
			return {xmult = card.ability.extra.xmult}

		elseif context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
			local selected_card = pseudorandom_element(G.playing_cards, "referee")
			card.ability.extra.selected_rank = selected_card.base.value
		end
	end
}

return jokerInfo
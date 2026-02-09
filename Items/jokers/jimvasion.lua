local jokerInfo = {
    key = "jimvasion",
    pos = {x = 9, y = 1},
    rarity = 'dydb_epic',
    atlas = "jokers",
    cost = 10,
    unlock = true,
    blueprint_compat = true,
    pools = { ["dydb_additions"] = true },
	config = { extra = { xmult = 2, in_scoring = false } },

    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
	calculate = function (self, card, context)
        if context.before then 
			card.ability.extra.in_scoring = true 
		end

		if context.post_trigger
            and card.ability.extra.in_scoring
            and context.other_card.area == G.jokers
        then
			return {
				Xmult = card.ability.extra.xmult
			}
		end

        if context.after then 
			card.ability.extra.in_scoring = false 
		end
	end,
}

return jokerInfo
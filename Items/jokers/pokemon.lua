local jokerInfo = {
    key = "pokemon",
    pos = { x = 5, y = 4 },
    rarity = 3,
    atlas = "PLH",
    cost = 5,
    unlock = true,
    blueprint_compat = true,
    config = {
        extra = {
            xchips = 1.5,
            xmult = 1.5,
        },
    },
    pools = { ["dydb_additions"] = true },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xchips,
                card.ability.extra.xmult,
            },
        }
    end,

	calculate = function(self, card, context)

		if context.other_joker and context.other_joker.edition and card ~= context.other_joker then
			G.E_MANAGER:add_event(Event({ func = function()
				context.other_joker:juice_up(0.5, 0.5)
			return true end}))

            if not card.edition then
                return {
                    xmult = card.ability.extra.xmult,
                }
            else 
                return {
                    xchips = card.ability.extra.xchips,
                    xmult = card.ability.extra.xmult,
                }
            end
		end

        if context.cardarea == G.play and context.individual and context.other_card.edition and card ~= context.other_card then
            if not card.edition then
                return {
                    xmult = card.ability.extra.xmult,
                }
            else 
                return {
                    xchips = card.ability.extra.xchips,
                    xmult = card.ability.extra.xmult,
                }
            end
        end
	end
}

return jokerInfo

local jokerInfo = {
    key = "empty_bol",
    pos = {x = 8, y = 4},
    rarity = 2,
    atlas = "PLH",
    cost = 7,
    unlock = true,
    blueprint_compat = true,
    pools = { ["dydb_additions"] = true, ["food"] = true },
    config = { 
        extra = {
            xmult = -1,
            xmult_mod = 0.02,
        } 
    },
    
    loc_vars = function (self, info_queue, card)
        return { 
            vars = {
                card.ability.extra.xmult,
                card.ability.extra.xmult_mod,
            },
        }
    end,
    calculate = function (self, card, context)
		if context.joker_main and not (card.ability.extra.xmult < 0) then
            return { 
                xmult = card.ability.extra.xmult
            }
        end
        if context.discard and not context.blueprint and not context.retrigger then
            card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
            return {message = 'Upgraded !'}
        end
    end,
}

return jokerInfo
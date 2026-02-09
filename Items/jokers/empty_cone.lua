local jokerInfo = {
    key = "empty_cone",
    pos = {x = 7, y = 4},
    rarity = 1,
    atlas = "PLH",
    cost = 5,
    unlock = true,
    blueprint_compat = true,
    pools = { ["dydb_additions"] = true, ["food"] = true },
    config = { 
        extra = {
            chips = -50,
            chips_mod = 5,
        } 
    },
    
    loc_vars = function (self, info_queue, card)
        return { 
            vars = {
                card.ability.extra.chips,
                card.ability.extra.chips_mod,
            },
        }
    end,
    calculate = function (self, card, context)
		if context.joker_main then
            return { 
                chips = card.ability.extra.chips
            }
        end
        if context.after and not context.blueprint and not context.retrigger then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_mod
            return {message = 'Upgraded !'}
        end
    end,
}

return jokerInfo
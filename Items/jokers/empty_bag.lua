local jokerInfo = {
    key = "empty_bag",
    pos = {x = 6, y = 4},
    rarity = 1,
    atlas = "PLH",
    cost = 5,
    unlock = true,
    blueprint_compat = true,
    pools = { ["dydb_additions"] = true, ["food"] = true },
    config = { 
        extra = {
            mult = -20,
            mult_mod = 5,
        } 
    },
    
    loc_vars = function (self, info_queue, card)
        return { 
            vars = {
                card.ability.extra.mult,
                card.ability.extra.mult_mod,
            },
        }
    end,
    calculate = function (self, card, context)
		if context.joker_main then
            return { 
                mult = card.ability.extra.mult
            }
        end
        if context.setting_blind and not context.blueprint and not context.retrigger then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
            return {message = 'Upgraded !'}
        end
    end,
}

return jokerInfo
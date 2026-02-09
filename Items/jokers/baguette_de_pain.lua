local jokerInfo = {
    key = "baguette",
    pos = {x = 4, y = 1},
    rarity = 1,
    atlas = "PLH",
    cost = 5,
    unlock = true,
    blueprint_compat = true,
    config = { extra = {dollar = 8, dollar_mod = 2}},
    pools = { ["dydb_additions"] = true, ["food"] = true },

    loc_vars = function (self, info_queue, card)
        return { 
            vars = {
                card.ability.extra.dollar,
                card.ability.extra.dollar_mod,
            } 
        }
    end,
    calculate = function (self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval then
            if card.ability.extra.dollar - card.ability.extra.dollar_mod > 0 then 
                ease_dollars(card.ability.extra.dollar)
                card.ability.extra.dollar = card.ability.extra.dollar - card.ability.extra.dollar_mod
                return {
                    message = localize('$') .. (card.ability.extra.dollar + 2),
                    colour = G.C.MONEY
                }
            else
                card:start_dissolve({ HEX("57ecab") }, nil, 0.1)
                return {message = 'Destroyed !', colour = G.C.MULT}
            end
        end
    end,
}

return jokerInfo
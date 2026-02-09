local jokerInfo = {
    key = "mirror2",
    pos = {x = 1, y = 2},
    atlas = "jokers",
    rarity = 2,
    cost = 5,
    unlocked = true,
    blueprint_compat = false,
    pools = { ["dydb_additions"] = true },
    config = { extra = { odds = 4} },

    loc_vars = function(self, info_queue, card)
        return { vars = {(G.GAME.probabilities.normal or 1), card.ability.extra.odds} }
    end,

    calculate = function(self, card, context)
        if context.after and not context.retrigger then
            if pseudorandom('dydb_mirror2') < (G.GAME.probabilities.normal or 1) / card.ability.extra.odds then
                card:start_dissolve({ HEX("57ecab") }, nil, 0.1)
                return {message = 'Destroyed !', colour = G.C.MULT}
            else
                return {message = 'Safe', colour = G.C.GREEN}
            end
        end
        if context.final_scoring_step and not context.retrigger then
            return {
                balance = true
            }
        end
    end,
    in_pool = function(self)
        -- bruh
        if G.GAME.selected_back and G.GAME.selected_back.effect.center.key == 'b_plasma' then
            return false
        end
        return true
    end
}

return jokerInfo

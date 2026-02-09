local jokerInfo = {
    key = "joker_de_janeiro",
    pos = {x = 4, y = 0},
    atlas = "PLH",
    rarity = 2,
    cost = 6,
    unlocked = true,
    blueprint_compat = true,
    pools = { ["dydb_additions"] = true },
    config = { extra = { xchips = 1, chips_mod = 0.1} },
    
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
        return { vars = { 
            card.ability.extra.xchips,
            card.ability.extra.chips_mod
            } 
        }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
        context.other_card and SMODS.has_enhancement(context.other_card, 'm_stone') then
            -- Mise à jour du multiplicateur
            card.ability.extra.xchips = card.ability.extra.xchips + card.ability.extra.chips_mod
            -- Calcul des jetons
            return {
                message = "Amélioré !"
            }
        end
        if context.cardarea == G.jokers and context.joker_main then 
            return {xchips = card.ability.extra.xchips}
        end
    end,

    in_pool = function(self)
        for _, c in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(c, 'm_stone') then
                return true
            end
        end
        return false
    end,
}

return jokerInfo
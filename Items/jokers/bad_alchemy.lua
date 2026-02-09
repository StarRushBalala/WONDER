local jokerInfo = {
    key = "bad_alchemy",
    pos = {x = 1, y = 1},
    atlas = "jokers",
    rarity = 3,
    cost = 9,
    unlocked = true,
    blueprint_compat = false,
    pools = { ["dydb_additions"] = true },
    config = { extra = { gold_x_mult = 1.25, dollar = 2 } },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
        info_queue[#info_queue + 1] = G.P_CENTERS.m_gold
        return { vars = { 
            card.ability.extra.gold_x_mult,
            card.ability.extra.dollar
            } 
        }
    end,

    calculate = function(self, card, context)

        if context.individual and context.other_card then
            if SMODS.has_enhancement(context.other_card, 'm_gold') then
                context.other_card.ability.h_x_mult = card.ability.extra.gold_x_mult
            elseif SMODS.has_enhancement(context.other_card, 'm_steel') then
                context.other_card.ability.h_dollars = card.ability.extra.dollar
            end
        end

        if context.before and context.main_eval and not context.blueprint then
            for _, c in ipairs(G.playing_steel or {}) do
                if SMODS.has_enhancement(c, 'm_steel') then
                    c.context.other_card.ability.h_dollars = card.ability.extra.dollar
                end
            end
            for _, c in ipairs(G.playing_steel or {}) do
                if SMODS.has_enhancement(c, 'm_gold') then
                    c.context.other_card.ability.h_x_mult = card.ability.extra.gold_x_mult
                end
            end
        end
    end,
}

return jokerInfo
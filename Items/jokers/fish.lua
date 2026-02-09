local jokerInfo = {
    key = "fish",
    pos = {x = 8, y = 1},
    rarity = 2,
    atlas = "PLH",
    cost = 5,
    unlock = true,
    blueprint_compat = true,
    config = { extra = {xchips = 2}},
    pools = { ["dydb_additions"] = true },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_dydb_aqua
        return { vars = { card.ability.extra.xchips } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round and
           context.other_card and SMODS.has_enhancement(context.other_card, 'm_dydb_aqua') then
            play_sound('dydb_fish', 1.05, 0.6)
            return {
                xchips = card.ability.extra.xchips,
            }
        end
    end,
}

return jokerInfo
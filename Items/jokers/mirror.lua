local jokerInfo = {
    key = "mirror",
    pos = {x = 0, y = 1},
    atlas = "jokers",
    rarity = 1,
    cost = 5,
    unlocked = true,
    blueprint_compat = false,
    pools = { ["dydb_additions"] = true },
    config = { extra = { } },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
        return { vars = {} }
    end,

    calculate = function(self, card, context)
        if context.before then
            local hand = context.full_hand or context.scoring_hand
            local c1 = hand[1]
            local c2 = hand[2]
            local c4 = hand[#context.scoring_hand - 1]
            local c5 = hand[#context.scoring_hand]
            local function identical(a, b)
                return a.base.value == b.base.value and a.base.suit == b.base.suit
            end

            if identical(c1, c5) or identical(c2, c4) then
                if identical(c1, c5)then
                    c1:set_ability('m_glass', nil, true)
                    c5:set_ability('m_glass', nil, true)
                    return {
                        message = "Changed !",
                        colour = G.C.CHIPS,
                    }
                end
                if identical(c2, c4) then
                    c2:set_ability('m_glass', nil, true)
                    c4:set_ability('m_glass', nil, true)
                    return {
                        message = "Changed !",
                        colour = G.C.CHIPS,
                    }
                end
            end
        end
    end,
}

return jokerInfo

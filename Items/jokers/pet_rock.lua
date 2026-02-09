local jokerInfo = {
    key = "pet_rock",
    pos = {x = 2, y = 0},
    atlas = "jokers",
    rarity = 2,
    cost = 6,
    unlocked = true,
    blueprint_compat = true,
    pools = { ["dydb_additions"] = true },
    config = { extra = { retriggers = 1, plus_retriggers = 2} },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
        return { vars = { 
            card.ability.extra.retriggers,
            card.ability.extra.plus_retriggers,
            } 
        }
    end,

    calculate = function(self, card, context)

        if context.repetition and context.cardarea == G.play and context.other_card then
        
            if SMODS.has_enhancement(context.other_card, 'm_stone') then

                if context.other_card.edition then
                    return {
                        message = 'Again!',
                        repetitions = card.ability.extra.plus_retriggers,
                        card = card,
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
                            card:juice_up(.5, .5)
                        return true end }))	
                    }

                elseif context.other_card.seal then
                    return {
                        message = 'Again!',
                        repetitions = card.ability.extra.plus_retriggers,
                        card = card,
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
                            card:juice_up(.5, .5)
                        return true end }))	
                    }
                else
                    return {
                        message = 'Again!',
                        repetitions = card.ability.extra.retriggers,
                        card = card,
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
                            card:juice_up(.5, .5)
                        return true end }))	
                    }
                end
            end
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
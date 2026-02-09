local jokerInfo = {
    key = "isometric",
    pos = {x = 0, y = 2},
    rarity = 2,
    atlas = "jokers",
    cost = 7,
    unlock = true,
    blueprint_compat = true,
    config = { extra = {retriggers = 2}},
    pools = { ["dydb_additions"] = true },

    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.retriggers } }
    end,
    calculate = function (self, card, context)
        if context.repetition and context.cardarea == G.play and context.other_card then
            if context.other_card.base.id == 3 then
                return {
                    message = 'Again!',
                    repetitions = card.ability.extra.retriggers,
                    card = card,
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
                        card:juice_up(.5, .5)
                    return true end }))	
                }
            elseif context.other_card.base.id == 6 then
                return {
                    message = 'Again!',
                    repetitions = card.ability.extra.retriggers,
                    card = card,
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
                        card:juice_up(.5, .5)
                    return true end }))	
                }
            elseif context.other_card.base.id == 9 then
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
    end,
}

return jokerInfo
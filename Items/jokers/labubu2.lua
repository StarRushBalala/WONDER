local jokerInfo = {
    key = 'labubu2',
    config = {
        extra = {
            x_chips = 1.5,
        }
    },
    rarity = 'dydb_labubu',
    pos = { x = 1, y = 6 },
    atlas = 'PLH',
    cost = 7,
    unlocked = true,
    blueprint_compat = true,
    eternal_compat = true,
    pools = { ["capitalist"] = true },
    tags = { capitalist = true},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_chips,

            }
        }
    end,

    calculate = function(self, card, context)
        if context.other_joker then
            if context.other_joker.config.center.rarity == 'dydb_labubu' and self ~= context.other_joker then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        context.other_joker:juice_up(0.5, 0.5)
                        return true
                    end
                })) 
                return {
                    x_chips = card.ability.extra.x_chips
                }
            end
        end
    end,
}


return jokerInfo
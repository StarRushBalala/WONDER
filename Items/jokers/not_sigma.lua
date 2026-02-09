local jokerInfo = {
    key = "not_sigma",
    pos = { x = 5, y = 2 },
    rarity = 1,
    atlas = "PLH",
    cost = 5,
    unlock = true,
    blueprint_compat = true,
    config = {
        extra = {
            chips = 0,
            chips_mod = 4,
            chips_base = 0,
        },
    },
    pools = { ["dydb_additions"] = true },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.chips_mod,
                card.ability.extra.chips_base,
            },
        }
    end,

    calculate = function(self, card, context)
        -- Per-card evaluation while playing
        if context.individual and context.cardarea == G.play then
            if context.other_card and context.other_card:is_suit('Spades') then
                -- Increase chips on consecutive Spades
                card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_mod
                return {
                    --colour = G.C.chips,
                    message = "Sigma", colour = G.C.CHIPS
                }
            else
                -- Reset if not a Spade
                card.ability.extra.chips = card.ability.extra.chips_base
                return {
                    --colour = G.C.mult,
                    message = "NOT Sigma", colour = G.C.MULT
                }
            end
        end

        -- When Joker is being scored, output current chips
        if context.cardarea == G.jokers and context.joker_main then
            return { chips = card.ability.extra.chips }
        end
    end,
}

return jokerInfo

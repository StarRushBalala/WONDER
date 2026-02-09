local jokerInfo = {
    key = "jack_black",
    pos = {x = 7, y = 0},
    rarity = 2,
    atlas = "PLH",
    cost = 5,
    unlock = true,
    blueprint_compat = true,
    config = { extra = {x_mult = 2}},
    pools = { ["dydb_additions"] = true },

    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.x_mult } }
    end,
    calculate = function (self, card, context)
        if context.cardarea == G.play and context.individual then
            if context.other_card.base.id == 11 and context.other_card:is_suit('Spades') then
                return {x_mult = card.ability.extra.x_mult}
            end
        end
    end,
}

return jokerInfo
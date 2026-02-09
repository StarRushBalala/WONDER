local jokerInfo = {
    key = "banjo",
    pos = {x = 1, y = 7},
    rarity = 1,
    atlas = "PLH",
    cost = 5,
    unlock = true,
    blueprint_compat = true,
    pools = { ["dydb_additions"] = true },
    config = { extra = {
        xchips = 1.5, 
        text2 = "Where did my friend go...?",
    } },

    loc_vars = function (self, info_queue, card)
        return { vars = {card.ability.extra.xchips, card.ability.extra.text1, card.ability.extra.text2} }
    end,
    calculate = function (self, card, context)
        if context.cardarea == G.jokers and context.joker_main then 

            if #SMODS.find_card('j_dydb_kazooie') > 0 then
                card.ability.extra.text2 = "Living my best life !"
                card.ability.extra.xchips = 5
                return {xchips = card.ability.extra.xchips}
            else
                card.ability.extra.text2 = "Where did my friend go...?"
                card.ability.extra.xchips = 1.5
                return {xchips = card.ability.extra.xchips}
            end
        end
    end,
    
}

return jokerInfo
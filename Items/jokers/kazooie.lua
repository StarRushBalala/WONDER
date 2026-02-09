local jokerInfo = {
    key = "kazooie",
    pos = {x = 2, y = 7},
    rarity = 1,
    atlas = "PLH",
    cost = 5,
    unlock = true,
    blueprint_compat = true,
    pools = { ["dydb_additions"] = true },
    config = { extra = {
        xmult = 0.7, 
        text1 = "X", 
        text2 = "Where did my friend go...?",
        state = '1'
    } },

    loc_vars = function (self, info_queue, card)
        return { vars = {card.ability.extra.xmult, card.ability.extra.text1, card.ability.extra.text2} }
    end,
    calculate = function (self, card, context)
        if context.cardarea == G.jokers and context.joker_main then 
            if #SMODS.find_card('j_dydb_banjo') > 0 then
                if card.ability.extra.state == '1' then
                    card.ability.extra.text2 = "Nice ! I hope i'll keep my banjo !"
                    card.ability.extra.text1 = "X"
                    card.ability.extra.xmult = 3
                    card.ability.extra.state = '2'
                    card.children.center:set_sprite_pos({x=0,y=7})
                    return {xmult = card.ability.extra.xmult}
                elseif card.ability.extra.state == '3' then
                    card.ability.extra.text2 = "Nah Im good"
                    card.ability.extra.text1 = "^"
                    card.ability.extra.xmult = 2.5
                    card.children.center:set_sprite_pos({x=0,y=7})
                    return {e_mult = card.ability.extra.xmult}
                end

            else
                if card.ability.extra.state == '1' then
                    card.ability.extra.text2 = "I. NEED. MY. BANJO."
                    card.ability.extra.text1 = "X"
                    card.ability.extra.xmult = 0.7
                    card.children.center:set_sprite_pos({x=2,y=7})
                    return {xmult = card.ability.extra.xmult}
                else
                    card.ability.extra.text2 = "I... Need... It..."
                    card.ability.extra.text1 = "^"
                    card.ability.extra.xmult = 0.5
                    card.ability.extra.state = '3'
                    card.children.center:set_sprite_pos({x=3,y=7})
                    return {e_mult = card.ability.extra.xmult}
                end
            end
        end
    end,
}

return jokerInfo
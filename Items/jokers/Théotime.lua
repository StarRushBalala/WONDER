local jokerInfo = {
    key = "theotime",
    name = "theotime",
    pos = { x = 3, y = 3 },
    soul_pos = {x = 4, y = 3},
    config = {
        extra = { retriggers = 2, side = "right" }, -- commence par la right
        immutable = { max_retriggers = 25 },
    },
    pools = { ['dydb_additions'] =  true },
    tags = { buddies = true},
    rarity = 'dydb_epic',
    cost = 12,
    blueprint_compat = true,
    atlas = "PLH",

    -- Texte affiché dans la description du joker
    loc_vars = function(self, info_queue, center)
        local retrigs = math.min(center.ability.immutable.max_retriggers, center.ability.extra.retriggers)
        local side_txt = (center.ability.extra.side == "left") and "left" or "right"
        return {
            vars = { retrigs, side_txt }
        }
    end,

    calculate = function(self, card, context)
        if context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= self then
            local target_card = nil
            if card.ability.extra.side == "left" then
                target_card = G.jokers.cards[1]
            else
                target_card = G.jokers.cards[#G.jokers.cards]
            end
            if context.other_card == target_card then
                return {
                    message = localize("k_again_ex"),
                    repetitions = to_number(
                        math.min(card.ability.immutable.max_retriggers, card.ability.extra.retriggers)
                    ),
                    card = card,
                }
            end

            return nil, true
        end
        if context.end_of_round then
            play_sound('dydb_fish', 1, 1)
            if card.ability.extra.side == "left" then
                card.ability.extra.side = "right"
                card.children.center:set_sprite_pos({x=3,y=3})
            else
                card.ability.extra.side = "left"
                card.children.center:set_sprite_pos({x=2,y=3})
            end
        end

        if #SMODS.find_card('j_dydb_governor') > 0 then
            card:start_dissolve({ HEX("57ecab") }, nil, 0.1)
        end

    end
}

return jokerInfo


local jokerInfo = {
    key = "cassandra",
    pos = {x = 2, y = 2},
    soul_pos = {x = 3, y = 2},
    rarity = 4,
    atlas = "PLH",
    cost = 20,
    unlock = true,
    blueprint_compat = false,
    tags = { buddies = true},
    pools = { ["dydb_additions"] = true},
    loc_txt = {
        name = "Cassandra",
        text = { 
            "Les cartes {C:attention}Métales{} en main",
            "octroie maintenant {X:purple,C:white}^#1#{} mult."
        }
    },
    config = {
        extra = {
            gold_x_mult = 3,
        }
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
        return {
            vars = {card.ability.extra.gold_x_mult}
        }
    end,
    locked_loc_vars = function(self, info_queue, card)
        return {
            vars = {localize { type = 'name_text', key = 'm_steel', set = 'Enhanced' }},
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.other_card and SMODS.has_enhancement(context.other_card, 'm_steel') then
            context.other_card.ability.h_x_mult = card.ability.extra.gold_x_mult
        end
        if context.before and context.main_eval and not context.blueprint then
            local enhanced_cards = 0
            for _, c in ipairs(G.playing_cards or {}) do
                if SMODS.has_enhancement(c, 'm_steel') then
                    c.ability.h_x_mult = card.ability.extra.gold_x_mult
                end
            end
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        for _, c in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(c, 'm_steel') then
                c.ability.h_e_mult = 3
            end
        end
    end,
}

return jokerInfo
local jokerInfo = {
    key = "absolute_joker",
    pos = {x = 6, y = 1},
    soul_pos = {x = 7, y = 1},
    rarity = 1,
    atlas = "PLH",
    cost = 5,
    unlock = true,
    blueprint_compat = true,
    config = { extra = {money = 9}},
    pools = { ["dydb_additions"] = true },
    loc_txt = {
        name = "Absolute {s:1.4}JOKER",
        text = { 
            "{C:inactive}Ne fait rien pour le moment."
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.money } }
    end,
    calculate = function(self, card, context)
        if context.first_hand_drawn then
            local eval = function() return G.GAME.current_round.hands_left <= 1 end
        end
        
        if context.end_of_round and context.game_over == false and context.main_eval then
            if G.GAME.current_round.hands_left == 0 then
                ease_dollars(card.ability.extra.money)
                return {
                    message = localize('$') .. card.ability.extra.money,
                    colour = G.C.MONEY
                }
            end
        end
    end
}

return jokerInfo
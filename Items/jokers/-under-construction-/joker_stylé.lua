local jokerInfo = {
    key = "joker_stylé",
    pos = {x = 9, y = 1},
    rarity = 2,
    atlas = "PLH",
    cost = 5,
    unlock = true,
    blueprint_compat = true,
    config = { 
        extra = {
            payout = 1
        }
    },
    pools = { ["dydb_additions"] = true },
    loc_txt = {
        name = "stylé",
        text = { 
            "Chaque {C:attention}Joker{}",
            "donne {C:money}+1${}."
        }
    },
    loc_vars = function(self, info_queue, center)
        return {  
            vars = {
                (G.jokers and G.jokers.cards and #G.jokers.cards or 0),
                self.config.extra.payout  -- safe: always exists
            }
        }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and not context.retrigger_joker then
            local k = 0
            if G.jokers and G.jokers.cards then
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i].ability.set == 'Joker' then 
                        k = k + 1 
                    end
                end
            end
            self.config.extra.payout = k*self.config.extra.payout
            return {
                nil
                --message = "bling bling",
                --dollars = self.config.extra.payout,
            }
        end
    end,

    calc_dollar_bonus = function(self,card)
        return self.config.extra.payout
    end,
}

return jokerInfo
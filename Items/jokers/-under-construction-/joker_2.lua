local jokerInfo = {
    key = 'joker2',
    atlas = 'PLH',
    rarity = 3,
    cost = 37,
    pos = {x=6, y= 0},
    config = { extra = {payout = 0}},
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    pools = { ["dydb_additions"] = true },
    loc_txt= {
        name = 'Joker 2',
        text = {
            "Copyright le joker à sa gauche",
            "quand la {C:attention}Blind{} est séléctionné, puis ajoute",
            "un quart de sa {C:attention}valeur de vente{} au",
            "paiement de fin de manche du {C:attention}Joker{}",
            "{C:inactive}(Actuellement {C:attention}$#1#{C:inactive})"
        }
    },
    pools = { ["dydb_additions"] = true },
    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.payout}  }
	end,
    calculate = function(self, card, context)
    if context.end_of_round and and context.cardarea == G.joker and not context.retrigger_joker then
        local _myid
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] == card then
                _myid = i
            end
        end
        if G.jokers.cards[_myid - 1] then
            if G.jokers.cards[_myid - 1].ability.eternal ~= true then
                _cardeaten = G.jokers.cards[_myid - 1]
                card.ability.extra.payout = card.ability.extra.payout + math.max(1,math.floor(_cardeaten.sell_cost/4))
                _cardeaten.getting_sliced = true
                _cardeaten:start_dissolve()
                _cardeaten = nil
                return{message = "Copyrighted",}
            end
        end
    end
end,

    calc_dollar_bonus = function(self,card)
        return card.ability.extra.payout
    end,
}

return jokerInfo
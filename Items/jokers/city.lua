local jokerInfo = {
    key = "city",
    pos = {x = 7, y = 1},
    rarity = 2,
    atlas = "jokers",
    cost = 6,
    unlock = true,
    blueprint_compat = true,
    config = { extra = {chips = 0, chips_mod = 20, house = " "}},
    pools = { ["dydb_additions"] = true },

    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.chips_mod, card.ability.extra.house } }
    end,

    calculate = function (self, card, context)
		if context.joker_main and context.poker_hands and next(context.poker_hands["Full House"]) then
			card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_mod
            return { 
                chips = card.ability.extra.chips
            }
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        card.children.center:set_sprite_pos({x=7,y=2})
        card.ability.extra.house = "Did someone say House ?"
    end,
    remove_from_deck = function(self, card, from_debuff)
        card.children.center:set_sprite_pos({x=7,y=1})
        card.ability.extra.house = " "
    end
}

return jokerInfo
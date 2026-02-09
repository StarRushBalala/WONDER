local jokerInfo = {
    key = "robin",
    pos = {x = 2, y = 1},
    soul_pos = { x = 5, y = 3},
    rarity = 4,
    atlas = "PLH",
    cost = 20,
    blueprint_compat = true,
    pools = { ["dydb_additions"] = true},
    tags = { buddies = true},
	config = { 
        extra = { 
            Emult = 1,
            Emult_mod = 0.05,
        } 
    },
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
		return {
			vars = {
				number_format(center.ability.extra.Emult),
                number_format(center.ability.extra.Emult_mod),
			},
		}
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
        context.other_card and SMODS.has_enhancement(context.other_card, 'm_stone') then
            -- Mise à jour du multiplicateur
            card.ability.extra.Emult = card.ability.extra.Emult + card.ability.extra.Emult_mod
            return {
                message = 'kayou', colour = G.C.DARK_EDITION
            }
        end
        if context.cardarea == G.jokers and context.joker_main and (lenient_bignum(card.ability.extra.Emult) > 1) then 
            return {
                Emult_mod = lenient_bignum(card.ability.extra.Emult),
                message = localize({
				type = "variable",
				key = "a_powmult",
                colour = G.C.DARK_EDITION,
				vars = { number_format(card.ability.extra.Emult) },
				}),
            }
        end
    end,

    in_pool = function(self)
        for _, c in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(c, 'm_stone') then
                return true
            end
        end
        return false
    end,
}

return jokerInfo

local jokerInfo = {
    key = "constellation",
    config = {
        extra = {
            e_mult = 1.3,
            suit = 'dydb_Stars'
        }
    },
    pos = { x = 7, y = 3 },
    rarity = 3,
    cost = 7,
    blueprint_compat = true,
    atlas = "PLH",
    pools = { ["dydb_additions"] = true },
    unlock = true,
    dydb = {
        requires_stars = true
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.e_mult } }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            local hand = context.scoring_hand or context.full_hand
            if not hand then return end
            if #hand ~= 5 then
                return
            end
            for _, c in ipairs(hand) do
                local suit = (c.base and c.base.suit) or c.suit or (c.config and c.config.suit)
                if suit ~= "dydb_Stars" then
                    return
                end
            end
            return {
                	message = localize({
					type = "variable",
					key = "a_powmult",
					vars = {
						number_format(card.ability.extra.e_mult),
					},
				}),
				Emult_mod = lenient_bignum(card.ability.extra.e_mult),
				colour = G.C.DARK_EDITION,
                card = card,
            }
        end
    end,
}

return jokerInfo


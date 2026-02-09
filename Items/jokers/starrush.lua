local jokerInfo = {
    key = "starrush",
    pos = {x = 0, y = 8},
    soul_pos = { x = 1, y = 8, extra = { x = 2, y = 8 } },
    rarity = 'dydb_epic',
    atlas = "PLH",
    cost = 12,
    unlock = true,
    blueprint_compat = true,
    pools = { ["dydb_additions"] = true },
    config = { extra = { eemult_mod = 0.1} },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.eemult_mod, card.ability.extra.eemult_mod * Dumb_yet_Dumber.member_count, }, }
    end,
    calculate = function(self, card, context)
        if (context.joker_main and card.ability.extra.eemult_mod * Dumb_yet_Dumber.member_count > 1) then
			return {
				eemult = card.ability.extra.eemult_mod * Dumb_yet_Dumber.member_count,
				eemult_message = {
					message = "^^" .. number_format(card.ability.extra.eemult_mod * Dumb_yet_Dumber.member_count) .. " Mult",
					colour = G.C.EDITION,
					sound = "talisman_eemult"
				}
			}
        end
    end,
}

return jokerInfo
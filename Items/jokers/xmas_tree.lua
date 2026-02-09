local jokerInfo = {
    key = "xmas_tree",
    pos = {x = 0, y = 4},
    rarity = 'dydb_epic',
    atlas = "PLH",
    cost = 5,
    unlock = true,
    blueprint_compat = true,
    pools = { ["dydb_additions"] = true },
    config = { 
        extra = {
        } 
    },
    Dumb_yet_Dumber = {
    	requires_stars = true
  	},
    
    loc_vars = function (self, info_queue, card)
        return { 
            vars = {
            } 
        }
    end,
    calculate = function (self, card, context)

        --if context.setting_blind then           -- reset
            --card.ability.extra.remaining = 1
        --end

		if context.before and not context.blueprint and G.GAME.current_round.hands_played == 0 then
            local hand = context.scoring_hand or context.full_hand  -- ne retourne rien si la main ne fait pas 1 cartes
            if not hand then return end
            if #hand ~= 1 then
                return
            end

			for _, card in ipairs(context.scoring_hand) do          -- change les cartes change_base(card, suit, rank)
				assert(SMODS.change_base(card, 'dydb_Stars', "Ace"))
			end

            --card.ability.extra.remaining = 0

			return {
				message = "Changed !",
				colour = G.C.STAR,
			}
		end
    end,
}

return jokerInfo
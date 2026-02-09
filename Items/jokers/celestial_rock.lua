local jokerInfo = {
	key = "celestial_rock",
	pos = { x = 1, y = 3 },
	config = {
    	extra = {
      		xchips = 2.5,
      		suit = 'dydb_Stars'
    	}
  	},
	pools = { ["dydb_additions"] = true },
	rarity = 2,
	cost = 6,
	blueprint_compat = true,
	atlas = "PLH",
	Dumb_yet_Dumber = {
    	requires_stars = true
  	},

  	loc_vars = function(self, info_queue, card)
    	return {
      		vars = {
        		card.ability.extra.xchips,
      		}
    	}
  	end,
	calculate = function(self, card, context)
        if context.cardarea == G.play and context.individual then
            if context.other_card:is_suit('dydb_Stars') then
            	return {xchips = lenient_bignum(card.ability.extra.xchips)}
			end
        end
    end,
}

return jokerInfo
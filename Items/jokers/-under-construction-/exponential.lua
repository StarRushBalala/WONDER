local jokerInfo = {
	key = "exponential",
	config = {
		extra = {
			Emult = math.pi,
			Echips = math.pi,
		},
	},
	pos = { x = 8, y = 2 },
	rarity = 'dydb_ascendant',
	cost = 50,
	blueprint_compat = true,
	atlas = "PLH",
    pools = { ["dydb_additions"] = true },
    unlock = true,
    loc_txt = {
        name = {
            "{s:1.3}I'M OUT!{}",
            "{C:mult,s:0.7}1.3 seconds{}",
        },
        text = { 
            "{X:mult,C:chips}^#2#{} mult et",
            "{X:chips,C:mult}^#1#{} chips",
        },
    },
    loc_vars = function(self, info_queue, center)
		return {
			vars = {
				number_format(center.ability.extra.Echips),
				number_format(center.ability.extra.Emult),
			},
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			local pi = math.pi
			return {
				Echip_mod = pi,
				Emult_mod = pi,
				message = localize({
					type = "variable",
					key = "a_powmultchips",
					vars = { number_format(card.ability.extra.Emult), number_format(card.ability.extra.Echips) },
				}),
			}
		end
	end,
}

return jokerInfo
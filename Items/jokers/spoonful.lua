local jokerInfo = {
	key = 'spoonful',
	loc_txt = {
		name = 'Paupovlin "Poppin" Revere',
		text = {
			'You can choose {C:attention}any number of cards',
			'after opening {C:attention}any Booster Pack',
		}
	},
	config = {extra = {extrachoices = 0}},
	pos = { x = 4, y = 4 },
	cost = 12,
	rarity = 'dydb_epic',
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	atlas = 'PLH',
    loc_vars = function(self, info_queue, center)
        return {vars = {}}
    end,
	calculate = function(self, card, context)
        if context.open_booster and not context.blueprint and not context.retrigger then
			play_sound("dydb_ice_cream", 1, 0.7)
			return {
				message = 'Hey dog',
				message = 'Can i get',
				message = 'Some ice cream ?',
			}
		end
	end,
}

return jokerInfo
plh_choices = {'Tarot', 'Planet', 'Spectral'}

SMODS.Booster {
	key = "plh_pack",
	kind = 'dydb_plh',
	atlas = "PLH2",
	pos = { x = 6, y = 1 },
	order = 5,
	config = { extra = 6, choose = 2 },
	cost = 10,
	weight = 1,
	draw_hand = true,
	create_card = function(self, card)
		return create_card(pseudorandom_element(plh_choices, pseudoseed('dydb_plh_pack')), G.pack_cards, nil, nil, true, true, nil, "dydb_plh_pack")
	end,
	ease_background_colour = function(self)
		ease_colour(G.C.COOL_BLACK, G.C.COOL_BLACK)
		ease_background_colour({ new_colour = G.C.COOL_BLACK, special_colour = G.C.COOL_BLACK, contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.choose, card.ability.extra } }
	end, 
	loc_txt = {
		name = "Idk-yet Pack",
		text = {
            {
			    "Choose {C:attention}#1#{} of up to {C:attention}#2#{}",
			    "{C:purple}Tarot{}, {C:planet}Planet{} or {C:spectral}Spectral{}",
			    "Cards to be used immediately",
            }, 
		},
	},
	update_pack = function(self, dt)
		ease_colour(G.C.COOL_BLACK, G.C.COOL_BLACK)
		ease_background_colour({ new_colour = G.C.COOL_BLACK, special_colour = G.C.COOL_BLACK, contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
	group_key = "k_dydb_plh_pack",

}
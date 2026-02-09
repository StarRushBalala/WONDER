SMODS.Booster {
	key = "shiny_pack1",
	kind = 'dydb_shiny',
	atlas = "PLH2",
	pos = { x = 4, y = 1 },
	config = { extra = 3, choose = 1 },
	cost = 6,
	weight = 0.9,
	draw_hand = false,
	particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.3,
            initialize = true,
            lifespan = 3,
            speed = 0.2,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { HEX('85FFC8'), G.C.WHITE },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        local _edition = poll_edition('dydb_shiny' .. G.GAME.round_resets.ante, 2, true, true)
        local _seal = SMODS.poll_seal({ mod = 10, guaranteed = true })
        local _enhance = SMODS.poll_enhancement({ guaranteed = true })
        return {
            set = "Playing Card",
            edition = _edition,
            seal = _seal,
            enhancement = _enhance,
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append = 'dydb_shiny'
        }
    end,
	ease_background_colour = function(self)
		ease_colour(G.C.STAR, G.C.COOL_BLACK)
		ease_background_colour({ new_colour = G.C.COOL_BLACK, special_colour = HEX('85FFC8'), contrast = 2 })
	end,
	loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
		return { vars = { cfg.choose, cfg.extra } }
	end, 
	loc_txt = {
		name = "Shiny Pack",
		text = {
			"Choose {C:attention}#1#{} of",
			"up to {C:attention}#2# Playing Cards{}",
            "with random {C:dark_edition}Enhancements{},", 
            "{C:dark_edition}Editions{} and {C:dark_edition}Seals{}", 
			"to be added to deck"
		},
	},
	update_pack = function(self, dt)
		ease_colour(G.C.STAR, G.C.BLACK)
		ease_background_colour({ new_colour = G.C.BLACK, special_colour = HEX('85FFC8'), contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
	group_key = "k_dydb_shiny_pack",
}

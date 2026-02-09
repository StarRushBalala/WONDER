SMODS.Booster{
    key = 'purgatorio_booster',
    atlas = "PLH2",
    pos = {x = 3, y = 1},
    config = {
        extra = 2,
        choose = 1
    },
    groupe_key = "purgatorio_cons",
    cost = 20,
    weight = 0.5,
    draw_hand = false,
    kind = "Purgatorio_pack",
    loc_txt = {
        name = "Purgatorio Pack",
        text = { "Choose {C:attention}#1#{} out of",
                "{C:attention}#2#{} purgatorio cards.", },
        group_name = {"Choose your Demise"},
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,

	particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.01,
            scale = 0.1,
            initialize = true,
            lifespan = 8,
            speed = 3,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = {G.C.WHITE },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,

    ease_background_colour = function(self)
		ease_colour(G.C.STAR, G.C.COOL_BLACK)
		ease_background_colour({ new_colour = HEX('bde0fe'), special_colour = HEX('ffc8dd'), contrast = 3 })
	end,

	update_pack = function(self, dt)
		ease_colour(G.C.STAR, G.C.COOL_BLACK)
		ease_background_colour({ new_colour = HEX('ffc8dd'), special_colour = HEX('bde0fe'), contrast = 3 })
		SMODS.Booster.update_pack(self, dt)
	end,

    create_card = function(self, card)
        return {
            set = "purgatorio", 
            area = G.pack_cards, 
            skip_materialize = true, 
            soulable = true, 
            key_append = "pref", 
            edition = nil,
        }
    end,
    select_card = 'consumeables',

    in_pool = function() return true end
}
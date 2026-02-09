SMODS.Booster{
    key = 'mega_dumb_booster',
    atlas = "PLH2",
    pos = {x = 0, y = 1},
    config = {
        extra = 5,
        choose = 2
    },
    groupe_key = "dydb_additions",
    cost = 12,
    weight = 0.5,
    draw_hand = false,
    kind = "WonderPack",
    loc_txt = {
        name = "Wonderful Pack",
        text = { "Choose {C:attention}#1#{} out of {C:attention}#2#{}",
                "Wonder Jokers", },
        group_name = {"Wonderful Pack"},
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,

	particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.02,
            scale = 0.15,
            initialize = true,
            lifespan = 4,
            speed = 0.8,
            padding = 1,
            attach = G.ROOM_ATTACH,
            colours = {G.C.WHITE},
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,

    ease_background_colour = function(self)
		ease_colour(G.C.EPIC, G.C.ASCENDANT)
		ease_background_colour({ new_colour = G.C.STAR, special_colour = G.C.STAR, contrast = 2 })
	end,

	update_pack = function(self, dt)
    ease_colour(G.C.EPIC, G.C.ASCENDANT)
		ease_background_colour({ new_colour = G.C.STAR, special_colour = G.C.STAR, contrast = 2 })
		SMODS.Booster.update_pack(self, dt)
	end,
    create_card = function(self, card)
        return {
            set = "dydb_additions", 
            area = G.pack_cards, 
            skip_materialize = false, 
            soulable = false, 
            key_append = "mdb", 
            edition = nil
        }
    end,
    select_card = 'jokers',

    in_pool = function() return true end
}
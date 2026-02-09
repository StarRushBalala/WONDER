SMODS.Sound({
    key = "music", 
    path = "music_i_made_;3.ogg",
    pitch = 0.8,
    volume = 0.6,
    select_music_track = function()
        if G.STATE == G.STATES.SMODS_BOOSTER_OPENED then
            if G.pack_cards
                and G.pack_cards.cards
                and G.pack_cards.cards[1]
                and G.pack_cards.cards[1].config
                and G.pack_cards.cards[1].config.center
                and G.pack_cards.cards[1].config.center.mod
                and G.pack_cards.cards[1].config.center.mod.id 
                and G.pack_cards.cards[1].config.center.mod.id == "Dumb_yet_Dumber" then
		        return true 
            end
        end
	end,
})

SMODS.Booster{
    key = 'tu_préferes',
    atlas = "PLH2",
    pos = {x = 2, y = 1},
    config = {
        extra = 2,
        choose = 1
    },
    groupe_key = "dydb_additions",
    cost = 4,
    weight = 3,
    draw_hand = false,
    kind = "WonderPack",
    loc_txt = {
        name = "Would ou Rather ?",
        text = { "Choose {C:attention}#1#{} out of {C:attention}#2#{}",
                "Wonder Jokers", },
        group_name = {"Would you Rather ?"},
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
            key_append = "pref", 
            edition = true,
        }
    end,
    select_card = 'jokers',

    in_pool = function() return true end
}
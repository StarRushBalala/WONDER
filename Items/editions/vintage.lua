
SMODS.Shader({key = 'sepia', path = 'sepia.fs'})

local editionInfo = {
    key = "vintage",
    shader = "sepia",
    config = { retriggers = 2 },
    in_shop = true,
    weight = 3, 
    extra_cost = 5,
    apply_to_float = true,
    label = "Vintage",
	sound = {
		sound = "dydb_e_vintage",
		per = 1,
		vol = 0.8,
	},
    
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.retriggers } }
    end,
    get_weight = function(self)
        return (G.GAME.edition_rate - 1) * G.P_CENTERS["e_negative"].weight + G.GAME.edition_rate * self.weight
    end,
    calculate = function(self, card, context)
        -- Pour les cartes à jouer
        if context.repetition_only or (context.retrigger_joker_check and context.other_card == card) then
            return {
                repetitions = card.edition.retriggers,
                card = card,
                colour = G.C.DARK_EDITION,
                play_sound("dydb_e_vintage", 1, 0.8)
            }
        end

        -- Pour les Jokers pendant le scoring principal
        if context.joker_main and card.edition and card.edition.key == "e_dydb_vintage" then
            return {
                repetitions = self.config.retriggers,
                card = card,
                colour = G.C.DARK_EDITION,
                play_sound("dydb_e_vintage", 1, 0.8)
            }
        end
    end
}

return editionInfo
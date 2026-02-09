
SMODS.Shader({key = 'whatsapp', path = 'whatsapp.fs'})

local editionInfo = {
    key = "whatsapp",
    order = 2,
    weight = 10,
    shader = "whatsapp",
    in_shop = true,
    extra_cost = 3,
    config = {extra = {odds = 2}},
    sound = {
        sound = "dydb_e_whatsapp",
        per = 1,
        vol = 0.6,
    },
	get_weight = function(self)
		return G.GAME.edition_rate * self.weight
	end,
    loc_vars = function(self, info_queue)
        return { vars = {  '2' } }
    end,
    calculate = function(self, card, context)
        if context.mod_probability then
            return {
                numerator = context.numerator * 2
            }
        end
        if (context.edition and context.cardarea == G.jokers and card.config.trigger) then
           --or (context.main_scoring and context.cardarea == G.play) then
            return { play_sound('dydb_e_whatsapp', 1, 1) }
        end
        
        if context.joker_main then
            card.config.trigger = true
        end

        if context.after then
            card.config.trigger = nil
        end
    end
}

return editionInfo

SMODS.Shader({ key = 'astral', path = 'astral.fs' })

local editionInfo = {
	key = "galactic",
	weight = 3,
	shader = "astral",
	in_shop = true,
	extra_cost = 5,
    apply_to_float = true,
	sound = {
		sound = "dydb_e_galactic",
		per = 1,
		vol = 0.8,
	},

	get_weight = function(self)
		return G.GAME.edition_rate * self.weight
	end,
	config = { e_mult = 1.1, trigger = nil },
	loc_vars = function(self, info_queue, card)
		return { vars = { card and card.edition and card.edition.e_mult or self.config.e_mult} }
	end,
	calculate = function(self, card, context)
		if
			(
				context.edition -- for when on jonklers
				and context.cardarea == G.jokers -- checks if should trigger
				and card.config.trigger -- fixes double trigger
			) or (
				context.main_scoring -- for when on playing cards
				and context.cardarea == G.play
			)
		then
			return { 
                e_mult = card and card.edition and card.edition.e_mult or self.config.e_mult,
				play_sound("dydb_e_galactic", 1, 0.8)
            } -- updated value
		end
		if context.joker_main then
			card.config.trigger = true -- context.edition triggers twice, this makes it only trigger once (only for jonklers)
		end

		if context.after then
			card.config.trigger = nil
		end
	end,
}

return editionInfo
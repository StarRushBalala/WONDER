SMODS.Shader({key = 'misprint', path = 'misprint.fs'})

local editionInfo = {
	key = "misprint",
	weight = 15,
	shader = "misprint",
	in_shop = true,
	extra_cost = 0,
	sound = {
		sound = "dydb_e_misprint",
		per = 1,
		vol = 0.25,
	},
	get_weight = function(self)
		return G.GAME.edition_rate * self.weight
	end,
	-- Note: Duping playing cards resets the base chips for some reason
	on_apply = function(card)
		if not card.ability.dydb_misprint then
			Cryptid.manipulate(card, {
				min = 0.01,
				max = 23,
			})

			if card.config.center.apply_glitched then
				card.config.center:apply_glitched(card, function(val)
					return Cryptid.manipulate_value(val, {
						min = 0.1 * (G.GAME.modifiers.cry_misprint_min or 1),
						max = 23 * (G.GAME.modifiers.cry_misprint_max or 1),
						type = "X",
					}, Cryptid.is_card_big(card))
				end)
			end
		end
		card.ability.dydb_misprint = true
	end,
	on_remove = function(card)
		Cryptid.manipulate(card, { min = 1, max = 1, dont_stack = true })
		Cryptid.manipulate(card) -- Correct me if i'm wrong but this is for misprint deck. or atleast it is after this patch
		card.ability.dydb_misprint = nil
	end,
}

return editionInfo
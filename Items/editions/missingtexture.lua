
SMODS.Shader({key = 'missingtexture', path = 'missingtexture.fs'})

local editionInfo = {
	key = "misstext",
	weight = 5,
	shader = "missingtexture",
	in_shop = true,
	extra_cost = 5,
	sound = {
		sound = "dydb_e_misprint",
		per = 1,
		vol = 0.5,
	},
	get_weight = function(self)
		return G.GAME.edition_rate * self.weight
	end,
	-- Note: Duping playing cards resets the base chips for some reason
	on_apply = function(card)
		if not card.ability.dydb_misstext then
			Cryptid.manipulate(card, {
				value = 4,
			}, nil, true)
			--[[if card.config.center.apply_misstext then
				card.config.center:apply_misstext(card, function(val)
					return Cryptid.misprintize_val(val, {
						min = 2 * (G.GAME.modifiers.cry_misprint_min or 1),
						max = 2 * (G.GAME.modifiers.cry_misprint_max or 1),
					}, Cryptid.is_card_big(card))
				end)
			end]]
		end
		card.ability.dydb_misstext = true
	end,
	on_remove = function(card)
		Cryptid.manipulate(card, { value = 1 / 2 })
		Cryptid.manipulate(card) -- Correct me if i'm wrong but this is for misprint deck. or atleast it is after this patch
		card.ability.dydb_misstext = nil
	end,
	--[[init = function(self)
		AurinkoAddons.dydb_misstext = function(card, hand, instant, amount)
			G.GAME.hands[hand].chips = math.max(G.GAME.hands[hand].chips + (G.GAME.hands[hand].l_chips * amount), 0)
			G.GAME.hands[hand].mult = math.max(G.GAME.hands[hand].mult + (G.GAME.hands[hand].l_mult * amount), 1)
			if not instant then
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.3,
					func = function()
						play_sound("chips1")
						card:juice_up(0.8, 0.5)
						return true
					end,
				}))
				update_hand_text({ delay = 1.3 }, { chips = G.GAME.hands[hand].chips, StatusText = true })
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.3,
					func = function()
						play_sound("multhit1")
						card:juice_up(0.8, 0.5)
						return true
					end,
				}))
				update_hand_text({ delay = 1.3 }, { mult = G.GAME.hands[hand].mult, StatusText = true })
			elseif Aurinko.VerboseMode then
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.2,
					func = function()
						play_sound("chips1")
						card:juice_up(0.8, 0.5)
						return true
					end,
				}))
				update_hand_text(
					{ delay = 1.3 },
					{ chips = (to_big(amount) > to_big(0) and "++" or "--"), StatusText = true }
				)
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.2,
					func = function()
						play_sound("multhit1")
						card:juice_up(0.8, 0.5)
						return true
					end,
				}))
				update_hand_text(
					{ delay = 1.3 },
					{ mult = (to_big(amount) > to_big(0) and "++" or "--"), StatusText = true }
				)
			end
		end
	end,]]
}

return editionInfo
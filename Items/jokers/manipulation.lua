local jokerInfo = {
	key = "chernobyl",
	pos = { x = 0, y = 3 },
	immutable = true,
	rarity = 3,
	blueprint_compat = true,
	demicoloncompat = true,
	cost = 10,
	config = { extra = {manip = 2}},
	atlas = "jokers",
	loc_vars = function(self, info_queue, card)
		card.ability.blueprint_compat_ui = card.ability.blueprint_compat_ui or ""
		card.ability.blueprint_compat_check = nil

		return {
			main_end = (card.area and card.area == G.jokers) and {
				{
					n = G.UIT.C,
					config = { align = "bm", minh = 0.4 },
					nodes = {
						{
							n = G.UIT.C,
							config = {
								ref_table = card,
								align = "m",
								colour = G.C.JOKER_GREY,
								r = 0.05,
								padding = 0.06,
								func = "blueprint_compat",
							},
							nodes = {
								{
									n = G.UIT.T,
									config = {
										ref_table = card.ability,
										ref_value = "blueprint_compat_ui",
										colour = G.C.UI.TEXT_LIGHT,
										scale = 0.32 * 0.8,
									},
								},
							},
						},
					},
				},
			} or nil,
			vars = {
				card.ability.extra.manip,
			}
		}
	end,
	update = function(self, card, front)
		if G.STAGE == G.STAGES.RUN then
			if not G.jokers then return nil end
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					local left_joker = G.jokers.cards[1]
					other_joker = G.jokers.cards[1]
					if left_joker and left_joker ~= card and not (Card.no(left_joker, "immutable", true)) then
						card.ability.blueprint_compat = "compatible"
					else
						card.ability.blueprint_compat = "incompatible"
					end
				end
			end
		end
	end,
	calculate = function(card, card2, context)
		if (context.selling_self and not context.repetition and not context.individual) then
			local check = false
			local left_joker = nil
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					left_joker = G.jokers.cards[1]
					break
				end
			end
			if not Card.no(G.jokers.cards[1], "immutable", true) then
				Cryptid.manipulate(G.jokers.cards[1], { value = 2 })
				check = true
			end
			if check then
				card_eval_status_text(
					context.blueprint_card or card2,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("k_upgrade_ex"), colour = G.C.GREEN }
				)
			end
			return nil, true
		end
	end,
}

return jokerInfo
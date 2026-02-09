local jokerInfo = {
	key = "mistrust",
	pos = { x = 1, y = 2 },
	config = { extra = { 
		active = "Missing Ingredient : ???",
		increase = 1.5,
	} },
	pools = { ["dydb_additions"] = true },
	rarity = "dydb_ascendant",
	cost = 10,
	blueprint_compat = false,
	atlas = 'PLH',

	loc_vars = function(self, info_queue, card)
		card.ability.blueprint_compat_ui = card.ability.blueprint_compat_ui or ""
		card.ability.blueprint_compat_check = nil
		return {
			vars = { card.ability.extra.active, card.ability.extra.increase },
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
		}
	end,
	update = function(self, card, front)
		if G.STAGE == G.STAGES.RUN then
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					other_joker = G.jokers.cards[i - 1]
				end
			end
			if other_joker and other_joker ~= card and not (Card.no(other_joker, "immutable", true)) then
				card.ability.blueprint_compat = "compatible"
			else
				card.ability.blueprint_compat = "incompatible"
			end
		end
	end,
	calculate = function(self, card, context)
		if
			(context.end_of_round and not context.repetition and not context.individual and not context.blueprint)
			or context.forcetrigger
		then
			local check = false
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					if i < #G.jokers.cards then
						if not Card.no(G.jokers.cards[i - 1], "immutable", true) then
							check = true
							Cryptid.manipulate(G.jokers.cards[i - 1], { value = card.ability.extra.increase })
						end
					end
				end
			end
			if check then
				card_eval_status_text(
					card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("k_upgrade_ex"), colour = G.C.GREEN }
				)
			end
		end

		if #SMODS.find_card('j_dydb_manipulation') > 0 then
			card.ability.extra.active = "Ritual is ready to beggin."
			if context.selling_self then
				local used_consumable = copier or card
				local deletable_jokers = {'j_dydb_manipulation', 'j_dydb_mistrust'}
				local chosen_joker = {'j_dydb_manipulation', 'j_dydb_mistrust'}
				local _first_dissolve = nil
				G.E_MANAGER:add_event(Event({
					trigger = "before",
					delay = 0.75,
					func = function()
						for k, v in pairs(deletable_jokers) do
							if v == chosen_joker then
								v:start_dissolve(nil, _first_dissolve)
								_first_dissolve = true
							end
						end
						return true
					end,
				}))

				G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.4,
				func = function()
					play_sound("timpani")
					local card = create_card("Joker", G.jokers, nil, nil, nil, nil, 'j_dydb_not_oil_lamp', "dydb_mistrust")
					card:add_to_deck()
					G.jokers:emplace(card)
					card:juice_up(0.3, 0.5)
					return true
				end,
			}))
			delay(0.6)
			debuff = true
			end
		else
			card.ability.extra.active = "Missing Ingredient : ???"
		end
	end,
}

return jokerInfo
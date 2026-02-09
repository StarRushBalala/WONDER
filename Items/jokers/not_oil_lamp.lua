local jokerInfo = {
    key = "not_oil_lamp", --This is mostly just taken straight from oil lamp's code
    pos = { x = 7, y = 5 },
    soul_pos = { x = 9, y = 5, extra = { x = 8, y = 5 } },
    config = { extra = { increase = 1.5, active = "Missing Ingredient : a Chernobyl's incident fanatic"} },
    rarity = "dydb_ascendant",
    cost = 50,
    blueprint_compat = false,
    immutable = true,
    atlas = "PLH",
    loc_vars = function(self, info_queue, card)
        card.ability.blueprint_compat_ui = card.ability.blueprint_compat_ui or ""
        card.ability.blueprint_compat_check = nil
        return {
            vars = {
                card.ability.extra.increase,
                card.ability.extra.active,
            },
        }
    end,
    calculate = function(self, card, context)
        if 
            context.end_of_round 
            and not context.individual 
            and not context.after 
            and not context.before 
            and not context.blueprint 
            and not context.retrigger 
            and context.cardarea == G.jokers
        then
            local check = false
            for i = 1, #G.jokers.cards do
                if not (G.jokers.cards[i] == card) then
                    if not Card.no(G.jokers.cards[i], "immutable", true) then
                        check = true
                        Cryptid.with_deck_effects(G.jokers.cards[i], function(cards)
                            Cryptid.manipulate(G.jokers.cards[i], { value = card.ability.extra.increase })
                        end)
                    end
                end
            end
            if check then
                card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_upgrade_ex"), colour = G.C.GREEN })
            end
        end

		if #SMODS.find_card('j_dydb_noah') > 0 then
			card.ability.extra.active = "Ritual is ready to beggin."
			if context.selling_self then
				G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.4,
				func = function()
					play_sound("timpani")
					local card = create_card("Joker", G.jokers, nil, nil, nil, nil, 'j_dydb_jo', "dydb_not_oil_lamp")
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
			card.ability.extra.active = "Missing Ingredient : a Chernobyl's incident fanatic"
		end

    end,
}

return jokerInfo
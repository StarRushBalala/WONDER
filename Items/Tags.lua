SMODS.Tag{
    key = 'dumb',
    atlas = 'tags',
    pos = { x = 3, y = 0 },
    min_ante = nil,

    apply = function(self, tag, context)
        tag:yep('+', G.C.DARK_EDITION, print() )

            local card = create_card("dydb_additions", G.Jokers, nil, nil, nil, nil, nil, nil)
            card:add_to_deck()
            G.jokers:emplace(card)

        tag.triggered = true
        return true
    end,
}

SMODS.Tag {
    key = 'vintage_tag',
    atlas = 'tags',
    pos = { x = 1, y = 0 },
    min_ante = 2,
	loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = G.P_CENTERS.e_dydb_vintage
		return { vars = {} }
	end,
	apply = function(self, tag, context)
		if context.type == "store_joker_modify" then
			local _applied = nil
			if not context.card.edition and not context.card.temp_edition and context.card.ability.set == "Joker" then
				local lock = tag.ID
				G.CONTROLLER.locks[lock] = true
				context.card.temp_edition = true
				tag:yep("+", G.C.DARK_EDITION, function()
					context.card:set_edition({ dydb_vintage = true }, true)
					context.card.ability.couponed = true
					context.card:set_cost()
					context.card.temp_edition = nil
					G.CONTROLLER.locks[lock] = nil
					return true
				end)
				_applied = true
				tag.triggered = true
			end
		end
	end,
}

SMODS.Tag {
    key = 'galactic_tag',
    atlas = 'tags',
    pos = { x = 0, y = 0 },
    min_ante = 2,
	loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = G.P_CENTERS.e_dydb_galactic
		return { vars = {} }
	end,
	apply = function(self, tag, context)
		if context.type == "store_joker_modify" then
			local _applied = nil
			if not context.card.edition and not context.card.temp_edition and context.card.ability.set == "Joker" then
				local lock = tag.ID
				G.CONTROLLER.locks[lock] = true
				context.card.temp_edition = true
				tag:yep("+", G.C.DARK_EDITION, function()
					context.card:set_edition({ dydb_galactic = true }, true)
					context.card.ability.couponed = true
					context.card:set_cost()
					context.card.temp_edition = nil
					G.CONTROLLER.locks[lock] = nil
					return true
				end)
				_applied = true
				tag.triggered = true
			end
		end
	end,
}

SMODS.Tag {
	key = 'epic_tag',
	atlas = "tags",
	pos = { x = 2, y = 0 },
	min_ante = 2,
	config = { type = "store_joker_create" },
	apply = function(self, tag, context)
		if context.type == "store_joker_create" then
			local rares_in_posession = { 0 }
			for k, v in ipairs(G.jokers.cards) do
				if v.config.center.rarity == "dydb_epic" and not rares_in_posession[v.config.center.key] then
					rares_in_posession[1] = rares_in_posession[1] + 1
					rares_in_posession[v.config.center.key] = true
				end
			end
			local card
			if #G.P_JOKER_RARITY_POOLS.dydb_epic > rares_in_posession[1] then
				card = create_card("Joker", context.area, nil, "dydb_epic", nil, nil, nil, "dydb_epic_tag")
				create_shop_card_ui(card, "Joker", context.area)
				card.states.visible = false
				tag:yep("+", G.C.RARITY.dydb_epic, function()
					card:start_materialize()
					card.misprint_cost_fac = 0
					card:set_cost()
					return true
				end)
			else
				tag:nope()
			end
			tag.triggered = true
			return card
		end
	end,
}
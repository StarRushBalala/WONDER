local tarotInfo = {		--EDEN // crée un portail
    set = "purgatorio",
    pools = {['purgatorio_cons'] = true},
    key = "purg_eden",
    pos = { x = 0, y = 3 },
    cost = 4,
    atlas = "PLH2",
    loc_txt = {
        name = "EDEN",
        text = {
            "Créé un {C:dark_edition}PORTAIL{}.",
        }
    },
    loc_vars = function(self, info_queue, center)
        return { vars = { } }
    end,

	can_use = function(self, card)
		-- Utilisable seulement si on n'a pas atteint la limite de jokers
		return #G.jokers.cards < G.jokers.config.card_limit
	end,

	use = function(self, card, area, copier)
		local used_consumable = copier or card
		-- Liste des jokers supprimables : non éternels + appartenant au groupe "food"
		local deletable_jokers = {}
		for _, v in pairs(G.jokers.cards) do
			if not SMODS.is_eternal(v) and v.config and v.config.center and v.config.center.tags == {'buddies'} then
				deletable_jokers[#deletable_jokers + 1] = v
			end
		end
		-- Si aucun joker n'est supprimable, on ne fait rien
		if #deletable_jokers == 0 then
			return
		end
		-- Choisir un joker supprimable au hasard
		local chosen_joker = pseudorandom_element(deletable_jokers, pseudoseed("dydb_eden"))
		local first_dissolve = nil
		-- Dissolution du joker choisi
		G.E_MANAGER:add_event(Event({
			trigger = "before",
			delay = 0.75,
			func = function()
				chosen_joker:start_dissolve(nil, first_dissolve)
				first_dissolve = true
				return true
			end,
		}))
		-- Création du nouveau joker
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("timpani")
				local new_card = create_card("Joker", G.jokers, nil, rarity, nil, nil, nil, "dydb_eden")
				new_card:add_to_deck()
				G.jokers:emplace(new_card)
				new_card:juice_up(0.3, 0.5)
				return true
			end,
		}))

		delay(0.6)
	end,
}

return tarotInfo
--Gets the most-played hand
function favhand()
	if not G.GAME or not G.GAME.current_round then return 'High Card' end
	local chosen_hand = 'High Card'
	local _handname, _played, _order = 'High Card', 0, -1 / 0
	for k, v in pairs(G.GAME.hands) do
		if v.played > _played or (v.played == _played and _order > v.order) then 
			_order = v.order
			_played = v.played
			_handname = k
		end
	end
	chosen_hand = _handname
	return chosen_hand
end

--for spoonful
local cor = Card.open
function Card:open()
	local orig = self.ability.extra or 1
	local poppins = #SMODS.find_card('j_dydb_spoonful')
	if poppins > 0 then
		for k, v in pairs(SMODS.find_card('j_dydb_spoonful')) do
			orig = orig + v.ability.extra.extrachoices
		end
		self.config.choose = math.floor(orig)
		self.ability.extra = math.floor(orig)
	end
	cor(self)
	G.E_MANAGER:add_event(Event({delay = 0.5, timer = 'REAL', func = function()
		if poppins > 0 then
			G.GAME.pack_choices = math.floor(self.ability.extra)
		end
		return true
	end }))
end

---test
function ascend_robin()
	if (next(SMODS.find_card('j_dydb_robin'))) and (next(SMODS.find_card('j_dydb_theotime'))) then
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("timpani")
				local card = create_card("Joker", G.jokers, nil, nil, nil, nil, 'j_dydb_autistic_creature', "dydb_envy")
				card:add_to_deck()
				G.jokers:emplace(card)
				card:juice_up(0.3, 0.5)
				return true
			end,
		}))
		delay(0.6)
	end
end
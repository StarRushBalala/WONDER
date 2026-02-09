local jokerInfo = {
    key = "noah",
    pos = {x = 4, y = 7},
    soul_pos = { x = 5, y = 7, extra = { x = 6, y = 7 } },
    config = { extra = { } },
    rarity = "dydb_epic",
    cost = 12,
    blueprint_compat = true,
    atlas = "PLH",
    immutable = true,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
            },
        }
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
			G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("timpani")
				local card = create_card("Joker", G.jokers, nil, nil, nil, nil, 'j_dydb_chernobyl', "dydb_noah", nil, e_negative)
				card:add_to_deck()
				G.jokers:emplace(card)
				card:juice_up(0.3, 0.5)
				return true
			end,
		}))
		delay(0.6)
		debuff = true
		end    
        
        if #SMODS.find_card('j_dydb_governor') > 0 then
            card:start_dissolve({ HEX("57ecab") }, nil, 0.1)
        end
    end,
}

return jokerInfo
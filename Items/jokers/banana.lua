local jokerInfo = {
	key = "banana",
	config = {
		extra = {
            odds = 1,
            gros_odds = 3,
            cav_odds = 100,
        }
	},
	pos = { x = 9, y = 2 },
	rarity = 1,
	cost = 5,
	blueprint_compat = true,
	atlas = "PLH",
    pools = { ["dydb_additions"] = true },
    unlock = true,

    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                (G.GAME.probabilities.normal or 1), 
                card.ability.extra.gros_odds,
                card.ability.extra.cav_odds, 
            } 
        }
    end,
    calculate = function(self, card, context)
        if context.end_of_shop then
            if pseudorandom('banana') < (G.GAME.probabilities.normal or 1) / card.ability.extra.gros_odds then
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.4,
                    func = function()
                        play_sound("timpani")
                        local card = create_card(
                            "Joker",        --set
                            G.jokers,       --placement
                            nil,        --legendary
                            nil,        --rarity
                            nil,        --materialise
                            nil,        --soulable
                            'j_gros_michel',        --key
                            nil,        --idk
                            true,
                            e_negative, nil, nil
                        )
                        card:add_to_deck()
                        G.jokers:emplace(card)
                        card:juice_up(0.3, 0.5)
                        return true
                    end,
                }))
                delay(0.6)
            else
                return { message = 'Nope !' }
            end
            if pseudorandom('banana') < (G.GAME.probabilities.normal or 1) / card.ability.extra.cav_odds then
                 G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.4,
                    func = function()
                        play_sound("timpani")
                        local card = create_card(
                            "Joker",        --set
                            G.jokers,       --placement
                            nil,        --legendary
                            nil,        --rarity
                            nil,        --materialise
                            nil,        --soulable
                            'j_cavendish',        --key
                            nil,        --idk
                            true,
                            e_negative, nil, nil
                        )
                        card:add_to_deck()
                        G.jokers:emplace(card)
                        card:juice_up(0.3, 0.5)
                        return true
                    end,
                }))
                delay(0.6)
            end
        end
    end,

}

return jokerInfo
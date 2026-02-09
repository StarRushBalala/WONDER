local jokerInfo = {
	key = "galactus",
	config = {
		extra = {
			EEchips = 1,
			EEchips_mod = 1,
            slots = 3
		},
	},
	pos = { x = 8, y = 3 },
    soul_pos = { x = 9, y = 3},
	rarity = "dydb_transcendant",
	cost = 1000,
	blueprint_compat = true,
	atlas = "PLH",

	calculate = function(self, card, context)
		if (context.setting_blind and not context.blueprint) then
            local destructable_planet = {}
            for i = 1, #G.consumeables.cards do
                local c = G.consumeables.cards[i]
                if c.ability.set == "Planet"
                    and not c.getting_sliced
                    and not SMODS.is_eternal(c)
                then
                    destructable_planet[#destructable_planet + 1] = c
                end
            end
            if #destructable_planet == 0 then return end

            for _, planet in ipairs(destructable_planet) do
                local quota = 1

                if Incantation then
                    quota = planet:getEvalQty()
                end
                if Overflow then
                    quota = planet.ability.immutable and planet.ability.immutable.overflow_amount or quota
                end

                planet.getting_sliced = true
                card.ability.extra.EEchips = card.ability.extra.EEchips + card.ability.extra.EEchips_mod


                G.E_MANAGER:add_event(Event({
                    func = function()
                        (context.blueprint_card or card):juice_up(0.8, 0.8)
                        planet:start_dissolve({ G.C.MULT }, nil, 1.6)
                        return true
                    end,
                }))
                planet.dissolve = 0
            end
            return nil, true
        end

        if (context.joker_main and (to_big(card.ability.extra.EEchips) > to_big(1))) then
			return {
				message = '^^'..card.ability.extra.EEchips,
				EEchip_mod = card.ability.extra.EEchips,
				colour = G.C.DARK_EDITION,
			}
		end
	end,
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.EEchips_mod,
				card.ability.extra.EEchips,
                card.ability.extra.slots,
			},
		}
	end,

    add_to_deck = function(self, card, from_debuff)
        G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.slots
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.slots
    end
}

return jokerInfo
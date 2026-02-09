local jokerInfo = {
    key = "event_horizon",
    pos = {x = 3, y = 0},
    atlas = "jokers",
    rarity = 3,
    cost = 9,
    unlocked = true,
    blueprint_compat = false,
    pools = { ["dydb_additions"] = true },
    config = { extra = { level_up = 1} },

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.level } }
	end,

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

                -- Animation de destruction
                G.E_MANAGER:add_event(Event({
                    func = function()
                        (context.blueprint_card or card):juice_up(0.8, 0.8)
                        planet:start_dissolve({ G.C.RED }, nil, 1.6)
                        return true
                    end,
                }))
                planet.dissolve = 0
            end

            -- LEVEL UP DE LA MAIN LA PLUS JOUÉE
            level_up_hand(card, favhand(), false, #destructable_planet)

            return nil, true
        end
    end,
}

return jokerInfo
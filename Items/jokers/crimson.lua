local jokerInfo = {
    key = 'crimson',
    rarity = 4,
    atlas = 'PLH',
    pos = { x = 7, y = 7 },
    soul_pos = { x = 8, y = 7, extra = { x = 9, y = 7 } },
    cost = 20,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    config = {},

    loc_vars = function(self, info_queue, card)
        if card.area and card.area == G.jokers then
            local left_joker, right_joker = nil, nil
            local left_compat, right_compat = false, false

            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    left_joker = G.jokers.cards[i - 1]
                    right_joker = G.jokers.cards[i + 1]
                    break
                end
            end

            left_compat = left_joker and left_joker ~= card and left_joker.config.center.blueprint_compat
            right_compat = right_joker and right_joker ~= card and right_joker.config.center.blueprint_compat

            local left_indicator = {
                n = G.UIT.C,
                config = {
                    align = "cm",
                    padding = 0.05,
                    minw = 1.5,
                    r = 0.1,
                    colour = left_compat and G.C.GREEN or G.C.RED
                },
                nodes = {
                    {
                        n = G.UIT.R,
                        config = {
                            align = "cm",
                            text = "← " .. (left_joker and string.sub(left_joker.config.center.name, 1, 8) or "None"),
                            scale = 0.32,
                            colour = G.C.UI.TEXT_LIGHT
                        }
                    }
                }
            }

            local right_indicator = {
                n = G.UIT.C,
                config = {
                    align = "cm",
                    padding = 0.05,
                    minw = 1.5,
                    r = 0.1,
                    colour = right_compat and G.C.GREEN or G.C.RED
                },
                nodes = {
                    {
                        n = G.UIT.R,
                        config = {
                            align = "cm",
                            text = (right_joker and string.sub(right_joker.config.center.name, 1, 8) or "None") .. " →",
                            scale = 0.32,
                            colour = G.C.UI.TEXT_LIGHT
                        }
                    }
                }
            }

            return {
                main_end = {
                    {
                        n = G.UIT.R,
                        config = { align = "cm", padding = 0, minh = 0.6 },
                        nodes = { left_indicator, right_indicator }
                    }
                },
                vars = {
                    left_compat and "Compatible" or "Incompatible",
                    right_compat and "Compatible" or "Incompatible"
                }
            }
        end
        return { vars = {} }
    end,

    calculate = function(self, card, context)
        if not G.jokers then return nil end

        local left_effect, right_effect = nil, nil

        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] == card then
                local left_joker = G.jokers.cards[i - 1]
                local right_joker = G.jokers.cards[i + 1]

                if left_joker and left_joker ~= card and left_joker.config.center.blueprint_compat then
                    left_effect = SMODS.blueprint_effect(card, left_joker, context)
                end

                if right_joker and right_joker ~= card and right_joker.config.center.blueprint_compat then
                    right_effect = SMODS.blueprint_effect(card, right_joker, context)
                end
                break
            end
        end

        if left_effect or right_effect then
            local merged_effect = SMODS.merge_effects(
                { left_effect or {} },
                { right_effect or {} }
            )

            return merged_effect
        else
            return nil
        end
    end,
}

return jokerInfo
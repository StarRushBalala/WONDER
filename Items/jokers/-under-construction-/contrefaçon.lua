local jokerInfo = {
    key = "contrefaçon",
    pos = { x = 2, y = 0 },
    atlas = "PLH",
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    eternal_compat = false,
    config = { extra = {} },
    pools = { ["dydb_additions"] = true },
    loc_txt = {
        name = "Contre-façon",
        text = {
            "Copie les effets du {C:attention}Joker{}",
            "le plus à droite si possible.",
            "{C:inactive}Bluestorm"
        }
    },
    loc_vars = function(self, info_queue, card)
        if card.area and card.area == G.jokers then
            local other_joker
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i - 1] end
            end
            local compatible = other_joker and other_joker ~= card and other_joker.config.center.blueprint_compat
            
            local vars = { G.GAME and G.GAME.probabilities.normal or 1}
            return { vars = vars, main_end = main_end }
        end
        return { vars = { G.GAME and G.GAME.probabilities.normal or 1} }
    end,
    calculate = function(self, card, context)
        -- Safety check - only work during actual gameplay
        if not G.GAME or not G.jokers or not context then
            return nil
        end
        
        local other_joker = nil
        for i = #G.jokers.cards, 1, -1 do
            if G.jokers.cards[i] ~= card then
                other_joker = G.jokers.cards[i]
                break
            end
        end

        return SMODS.blueprint_effect(card, other_joker, context)
    end
}

return jokerInfo
local blindInfo = {
    key = 'evil',
    pos = { x = 0, y = 4 },
    atlas = 'blinds',
    mult = 2,
    dollars = 5,
    boss = { min = 5 },
    boss_colour = HEX('d71515'),
    config = {
        original_probabilities = nil
    },

    set_blind = function(self, card, from_debuff)
        self.config.original_probabilities = {}
        for k, v in pairs(G.GAME.probabilities) do
            self.config.original_probabilities[k] = v
            G.GAME.probabilities[k] = v / 4
        end
    end,

    disable = function(self, card, from_debuff)
        if self.config.original_probabilities then
            for k, v in pairs(self.config.original_probabilities) do
                G.GAME.probabilities[k] = v
            end
            self.config.original_probabilities = nil
        end
    end,

    defeat = function(self, card, from_debuff)
        if self.config.original_probabilities then
            for k, v in pairs(self.config.original_probabilities) do
                G.GAME.probabilities[k] = v
            end
            self.config.original_probabilities = nil
        end
    end,
}

return blindInfo
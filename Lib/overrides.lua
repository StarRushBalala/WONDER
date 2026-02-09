--[[SMODS.Consumable:take_ownership('wheel_of_fortune', {
    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = G.P_CENTERS.e_foil
        info_queue[#info_queue+1] = G.P_CENTERS.e_holo
        info_queue[#info_queue+1] = G.P_CENTERS.e_polychrome
        --info_queue[#info_queue+1] = G.P_CENTERS.e_losted_quantum
        --info_queue[#info_queue+1] = G.P_CENTERS.e_losted_glitched

        local vars = G.GAME and G.GAME.probabilities.normal and 
                    {G.GAME.probabilities.normal, self.config.extra} or {1, self.config.extra}
        return {key = 'c_dydb_wheel_of_fortune', vars = vars}
    end
})

SMODS.Consumable:take_ownership('aura', {
    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = G.P_CENTERS.e_foil
        info_queue[#info_queue+1] = G.P_CENTERS.e_holo
        info_queue[#info_queue+1] = G.P_CENTERS.e_polychrome
        return {key = 'c_dydb_aura'}
    end
})]]

SMODS.Edition:take_ownership('negative', {
    get_weight = function(self)
        return ((G.GAME.negative_rate or 1) - 1) * self.weight + (G.GAME.negative_rate or 1) * self.weight
    end,
})
local voucherInfo = {
    key = "dark_magic",
    pos = { x = 1, y = 2},
    atlas = 'tarots',
    requires = { "v_dydb_dark_orb" },
    config = { extra = { rate = 10} },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.rate } }
    end,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.negative_rate = G.GAME.negative_rate * card.ability.extra.rate
                return true
            end
        }))
    end
}

return voucherInfo
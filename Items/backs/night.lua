local backInfo = {
    key = "night",
    pos = {x = 1, y = 3},
    atlas = "PLH2",
    unlocked = true,
    Dumb_yet_Dumber = {
    	requires_stars = true
  	},
    apply = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
				for k, v in pairs(G.playing_cards) do
					if v.base.suit == "Clubs" or v.base.suit == "Hearts" or v.base.suit == "Diamonds" or v.base.suit == "Spades" then
						v:change_suit("dydb_Stars")
					end
				end
		        return true
		    end,
		}))
    end,
}

return backInfo
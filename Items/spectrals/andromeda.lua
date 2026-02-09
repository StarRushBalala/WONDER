local tarotInfo = {
  set = "Spectral", -- this is what you will use to determine what type of consumable this item is, in this case it is a tarot
  key = "andromeda",
  pos = { x = 9, y = 0 }, -- this is the position of what sprite the consumable will use, balatro uses a 0 index system so the first sprite is 0,0 and the second sprite is 1,0 and so on
  cost = 3, -- this is the cost of the consumable in the shop, and its sell value is half of what the cost to buy is, but since its cost is not even we will round it down to 1 dollar
  atlas = "PLH2",
	Dumb_yet_Dumber = {
    requires_stars = true
  },

  can_use = function(self, card) -- this is the function that determines if the consumable can be used or not, in this case it is useable if the number of highlighted cards is greater than or equal to the max_selected value in the config
		return #G.hand.highlighted <= card.ability.extra.max_selected and #G.hand.highlighted > 0
	end,
  config = { extra = {max_selected = 3}}, -- this config determines how many cards can be selected when using the consumable, you can change this number to any number you want
	loc_vars = function(self, info_queue, card) -- this is the function that determines what variables will be shown when hovering over the consumable
    if card then
	    return { vars = { card.ability.extra.max_selected } }
    else
	    return { vars = { 0 } }
    end
	end,
	use = function(self, card, area, copier) -- this is the function that is used to make our consumable do its thing in this case we will be using it to change a number of selected cards into Diamonds
        local used_tarot = card or copier
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            used_tarot:juice_up(0.3, 0.5)
            return true end }))
        for i=1, #G.hand.highlighted do
            local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        delay(0.2)
        for i=1, #G.hand.highlighted do -- this is the loop that will change the selected cards into Diamonds, you can change 'Diamonds' to any other suit such as 'Hearts', 'Clubs', or 'Spades'
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function() SMODS.change_base(G.hand.highlighted[i],'dydb_Stars',nil);return true end })) 
        end
        for i=1, #G.hand.highlighted do
            local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
        delay(0.5)
	end,
}

return tarotInfo
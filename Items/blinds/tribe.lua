local blindInfo = {
    loc_txt = {
        name = 'The Tribe',
        text = { 'Hand must contain', 'only one suit' }
    },
    key = 'tribe',
    config = {},
    boss = {min = 2},
    boss_colour = HEX("E86EE4"),
    atlas = 'blinds',
    pos = {x = 0, y = 3},
    vars = {},
    dollars = 7,
    mult = 2,
	debuff_hand = function(self, cards, hand, handname, check)
		local num_suits = 0
		local check_suits = {}
		for k, card in ipairs(cards) do
			if not check_suits[card.base.suit] then
				num_suits = num_suits + 1
				check_suits[card.base.suit] = true
				if num_suits > 1 then return true end
			end
		end
		if num_suits < 1 then return true end
	end
}

return blindInfo
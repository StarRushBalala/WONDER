


-- this pokerhand example is an adaptation of the SMODS example Royal Flush at https://github.com/Steamodded/examples/blob/d43316d97bc927f3de431dd84c0283d41e69761a/Mods/RoyalFlush/RoyalFlush.lua
SMODS.PokerHand {
    key = 'Royal_Flush', -- the key that we use to identify what the game is initializing
    chips = 110, -- the amount of chips the hand scores at level 1
    mult = 9, -- the amount of mult that the hand uses at level 1
    l_chips = 40,-- the amount of chips that is added to the hand with each level
    l_mult = 4, -- the amount of mult that is added to the hand with each level
    example = {-- this is the example that is shown when hovering over the hand in the run info tab. these cards are all the spades suit
    --
        { 'S_A',    true }, -- Ace
        { 'S_K',    true }, -- King
        { 'S_Q',    true }, -- Queen
        { 'S_J',    true }, -- Jack
        { 'S_T',    true }, -- 10
    },
    evaluate = function(parts, hand)
        if next(parts._flush) and next(parts._straight) then -- chaecks if the selected cards make up both a flush and a straight
            local _strush = SMODS.merge_lists(parts._flush, parts._straight) -- this is a local value we make to make it easier to code in, as well as making everything look more neat
            local royal = true -- this is a local boolean value that we use in the for loop to check if the cards are a royal flush or not
            for j = 1, #_strush do -- this for loop checks the number of cards that satisfy "_strush" and checks if they are a royal flush or not
                local rank = SMODS.Ranks[_strush[j].base.value] -- this is the rank 
                royal = royal and (rank.key == 'Ace' or rank.key == '10' or rank.face) -- this is where we define our local boolean value, and we check if the rank is a royal flush or not
            end
            if royal then return {_strush} end -- if the cards are a royal flush then we return the cards that are a royal flush, and this is what will be used to calculate the chips and mult of the hand
        end
    end,
}
--[[
SMODS.Shader({key = 'missingtexture', path = 'missingtexture.fs'})
SMODS.Shader({key = 'misprint', path = 'misprint.fs'})

local misprintedition_config = {
	additive = {0, 50},
	multiplicative = {0.5, 10},
	exponential = {0.5, 5}
}
SMODS.Edition({
    key = "misprint",
    loc_txt = {
        name = "Misprint",
        label = "Misprint",
        text = {
            "Card has {C:attention}unknown, random bonus values",
            '{C:inactive}({C:tarot}+{C:inactive}, {X:tarot,C:white}x{C:inactive}, and {X:tarot,C:dark_edition}^{C:inactive} Chips and/or Mult)',
			'{C:dark_edition,s:0.7,E:2}Shader by : stupxd'
        }
    },
    shader = "misprint",
	disable_base_shader = true,
	no_shadow = true,
    discovered = true,
    unlocked = true,
    config = {},
	sound = {
		sound = 'dydb_e_misprint',
		per = 1,
		vol = 0.5
	},
    in_shop = true,
    weight = 1.5,
    extra_cost = 8,
    apply_to_float = false,
	get_weight = function(self)
        return G.GAME.edition_rate * self.weight
    end,
})]]
--[[
SMODS.Edition{
    key = "missingtexture",
    loc_txt = {
        name = "Missing Textures",
        label = "Missing Textures",
        text = {
            "{X:red,C:white}x#1#{C:red} Mult{}, {C:red,s:1.2}BUT",
			"{C:red}lose {C:money}$#2#{} when scored",
			'{C:inactive,S:0.7}Someone forgot to install Counter-Strike: Source...',
			'{C:dark_edition,s:0.7,E:2}Shader by : stupxd'
        }
    },
    discovered = true,
    unlocked = true,
    shader = 'missingtexture',
    config = { x_mult = 25, p_dollars = -5 },
	sound = {
		sound = 'dydb_e_misprint',
		per = 1,
		vol = 0.6
	},
    in_shop = true,
    weight = 3,
    extra_cost = 7,
    apply_to_float = false,
    loc_vars = function(self)
        return { vars = { self.config.x_mult, math.abs(self.config.p_dollars) } }
    end,
	calculate = function(self, card, context)
		local x_mult = self.config.x_mult
		local p_dollars = self.config.p_dollars
		if context.edition and context.cardarea == G.jokers and context.joker_main then
			return {
				x_mult = self.config.x_mult,
				p_dollars = self.config.p_dollars
			}
		end
		if context.cardarea == G.play and context.main_scoring then
			return {
				x_mult = self.config.x_mult,
				p_dollars = self.config.p_dollars
			}
		end
	end
}]]
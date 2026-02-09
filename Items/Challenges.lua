-- example of a challenge

--[[

SMODS.Challenge{
    loc_txt = "Vanilla Challenge", -- the name of the challenge
    key = 'example_challenge', -- the key for the challenge
    rules = { -- the ruleset for this challenge
        custom = {},
        modifiers = {
            {id = 'joker_slots', value = 5}, -- sets joker slots to 5
        },
    },
    jokers = {
        {id = 'j_joker', edition = 'negative', eternal = true}, -- start with a negative joker
    },
    consumeables = {
        {id = 'c_hermit'}, -- start with a hermit card
    },
    vouchers = {
        {id = 'v_overstock_plus'}, -- start with a overstock plus voucher
    },
    restrictions = { -- the cards that are banned from appearing in this challenge
        banned_cards = {
        },
        banned_tags = {
        }, -- diffrent banned tags
        banned_other = {
        } -- for banning set of stuff like blinds from showing up
    }
}

]]

SMODS.Challenge{
    loc_txt = "bro", -- the name of the challenge
    key = 'bro_challenge', -- the key for the challenge
    rules = {
        custom = {
        },
        modifiers = {
            {id = 'joker_slots', value = 1000}, -- sets joker slots to 5
        }
    },
    jokers = {
    },
    consumeables = {
    },
    vouchers = {
    },
    deck = {
        type = 'Challenge Deck'
    },
    restrictions = {
        banned_cards = {
        },
        banned_tags = {
        },
        banned_other = {
        }
    }
}
SMODS.Suit{
    key = 'Stars',
    name = "Stars",
    card_key = 'STAR',
    hc_atlas = 'hc_cards',
    lc_atlas = 'lc_cards',
    hc_ui_atlas = 'hc_ui',
    lc_ui_atlas = 'lc_ui',
    pos = { y = 0 },
    ui_pos = { x = 0, y = 0 },
    hc_colour = HEX('A414C8'),
    lc_colour = HEX('A414C8'),
    in_pool = function(self, args)
        --[[ Forcer l’inclusion si demandé
        if args and args.Dumb_yet_Dumber and args.Dumb_yet_Dumber.include_stars then
            return true
        end]]
        if args and args.initial_deck then
            return false
        end
        return true
    end
}

local function allow_suits(self, args)
    if args and args.initial_deck then
        return Dumb_yet_Dumber.config.allow_all_suits
    end
    return true
end

local blind_in_pool = function(self, args)
        if G.playing_cards then
        for _,v in ipairs(G.playing_cards) do
            if v.base.suit == self.debuff.suit then return true end
        end
    else
        return SMODS.Suits[self.debuff.suit]:in_pool({initial_deck = false}) -- in deck
    end
end

Dumb_yet_Dumber.description_loc_vars = function()
    return { background_colour = G.C.CLEAR, text_colour = G.C.WHITE, scale = 1.2 }
end

local base_spectrum
local str_spectrum
local spec_house
local spec_five

local framework = next(SMODS.find_mod('SpectrumFramework'))
if framework then
    if Dumb_yet_Dumber.config.allow_all_suits then
        base_spectrum = SMODS.PokerHand:take_ownership(framework and 'spectrum_Spectrum', {
            chips = 50,
            mult = 5,
            l_chips = 20,
            l_mult = 3,
            visible = true,
            example = {
                { 'dydb_STAR_2',    true },
                { 'D_7',    true },
                { 'C_3', true },
                { 'S_5', true },
                { 'H_K',    true },
            },
        })
        str_spectrum = SMODS.PokerHand:take_ownership(framework and 'spectrum_Straight Spectrum', {
            chips = 80,
            mult = 7,
            l_chips = 35,
            l_mult = 3,
            example = {
                { 'S_Q',    true },
                { 'dydb_STAR_J', true },
                { 'C_T',    true },
                { 'D_9', true },
                { 'H_8',    true }
            },
        })
        spec_house = SMODS.PokerHand:take_ownership(framework and 'spectrum_Spectrum House', {
            chips = 90,
            mult = 8,
            l_chips = 40,
            l_mult = 4,
            example = {
                { 'S_Q',    true },
                { 'H_Q', true },
                { 'C_Q',    true },
                { 'dydb_STAR_8',    true },
                { 'D_8',    true }
            },
        })
        spec_five = SMODS.PokerHand:take_ownership(framework and 'spectrum_Spectrum Five', {
            chips = 150,
            mult = 16,
            l_chips = 40,
            l_mult = 3,
            example = {
                { 'dydb_STAR_7',    true },
                { 'D_7', true },
                { 'S_7', true },
                { 'H_7',    true },
                { 'C_7',    true }
            },
        })
    else
        base_spectrum = SMODS.PokerHands[framework and 'spectrum_Spectrum']
        str_spectrum = SMODS.PokerHands[framework and 'spectrum_Straight Spectrum']
        spec_house = SMODS.PokerHands[framework and 'spectrum_Spectrum House']
        spec_five = SMODS.PokerHands[framework and 'spectrum_Spectrum Five']
    end
else
    SMODS.PokerHandPart {
        key = 'spectrum',
        func = function(hand)
            local suits = {}
            for _, v in ipairs(SMODS.Suit.obj_buffer) do
                suits[v] = 0
            end
            if #hand < 5 then return {} end
            for i = 1, #hand do
                if hand[i].ability.name ~= 'Wild Card' then
                    for k, v in pairs(suits) do
                        if hand[i]:is_suit(k, nil, true) and v == 0 then
                            suits[k] = v + 1; break
                        end
                    end
                end
            end
            for i = 1, #hand do
                if hand[i].ability.name == 'Wild Card' then
                    for k, v in pairs(suits) do
                        if hand[i]:is_suit(k, nil, true) and v == 0 then
                            suits[k] = v + 1; break
                        end
                    end
                end
            end
            local num_suits = 0
            for _, v in pairs(suits) do
                if v > 0 then num_suits = num_suits + 1 end
            end
            return (num_suits >= 5) and { hand } or {}
        end
    }
    -- Poker hands
    base_spectrum = SMODS.PokerHand {
        key = 'Spectrum',
        chips = 20,
        mult = 3,
        l_chips = 15,
        l_mult = 3,
        example = {
            { 'H_2',    true },
            { 'C_7',    true },
            { 'S_3', true },
            { 'dydb_STAR_5', true },
            { 'D_K',    true },
        },
        evaluate = function(parts)
            return parts.dydb_spectrum
        end
    }
    str_spectrum = SMODS.PokerHand {
        key = 'Straight Spectrum',
        chips = 60,
        mult = 6,
        l_chips = 35,
        l_mult = 2,
        example = {
            { 'S_Q',    true },
            { 'dydb_STAR_J', true },
            { 'C_T',    true },
            { 'D_9', true },
            { 'H_8',    true }
        },
        evaluate = function(parts)
            if not next(parts.dydb_spectrum) or not next(parts._straight) then return {} end
            return { SMODS.merge_lists (parts.dydb_spectrum, parts._straight) }
        end,
        modify_display_text = function(self, _cards, scoring_hand)
            local royal = true
            for j = 1, #scoring_hand do
                local rank = SMODS.Ranks[scoring_hand[j].base.value]
                royal = royal and (rank.key == 'Ace' or rank.key == '10' or rank.face)
            end
            if royal then
                return self.key..'_2'
            end
        end
    }
    spec_house = SMODS.PokerHand {
        key = 'Spectrum House',
        --above_hand = 'Straight Flush',
        visible = false,
        chips = 80,
        mult = 7,
        l_chips = 35,
        l_mult = 4,
        example = {
            { 'S_Q',    true },
            { 'dydb_STAR_Q', true },
            { 'C_Q',    true },
            { 'D_8',    true },
            { 'H_8',    true }
        },
        evaluate = function(parts)
            if #parts._3 < 1 or #parts._2 < 2 or not next(parts.dydb_spectrum) then return {} end
            return { SMODS.merge_lists (parts._all_pairs, parts.dydb_spectrum) }
        end,
    }
    spec_five = SMODS.PokerHand {
        key = 'Spectrum Five',
        --above_hand = 'Flush House',
        visible = false,
        chips = 120,
        mult = 14,
        l_chips = 40,
        l_mult = 3,
        example = {
            { 'S_7',    true },
            { 'D_7', true },
            { 'dydb_STAR_7',    true },
            { 'H_7',    true },
            { 'C_7',    true }
        },
        evaluate = function(parts)
            if not next(parts._5) or not next(parts.dydb_spectrum) then return {} end
            return { SMODS.merge_lists (parts._5, parts.dydb_spectrum) }
        end,
    }
end

--[[
spec_constellation = SMODS.PokerHand {
    key = 'constellation',
    above_hand = 'Flush',
    visible = true,
    Dumb_yet_Dumber = {
        requires_stars = true
    },
    chips = 120,
    mult = 14,
    l_chips = 40,
    l_mult = 3,
    example = {
        { 'dydb_STAR_9',    true },
        { 'dydb_STAR_J',    true },
        { 'dydb_STAR_7',  true },
        { 'dydb_STAR_4',    true },
        { 'dydb_STAR-10',    true }
    },
    evaluate = function(parts)
        -- Require at least 5 cards
        if not next(parts._5) then return {} end

        local hand = parts._5
        for i = 1, #hand do
            local card = hand[i]
            --[[if card.ability.name ~= 'Wild Card' then
                -- If any non-Wild card is not a Star, fail
                if not card:is_suit('Stars', nil, true) then
                    return {}
                end
            else
                -- Wild Cards must be able to act as Stars
            if not card:is_suit('dydb_Stars', nil, true) then
                return {}
            end
            --end
        end

        -- If we reach here, all cards are Stars (or Wilds acting as Stars)
        return { hand }
    end,
}
]]


SMODS.Atlas { key = 'lc_cards', path = '8BitDeck.png', px = 71, py = 95 }
SMODS.Atlas { key = 'hc_cards', path = '8BitDeck_opt2.png', px = 71, py = 95 }
SMODS.Atlas { key = 'lc_ui', path = 'ui_assets.png', px = 18, py = 18 }
SMODS.Atlas { key = 'hc_ui', path = 'ui_assets_opt2.png', px = 18, py = 18 }
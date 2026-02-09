local itemsToLoad = {

    Joker = {

    --'normal' jokers
        --'baguette_de_pain',
        'joker.exe',
        'joker_de_janeiro',
        --'golf_player',
        'pet_rock',
        'hermatite_ring',
        'event_horizon',
        'ai_joker',
        'mirror',
        'bad_alchemy',
        --'glitch', 
        'normal_joker',
        'day_of_2',
        'hephaistos',
        'noahs_arc',
        'traveller',
        'tourist',
        'pokemon',
        'banjo',
        'kazooie',
        'manipulation',
        'isometric',
        'city',
        'crash',
        'word_of_the_day',
        'platformer',
        'mirror2',
        'jimvasion',
        'referee',
        
    --food & reversed food
        'baguette_de_pain',
        'empty_bag',
        'empty_cone',
        'empty_bol',

    --capitalist jokers
        'labubu1',
        'labubu2',
        'labubu3',
        
    --joker pour les étoiles
        'star_test',
        'celestial_rock',
        'constellation',
        'supernova',
        'xmas_tree',
        'supercluster',

    --shitpost joker
        'lets_go_gambling',
        'jack_black',
        'boy_kisser',
        'not_sigma',
        'four',
        'fish',
        '67_kid',
        'banana',
        'im_out',
        'absolute_joker',
        'spoonful',
        --'im_flowerpot',
        --'multiplayer',

    --buddies
        'Noah',
        'Théotime',
        'Robin',
        --'Cassandra',
        'crimson', 

    --legendaries
        'pjerrot',
        'wheathered_mask',
        'not_oil_lamp',

    --expérimental
        --'joker_stylé',
        'starrush',
        'galactus',
        'governor',
    
    --non utilisées (ne marche pas ou sont nul)
        --'sans',
        --'ena',
        --'jo',
        --'contrefaçon',
        --'hold_on',
        --'joker_2',
        --'bank_heist',

    },
    Voucher = {
        'overbooster',
        'overvoucher',
        'dark_orb',
        'dark_magic',
        'communism',
        --'test',
    },
    Tarot = {
        'void',
        'river',
        'cocktail',
        'n.i.',
        'a.s.',
    },
    Spectral = {
        'andromeda',
        'essence',
        'time_loop',
        'totoya',
        'the_whatsapp',
        'infinity',
    },
    Planet = {
        --'luna',
    },
    Purgatorio = {
        --'purg_eden',
        --'purg_envy',
        --'purg_pride',
        --'purg_sloth',
        --'purg_rubicon',
        'greed',
        'envy',
    },
    Seal = {
        'banana', 
        'twitter',
        'totoya',
        'youtube',
    },
    Back = {
        --'purple',
        'prophecy',
        'night',
        'power',
        'magician',
        
    },
    Enhancement = {
        'aqua',
        'void',
        'mecha',
        'freeze',
    },
    Edition = {
        'vintage',
        'galactic',
        'whatsapp',
        'evil_whatsapp',
        'missingtexture',
        'misprint',
    },
    Blind = {
        'evil',
        'tribe',
        'awry',
    },
    Booster = {
        'dumb1',
        'dumb2',
        'dumb3',
        'plhpack',
        'shiny1',
        'shiny2',
        'purgpack',
    }
}

for item_type, items in pairs(itemsToLoad) do
    for _, item_key in ipairs(items) do
        local item_path = "items/" .. string.lower(item_type) .. "s/" .. item_key .. ".lua"
        local item_init, item_error = SMODS.load_file(item_path)
        
        if item_error then
            sendDebugMessage("[dumb_yet_dumber] Error loading " .. item_type:lower() .. ": " .. item_key .. " - " .. item_error)
        else
            local item_data = item_init and item_init()
            if item_data then
                -- Register the item based on its type
                if item_type == "Joker" then
                    SMODS.Joker(item_data)
                end
                if item_type == "Tarot" or item_type == "Spectral" or item_type == "Planet" or item_type == "Purgatorio" then
                    SMODS.Consumable(item_data)
                end
                if item_type == "Voucher" then
                    SMODS.Voucher(item_data)
                end
                if item_type == "Seal" then
                    SMODS.Seal(item_data)
                end
                if item_type == "Back" then
                    SMODS.Back(item_data)
                end
                if item_type == "Enhancement" then
                    SMODS.Enhancement(item_data)
                end
                if item_type == "Edition" then
                    SMODS.Edition(item_data)
                end
                if item_type == 'Blind' then
                    SMODS.Blind(item_data)
                end
                if item_type == 'Booster' then
                    SMODS.Booster(item_data)
                end
                sendDebugMessage("[Wonder] Loaded " .. item_type:lower() .. ": " .. item_key)
            end
        end
    end
end

return function()
    return itemsToLoad
end

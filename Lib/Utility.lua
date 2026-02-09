-- this is where we will show you how to make a config menu and some other utility functions for your mod





--[[



-- the 3 lines with the localize in them are defined in the en-us file towards the bottom under dictionary
if Dumb_yet_Dumber.config.example_config_toggle then -- if this config option is toggled o true, then this consumable will be added to the game, but if its false then it will not show up in the collection
    Dumb_yet_Dumber.config_tab = function() -- the configs will be stored in config.lua and you can find the file of the configs in "Roaming/balatro/config" then ExampleMod.jkr for this mod
        local scale = 5/6
        return {n=G.UIT.ROOT, 
            config = {align = "cl", minh = G.ROOM.T.h*0.5, padding = 0.0, r = 0.1, colour = G.C.GREY}, 
            nodes = {
                {n = G.UIT.R, config = { padding = 0.05 }, 
                    nodes = {
                        {n = G.UIT.C, config = { minw = G.ROOM.T.w*0.25, padding = 0.05 }, 
                            nodes = {
                                create_toggle{
                                    label = localize("example_config_label"), -- the label that shows up next to the toggle button
                                    info = {localize("exmp_restart"), -- the text that will show below the toggle option
                                    localize("include_custom_consumable")}, -- the text that will show below the toggle option
                                    active_colour = Dumb_yet_Dumber.badge_colour, -- the color of the toggle when it is on
                                    ref_table = Dumb_yet_Dumber.config, -- the table of which the toggle refrerences to check if it is on or off
                                    ref_value = "example_config_toggle" -- the value from the ref_table that the toggle will change when pressed
                                }
                            }
                        },
                        {n = G.UIT.C, config = { minw = G.ROOM.T.w*0.25, padding = 0.05},
                            nodes = {
                                create_toggle{
                                    label = localize("only_faces"),
                                    info = {localize("no_exmp_restart"), localize("insert_text_here")},
                                    active_colour = Dumb_yet_Dumber.badge_colour,
                                    ref_table = Dumb_yet_Dumber.config.example,
                                    ref_value = "only_face_cards"
                                }
                            }
                        },
                        {n = G.UIT.C, config = { minw = G.ROOM.T.w*0.25, padding = 0.05},
                            nodes = {
                                create_toggle{
                                    label = localize("random_cards"),
                                    info = {localize("no_exmp_restart"), localize("insert_text_here")},
                                    active_colour = Dumb_yet_Dumber.badge_colour,
                                    ref_table = Dumb_yet_Dumber.config.example,
                                    ref_value = "random_cards"
                                }
                            }
                        },
                    }
                },
                {n = G.UIT.R, config = { padding = 0.05 },
                    nodes = {
                        {n = G.UIT.C, config = { minw = G.ROOM.T.w*0.25, padding = 0.05},
                            nodes = {
                                create_slider{
                                    label = localize("extra_hands_label"),
                                    info = {localize("no_exmp_restart"), localize("insert_text_here")},
                                    colour = G.C.BLUE, -- the color of the slider
                                    min = 0, max = 10000, -- the min and max values of the slider
                                    w = G.ROOM.T.w*0.25, -- the width of the slider
                                    active_colour = Dumb_yet_Dumber.badge_colour,
                                    ref_table = Dumb_yet_Dumber.config.example,
                                    ref_value = "bonus_starting_hands"
                                }
                            }
                        },
                        {n = G.UIT.C, config = { minw = G.ROOM.T.w*0.25, padding = 0.05},
                            nodes = {
                                create_slider{
                                    label = localize("extra_discards_label"), -- the label that is displayed just above the slider
                                    info = {localize("no_exmp_restart"), localize("insert_text_here")},
                                    min = 0, max = 10000, -- the min and max values of the slider
                                    w = G.ROOM.T.w*0.25, -- the width of the slider
                                    active_colour = Dumb_yet_Dumber.badge_colour,
                                    ref_table = Dumb_yet_Dumber.config.example,
                                    ref_value = "bonus_starting_discards"
                                }
                            }
                        },
                        {n = G.UIT.C, config = { minw = G.ROOM.T.w*0.25, padding = 0.05},
                            nodes = {
                                create_slider{
                                    label = ("Win Ante Slider"),
                                    info = {localize("no_exmp_restart"), localize("insert_text_here")},
                                    colour = G.C.BLUE, -- the color of the slider
                                    min = 8, max = 10000, -- the min and max values of the slider
                                    w = G.ROOM.T.w*0.25, -- the width of the slider
                                    active_colour = Dumb_yet_Dumber.badge_colour,
                                    ref_table = G.GAME,
                                    ref_value = "win_ante"
                                }
                            }
                        },
                    },
                },
                {n = G.UIT.R, config = { padding = 0.05 },
                    nodes = {
                        {n = G.UIT.C, config = { minw = G.ROOM.T.w*0.25, padding = 0.05},
                            nodes = {
                                create_slider{
                                    label = ("Ante Scaling"),
                                    info = {localize("no_exmp_restart"), localize("insert_text_here")},
                                    colour = G.C.BLUE, -- the color of the slider
                                    min = -100, max = 100, -- the min and max values of the slider
                                    w = G.ROOM.T.w*0.25, -- the width of the slider
                                    active_colour = Dumb_yet_Dumber.badge_colour,
                                    ref_table = Dumb_yet_Dumber.config.example,
                                    ref_value = "ante_scale_value"
                                },
                            },
                        },
                        {n = G.UIT.C, config = { minw = G.ROOM.T.w*0.25, padding = 0.05},
                            nodes = {
                                create_option_cycle{
                                    colour = G.C.BLUE, -- the color of the slider
                                    info = {("No Restart Needed"), localize("insert_text_here")},
                                    options = {
                                        Dumb_yet_Dumber.config.options.option_0, -- the text that will show up in the option cycle
                                        Dumb_yet_Dumber.config.options.option_1, -- the text that will show up in the option cycle
                                        Dumb_yet_Dumber.config.options.option_2,
                                        Dumb_yet_Dumber.config.options.option_3,
                                        Dumb_yet_Dumber.config.options.option_4,
                                        Dumb_yet_Dumber.config.options.option_inf,
                                    },
                                    label = ("Starting Money Multiplier"), -- the label that shows up next to the option cycle
                                    ref_value = "example_value", -- the value that this option cycle uses
                                    ref_table = Dumb_yet_Dumber.config.options, -- the table of which the toggle will be added to
                                    opt_callback = "ExampleCallback", -- the function that will be called when the option is changed
                                    current_option = Dumb_yet_Dumber.config.multiplier, -- the current value of the option cycle
                                }
                            }
                        },
                    },
                },
                {n = G.UIT.R, config = { padding = 0.05 },
                    nodes = {
                        {n = G.UIT.C, config = { minw = G.ROOM.T.w*0.25, padding = 0.05},
                            nodes = {
                                create_text_input{
                                    label = localize("insert_text_here"),
                                    info = {localize("no_exmp_restart"), localize("insert_text_here")},
                                    colour = G.C.BLUE, -- the color of the slider
                                    w = G.ROOM.T.w*0.25, -- the width of the slider
                                    active_colour = Dumb_yet_Dumber.badge_colour,
                                    ref_table = Dumb_yet_Dumber.config.example,
                                    ref_value = "ante_scale_value",
                                }
                            },
                        },
                    },
                },
            }
        }
    end

    G.FUNCS.reset_ante_scaling = function() -- this is the function that will be called when the button is pressed
        Dumb_yet_Dumber.config.example.ante_scale_value = 0 -- this is the value that will be used in the config file, and it will be saved to the config file when the game is closed
    end



    G.FUNCS.ExampleCallback = function(e) -- refrenced from talisman
        Dumb_yet_Dumber.config.multiplier = e.to_key -- this is the value that will be used in the config file, and it will be saved to the config file when the game is closed
        local mult_ops = { 1, 10, 20, 30, 40, 1e10, } -- this is the list of options that will be used in the option cycle, and it will be saved to the config file when the game is closed
        Dumb_yet_Dumber.config.example.example_value = mult_ops[e.to_key] 
    end


    --[[
    -- implemented --
    create_toggle(args)
    create_option_cycle(args)
    create_slider(args)
    create_text_input(args)
    -- not implemented --
    UIBox_button(args)
    simple_text_container(_loc, args)
    create_UIBox_generic_options(args)
    ]] --[[
    local gsp = get_starting_params

    function get_starting_params() -- used polterworx as a refrence for this code
        params = gsp()
        params.hands = params.hands + Dumb_yet_Dumber.config.example.bonus_starting_hands
        params.discards = params.discards + Dumb_yet_Dumber.config.example.bonus_starting_discards
        params.no_faces = Dumb_yet_Dumber.config.example.only_face_cards
        params.erratic_suits_and_ranks = Dumb_yet_Dumber.config.example.random_cards
        params.ante_scaling = params.ante_scaling + Dumb_yet_Dumber.config.example.ante_scale_value -- this is the value that will be used in the config file, and it will be saved to the config file when the game is closed
        params.dollars = params.dollars * Dumb_yet_Dumber.config.example.example_value -- this is the value that will be used in the config file, and it will be saved to the config file when the game is closed
        return params
    end

    -- custom resource and variables
    -- the G.GAME.storage value can be found in our example.toml or in game.lua in the lovely dump


    function require_storage_count(card, context) -- this checks if our storage value is greater than or equal to the storage requirement of the joker
        return G.GAME.storage >= card.ability.extra.storage_req 
    end

    function use_storage(card) -- this removes our storage value when we use the storage button on any object that has it by the storage requirement
        G.GAME.storage = G.GAME.storage - card.ability.extra.storage_req
        SMODS.trigger_effects({eval_card(card, { use_storage = true })}) -- this is how we trigger our effects when we use the storage button
    end

    function G.FUNCS.can_use_storage(e) -- this checks if we can use the storage button on any object that has the exmp_storage returned as true
        local c1 = e.config.ref_table
        if require_storage_count(c1) then -- this checks if the conditions satisfy out require_storage_count function
            e.config.colour = G.C.GOLD -- when the if statment is satisfied this is the color of the button
            e.config.button = 'use_storage'
        else
            e.config.colour = G.C.UI.BACKGROUND_INACTIVE -- this is the color of the button when the if statment is not satisfied
            e.config.button = nil
        end
    end

    function G.FUNCS.use_storage(e) -- this is the function that is called when we press the use storage button
        local c1 = e.config.ref_table
        G.E_MANAGER:add_event(Event({ -- this adds the event that runs the functions for our button
            trigger = "after",
            delay = 0.1,
            func = function()
                use_storage(c1) -- this is where we call our use_storage function to remove the storage value
                return true
            end,
        }))
        G.jokers:unhighlight_all() -- this unhighlights all jokers when we press the use storage button
    end

    function exmp_increment_storage(card, context) -- this is the function that we call to increase our storge value
        G.GAME.storage = G.GAME.storage + (card.ability.extra.add_storage or 1)
    end
end

Dumb_yet_Dumber.funcs = {                                          --from the BALATRO LOST EDITION mod--
    -- ==== UTILITY FUNCTIONS ====
    
    coordinate = function(position)
        return { x = position % 10, y = math.floor(position / 10) }
    end,
    
    -- ==== CARD MANIPULATION ====
    
    -- Remove a joker card with animation
    destroy_joker = function(card, after)
        G.E_MANAGER:add_event(Event({
            func = function()
                card.T.r = -0.2
                card:juice_up(0.3, 0.4)
                card.states.drag.is = true
                card.children.center.pinch.x = true
                play_sound('tarot1', 1.0, 0.8)
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.3,
                    blockable = false,
                    func = function()
                        card:remove()
                        if after and type(after) == "function" then
                            after()
                        end
                        return true
                    end
                }))
                return true
            end
        }))
    end,

    -- Remove multiple cards with animation
    destroy_cards = function(cards, callback)
        if #cards == 0 then return end
        play_sound('tarot1', 1.0, 0.8)
        
        for _, card in ipairs(cards) do
            G.E_MANAGER:add_event(Event({
                func = function()
                    card.T.r = -0.2
                    card:juice_up(0.3, 0.4)
                    card.states.drag.is = true
                    card.children.center.pinch.x = true
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.3,
                        blockable = false,
                        func = function()
                            card:remove()
                            return true
                        end
                    }))
                    return true
                end
            }))
        end
        
        if callback then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                blockable = false,
                func = function()
                    callback()
                    return true
                end
            }))
        end
    end,

    -- Create a joker and add to deck
    create_joker_in_deck = function(joker_key)
        return SMODS.add_card({
            set = 'Joker',
            area = G.jokers,
            key = joker_key,
            bypass_discovery_center = true
        })
    end,

    -- ==== IMPORTED FUNCTIONS FROM BUNCO MOD ====
    
    event = function(config)
        local e = Event(config)
        G.E_MANAGER:add_event(e)
        return e
    end,    
    
    big_juice = function(card)
        card:juice_up(0.7)
    end,

    forced_message = function(message, card, color, delay, juice)
        if delay == true then
            delay = 0.7 * 1.25
        elseif delay == nil then
            delay = 0
        end

        Dumb_yet_Dumber.funcs.event({trigger = 'before', delay = delay, func = function()
            if juice then Dumb_yet_Dumber.funcs.big_juice(juice) end
            card_eval_status_text(
                card,
                'extra',
                nil, nil, nil,
                {message = message, colour = color, instant = true}
            )
            return true
        end})
    end,

    -- Post-effect evaluation for enhanced cards
    post_eval_card = function(card, context)
        if not card then return {} end
        if card.ability.set ~= 'Joker' and card.debuff then return {} end
        context = context or {}
        local ret = {}

        if card.ability.set == 'Enhanced' and card.config.center.post_effect then
            local enhancement = card:calculate_enhancement(context)
            if enhancement then
                ret.enhancement = enhancement
            end
        end

        return ret
    end,
}

-- Make Bunco functions globally available
_G.event = Dumb_yet_Dumber.funcs.event
_G.big_juice = Dumb_yet_Dumber.funcs.big_juice
_G.forced_message = Dumb_yet_Dumber.funcs.forced_message
_G.post_eval_card = Dumb_yet_Dumber.funcs.post_eval_card

math.randomseed(os.time())


]]
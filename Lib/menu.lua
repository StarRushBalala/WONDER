menu_cards = {
    'j_dydb_Robin'
}

menu_editions = {
    'e_foil'
}


G.C.OUTER_COLOR = SMODS.Gradients.dydb_OUTER
G.C.INNER_COLOR = SMODS.Gradients.dydb_INNER

local oldfunc = Game.main_menu
Game.main_menu = function(change_context)
    --[[
	for _, v in pairs({
		'mdc_chip', 'MDCchip_mod', 
		'mdc_mult', 'MDCmult_mod', 
		'fact_mult', 'FACTmult_mod', 
		'fact_chip', 'FACTchip_mod', 
		'expofact_mult', 'EXPOFACTmult_mod', 
		'expofact_chip', 'EXPOFACTchip_mod',
		'score', 'score_mod',
		'x_score', 'Xscore_mod',
		'e_score', 'Escore_mod',
		'ee_score', 'EEscore_mod',
		'eee_score', 'EEEscore_mod',
		'hyper_score',
		'eq_mult', 'EQmult_mod',
		'eq_chips', 'EQchip_mod',
		'eq_score', 'EQSCORE_mod',
		'eq_dollars',
		'x_dollars', 'xdollars_mod',
		'super_level_up'
	}) do
		table.insert(SMODS.calculation_keys, v)
	end]]
	local ret = oldfunc(change_context)
	G.SPLASH_BACK:define_draw_steps({{
		shader = "splash",
		send = {
			{name = "time", ref_table = G.TIMERS, ref_value = "REAL_SHADER" },
           	{name = 'vort_speed', val = G.C.vort_speed},
            {name = 'colour_1', ref_table = G.C, ref_value = 'OUTER_COLOR'},
            {name = 'colour_2', ref_table = G.C, ref_value = 'INNER_COLOR'},
            {name = 'mid_flash', ref_table = G.C, ref_value = 'mid_flash'},
		},
	}})

	    --[[random card 
	local chosen = math.random(1, #menu_cards)
    local newcard = create_card(
        'Joker',
        G.title_top, 
        nil, 
        nil, 
        nil, 
        nil, 
        menu_cards[chosen]
        --'dydb_title_card'
    )
    G.title_top:emplace(newcard)
    newcard:start_materialize()
    newcard:resize(1.32)
    newcard.no_ui = true
    --newcard.ability.title_card = true

       -- Recenter the title
    G.title_top.T.w = G.title_top.T.w * 1.7675
    G.title_top.T.x = G.title_top.T.x - 0.8
    G.E_MANAGER:add_event(Event({trigger = "after", delay = 0, blockable = false, blocking = false, func = function()
        if change_context == "splash" then
            newcard.states.visible = true
            newcard:start_materialize({ G.C.MULT }, true, 2.5)
        else
            newcard.states.visible = true
            newcard:start_materialize({ G.C.CHIPS }, nil, 1.2)
        end
        --newcard:set_edition(menu_editions[math.random(1, #menu_editions)], false, false) 
    return true end})) ]]
    

    G.menu_particles = Particles(1, 1, 0, 0, {
        timer = 0.025,
        scale = 0.3,
        initialize = true,
        lifespan = 3,
        speed = 0.5,
        padding = -1,
        attach = G.ROOM_ATTACH,
        colours = { HEX('FFFFFF'), G.C.STAR },
        fill = true
    })
    G.menu_particles.fade_alpha = 0.7
	G.menu_particles:fade(0.7, 0)

	return ret
end
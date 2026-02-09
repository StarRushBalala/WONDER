local jokerInfo = {
	key = "hold_on",
    atlas = 'PLH',
    rarity = 1,
    cost = 5,
    pools = {["dydb_additions"] = true },
    
    unlocked = true,
    discovered = true,
    blueprint_compat = true,

    pos = {x=7, y= 2},
    config = { extra = {multamt = 2, multtotal = 0}},
    loc_txt= {
        name = 'FIRE Writing ???',
        text = { 
            "Aincrement de {C:chips}+#1#{} aux {C:chips}besants{} pour",
            "chascune {C:attention}lettre{} du nom de la {C:attention}carte{}",
            "à sa gauche.",
            "{C:inactive}A présent, {C:chips}+#2#{C:inactive} aux {C:chips}besants{}.",
        }
    },

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.multamt, center.ability.extra.multtotal }  }
	end,

    update = function(self, card, dt)
        if G.jokers then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then _selfid = i end
            end
            if _selfid and G.jokers.cards[_selfid-1] then
                local right_card = G.jokers.cards[_selfid-1]
                local desc = ""

                -- récupérer la description
                if right_card.config.center.name then
                    if type(right_card.config.center.name) == "table" then
                        desc = table.concat(right_card.config.center.name, " ")
                    else
                        desc = tostring(right_card.config.center.name)
                    end
                end

                -- compter toutes les lettres (A-Z et a-z)
                local _, nletters = string.gsub(desc, "[^A-Za-z]", "")
                card.ability.extra.multtotal = nletters * card.ability.extra.multamt
            else
                card.ability.extra.multtotal = 0
            end
        end
    end,


    calculate = function(self, card, context)
        if context.joker_main then
            return {
                color = G.C.CHIP,
                message = "+".. card.ability.extra.multtotal,
                chip_mod = card.ability.extra.multtotal
            }
        end
    end,
}

return jokerInfo
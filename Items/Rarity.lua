SMODS.Gradient{
    key = 'ASCENDANT',
    colours = {HEX('bde0fe'), HEX('ffc8dd')},
    cycle = 6,
    interpolation = 'linear',
}

SMODS.Gradient{
    key = 'DESCENDANT',
    colours = {HEX('93032E'), HEX('151515')},
    cycle = 6,
    interpolation = 'trig',
}

SMODS.Gradient{
    key = 'TRANSCENDANT',
    colours = {HEX('FBF9E4'), HEX('5B88B2'), HEX('122C4F'), G.C.COOL_BLACK},
    cycle = 8,
    interpolation = 'trig',
}

SMODS.Gradient{
    key = 'MYSTERIOUS',
    colours = {G.C.COOL_BLACK, HEX('3C153B')},
    cycle = 8,
    interpolation = 'trig',
}

SMODS.Gradient{
    key = 'OUTER',
    colours = {HEX('A414C8'), HEX('828CFC'), HEX('A414C8'), HEX("253342")},
    cycle = 10,
    interpolation = 'trig',
}

SMODS.Gradient{
    key = 'INNER',
    colours = {HEX("253342"), HEX('A414C8'), HEX('828CFC'), HEX('A414C8')},
    cycle = 10,
    interpolation = 'trig',
}


SMODS.Rarity{
    key = 'epic',
    loc_txt= {
        name = 'Epic',
    },
    badge_colour = HEX("febe00"),
    default_weight = 0.97,
}

SMODS.Rarity{
    key = "mysterious",
    loc_txt = {
        name = "??Ingr?edi?ent??"
    },
    badge_colour = SMODS.Gradients.dydb_MYSTERIOUS,
    default_weight = 0.2,
}

SMODS.Rarity{
    key = "ascendant",
    loc_txt = {
        name = "Ascendant"
    },
    badge_colour = SMODS.Gradients.dydb_ASCENDANT,
    default_weight = 0.01,
}

SMODS.Rarity{
    key = "descendant",
    loc_txt = {
        name = "Descendant"
    },
    badge_colour = SMODS.Gradients.dydb_DESCENDANT,
    default_weight = 0.01,
}

SMODS.Rarity{
    key = "transcendant",
    loc_txt = {
        name = "Transcendant"
    },
    badge_colour = SMODS.Gradients.dydb_TRANSCENDANT,
    default_weight = 0.0,
}

SMODS.Rarity{
    key = 'hyperdescendant',
    loc_txt = {
        name = "HyperDescendant"
    },
    badge_colour = SMODS.Gradients.dydb_DESCENDANT,
    default_weight = 0.0,
}

SMODS.Rarity{
    key = "labubu",
    loc_txt = {
        name = "Labubu"
    },
    badge_colour = G.C.MONEY,
    default_weight = 0.7,
}
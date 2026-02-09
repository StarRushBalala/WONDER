if not Dumb_yet_Dumber then 
    Dumb_yet_Dumber = {}
end

Dumb_yet_Dumber = {
    show_options_button = true,
}

Dumb_yet_Dumber = SMODS.current_mod
Dumb_yet_Dumber_config = Dumb_yet_Dumber.config 
Dumb_yet_Dumber.enabled = copy_table(Dumb_yet_Dumber_config)
conf = SMODS.current_mod.config

SMODS.current_mod.optional_features = {
	retrigger_joker = true
}

--Colors

G.C.COOL_BLACK = HEX("253342")
G.C.STAR = HEX('A414C8')
G.C.EPIC = HEX("febe00")
G.C.ASCENDANT = HEX('bde0fe')   --PLH
G.C.OUTER_COLOR = SMODS.Gradients.dydb_OUTER
G.C.INNER_COLOR = SMODS.Gradients.dydb_INNER
G.C.mid_flash = 0
G.C.vort_time = 7
G.C.vort_speed = 0.4


SMODS.ConsumableType {
    key = "purgatorio", -- this is the key that we will use to tell the localization what consumable to add the text and name to
    collection_rows = {3,4}, -- this is the number of rows that the consumable will take up in the collection, in this case it is 3 rows and 4 columns
    primary_colour = HEX('ffc8dd'), -- this is the primary color of the consumable, you can change this to any color you want
    secondary_colour = HEX('bde0fe'), -- this is the secondary color of the consumable, you can change this to any color you want
    loc_txt = { -- this is how you can add text to your consumable without having a localization file for your mod
        collection = "Purgatorio",
        label = "Purgatorio",
        name = "Purgatorio",
        undiscovered = {
            name = "?",
            text = {
                "Purchase or use",
                "this card in an",
                "unseeded run to",
                "learn what it does" -- this is the text that will be shown when the consumable is not discovered yet
            }
        },
    },
}


SMODS.Atlas {
	key = "modicon",
	path = "icon.png",
	px = 34,
	py = 34
}
SMODS.Atlas {
	key = "tags",
	path = "tags.png",
	px = 34,
	py = 34
}
SMODS.Atlas{
    key = 'blinds',
    path = 'blinds.png',
    px = 34,
    py = 34,
    frames = 21, 
    atlas_table = 'ANIMATION_ATLAS'
}

SMODS.Atlas({
    object_type = "Atlas",
    key = "PLH",
    path = "jokers.png",
    px = 71,
    py = 95,
})
SMODS.Atlas({
    key = "PLH2",
    path = "tarots.png",
    px = 71,
    py = 95,
})
SMODS.Atlas({
    object_type = "Atlas",
    key = "jokers",
    path = "community_jokers.png",
    px = 71,
    py = 95,
})
SMODS.Atlas({
    key = "tarots",
    path = "community_tarots.png",
    px = 71,
    py = 95,
})
SMODS.Atlas({
    key = "sleeves",
    path = "sleeves.png",
    px = 73,
    py = 95,
})
SMODS.Atlas({
    key = "IDK",
    path = "placeholders.png",
    px = 71,
    py = 95,
})



SMODS.ObjectType({
	key = "dydb_additions",
	default = "j_reserved_parking",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
		-- insert base game food jokers
	end,
})

SMODS.ObjectType({
	key = "buddies",
	default = "j_reserved_parking",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
		-- insert base game food jokers
	end,
})
SMODS.ObjectType({
	key = "purgatorio_cons",
	default = "j_reserved_parking",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
	end,
})


local files = {
    "Lib/Utility.lua",
    "Lib/overrides.lua",
    "Lib/compat.lua",
    "Lib/items.lua",
    "Lib/sounds.lua",
    "Lib/misc.lua",
    "Lib/star_suit.lua",
    "Lib/omeganum.lua",
    "Items/Rarity.lua",
    "Lib/menu.lua",
    "Lib/jenlib.lua",
    "Lib/https.lua",

    "Items/scoreoperator.lua",
    "Items/Misc.lua",
    "Items/Challenges.lua",
    "Items/Tags.lua",
    "Items/Sleeves.lua",

}

for _, file in ipairs(files) do
    assert(SMODS.load_file(file))()
end

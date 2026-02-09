local jokerInfo = {
  key = "star_test",
  effect = "Suit Mult",
  config = {
    extra = {
      s_mult = 9,
      suit = 'dydb_Stars'
    }
  },
  rarity = 1,
  pos = { x = 4, y = 2 },
  atlas = "PLH",
  cost = 5,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = true,
  Dumb_yet_Dumber = {
    requires_stars = true
  },

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.extra.s_mult,
      }
    }
  end
}

return jokerInfo
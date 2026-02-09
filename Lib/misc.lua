
-- completely stolen from Cryptid
function get_highlighted_cards(areas, ignore, min, max, blacklist, seed)
	ignore.checked = true
	blacklist = blacklist or function()
		return true
	end
	local cards = {}
	for i, area in pairs(areas) do
		if area.cards then
			for i2, card in pairs(area.cards) do
				if
					card ~= ignore
					and blacklist(card)
					and (card.highlighted)
					and not card.checked
				then
					cards[#cards + 1] = card
					card.checked = true
				end
			end
		end
	end
	for i, v in ipairs(cards) do
		v.checked = nil
	end
	if (#cards >= min and #cards <= max) then
		ignore.checked = nil
		return cards
	else
		for i, v in pairs(cards) do
			v.f_use_order = i
		end
		pseudoshuffle(cards, pseudoseed("forcehighlight" or seed))
		local actual = {}
		for i = 1, max do
			if cards[i] and not cards[i].checked and actual ~= ignore then
				actual[#actual + 1] = cards[i]
			end
		end
		table.sort(actual, function(a, b)
			return a.f_use_order < b.f_use_order
		end)
		for i, v in pairs(cards) do
			v.f_use_order = nil
		end
		ignore.checked = nil
		return actual
	end
	return {}
end

-- also completely stolen from Cryptid 
	-- More advanced version of find joker for things that need to find very specific things
function advanced_find_joker(name, rarity, edition, ability, non_debuff, area)
	local jokers = {}
	if not G.jokers or not G.jokers.cards then
		return {}
	end
	local filter = 0
	if name then
		filter = filter + 1
	end
	if edition then
		filter = filter + 1
	end
	if type(rarity) ~= "table" then
		if type(rarity) == "string" then
			rarity = { rarity }
		else
			rarity = nil
		end
	end
	if rarity then
		filter = filter + 1
	end
	if type(ability) ~= "table" then
		if type(ability) == "string" then
			ability = { ability }
		else
			ability = nil
		end
	end
	if ability then
		filter = filter + 1
	end
	-- return nothing if function is called with no useful arguments
	if filter == 0 then
		return {}
	end
	if not area or area == "j" then
		for k, v in pairs(G.jokers.cards) do
			if v and type(v) == "table" and (non_debuff or not v.debuff) then
				local check = 0
				if name and v.ability.name == name then
					check = check + 1
				end
				if
					edition
					and (v.edition and v.edition.name == edition) --[[ make this use Cryptid.safe_get later? if it's possible anyways]]
				then
					check = check + 1
				end
				if rarity then
					--Passes as valid if rarity matches ANY of the values in the rarity table
					for _, a in ipairs(rarity) do
						if v.config.center.rarity == a then
							check = check + 1
							break
						end
					end
				end
				if ability then
					--Only passes if the joker has everything in the ability table
					local abilitycheck = true
					for _, b in ipairs(ability) do
						if not v.ability[b] then
							abilitycheck = false
							break
						end
					end
					if abilitycheck then
						check = check + 1
					end
				end
				if check == filter then
					table.insert(jokers, v)
				end
			end
		end
	end
	if not area or area == "c" then
		for k, v in pairs(G.consumeables.cards) do
			if v and type(v) == "table" and (non_debuff or not v.debuff) then
				local check = 0
				if name and v.ability.name == name then
					check = check + 1
				end
				if
					edition
					and (v.edition and v.edition.name == edition) --[[ make this use Cryptid.safe_get later? if it's possible anyways]]
				then
					check = check + 1
				end
				if ability then
					--Only passes if the joker has everything in the ability table
					local abilitycheck = true
					for _, b in ipairs(ability) do
						if not v.ability[b] then
							abilitycheck = false
							break
						end
					end
					if abilitycheck then
						check = check + 1
					end
				end
				--Consumables don't have a rarity, so this should ignore it in that case (untested lmfao)
				if check == filter then
					table.insert(jokers, v)
				end
			end
		end
	end
	return jokers
end

--[[
---@param t table
---@param ... any
---@return table|false
--[[
function safe_get(t, ...)
	local current = t
	for _, k in ipairs({ ... }) do
		if not current or current[k] == nil then
			return false
		end
		current = current[k]
	end
	return current
end

function cry_format(number, str)
	if math.abs(to_big(number)) >= to_big(1e300) then
		return number
	end
	return tonumber(str:format((Big and to_number(to_big(number)) or number)))
end

function is_card_big(joker)
	local center = joker.config and joker.config.center
	if not center then
		return false
	end

	if center.immutable and center.immutable == true then
		return false
	end

	if center.mod and not mod_whitelist[center.mod.name] then
		return false
	end

	local in_blacklist = big_num_blacklist[center.key or "Nope!"] or false

	return not in_blacklist --[[or
	       (center.mod and center.mod.id == "dydbptid" and not center.no_break_infinity) or center.break_infinity--]]  --[[
end

function log_random(seed, min, max)
	math.randomseed(seed)
	local lmin = math.log(min, 2.718281828459045)
	local lmax = math.log(max, 2.718281828459045)
	local poll = math.random() * (lmax - lmin) + lmin
	return math.exp(poll)
end

function with_deck_effects(card, func)
	if not card.added_to_deck then
		return func(card)
	else
		card.from_quantum = true
		card:remove_from_deck(true)
		local ret = func(card)
		card:add_to_deck(true)
		card.from_quantum = nil
		return ret
	end
end

function deep_copy(obj, seen)
	if type(obj) ~= "table" then
		return obj
	end
	if seen and seen[obj] then
		return seen[obj]
	end
	local s = seen or {}
	local res = setmetatable({}, getmetatable(obj))
	s[obj] = res
	for k, v in pairs(obj) do
		res[deep_copy(k, s)] = deep_copy(v, s)
	end
	return res
end

function is_big(v)
	if is_big then
		return is_big(v)
	end
	return type(v) == "table" and v.array and v.tetrate
end

function is_number(v)
	if is_number then
		return is_number(v)
	end
	return type(v) == "number" or is_big(v)
end

function sanity_check(val, is_big)
	if not Talisman then
		return val
	end
	if is_big then
		if not val or type(val) == "number" and (val ~= val or val > 1e300 or val < -1e300) then
			val = 1e300
		end
		if is_big(val) then
			return val
		end
		if val > 1e100 or val < -1e100 then
			return to_big(val)
		end
	end
	if not val or type(val) == "number" and (val ~= val or val > 1e300 or val < -1e300) then
		return 1e300
	end
	if is_big(val) then
		if val > to_big(1e300) then
			return 1e300
		end
		if val < to_big(-1e300) then
			return -1e300
		end
		return to_number(val)
	end
	return val
end

function Card:no(m, no_no)
	if no_no then
		-- Infinifusion Compat
		if self.infinifusion then
			for i = 1, #self.infinifusion do
				if
					G.P_CENTERS[self.infinifusion[i].key][m]
					or (G.GAME and G.GAME[m] and G.GAME[m][self.infinifusion[i].key])
				then
					return true
				end
			end
			return false
		end
		if not self.config then
			--assume this is from one component of infinifusion
			return G.P_CENTERS[self.key][m] or (G.GAME and G.GAME[m] and G.GAME[m][self.key])
		end

		return self.config.center[m] or (G.GAME and G.GAME[m] and G.GAME[m][self.config.center_key]) or false
	end
	return Card.no(self, "no_" .. m, true)
end
]]
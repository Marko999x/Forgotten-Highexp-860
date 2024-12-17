-- , "master sorcerer", "elder druid"

local spellList = {
   
    -- All Vocation Spells
	{reborn = 0, spellname = "", spellword = "utani hur", spelltype = "Haste", manacost = "10", vocation={3,4,7,8}},
	{reborn = 0, spellname = "", spellword = "utani gran hur", spelltype = "Haste", manacost = "10", vocation={1,2,5,6}},
	
	-- Sorcerer Spells
	{reborn = 0, spellname = "", spellword = "exevo blind anger", spelltype = "AoE", manacost = "1000", vocation={1,5}},
	
	-- Druid Spells
	{reborn = 0, spellname = "", spellword = "exevo druid fury", spelltype = "AoE", manacost = "1000", vocation={2,6}},
	
	-- Paladin Spells
	{reborn = 0, spellname = "", spellword = "exevo pally deathdrive", spelltype = "AoE", manacost = "1000", vocation={3,7}},
	
	-- Knight Spells
	{reborn = 0, spellname = "", spellword = "knight star", spelltype = "AoE", manacost = "1000", vocation={4,8}},
	


	
}

local showSpells = TalkAction("!spells")

function showSpells.onSay(player,words,param)
	local rebornLvl = player:getReborn()
	if rebornLvl < 0 then
		player:sendTextMessage(MESSAGE_STATUS_SMALL, "You don't have any reborn level.")
		return false
	end
	
	local text = {}
	local spells = {}
	
	for _, spell in ipairs(spellList) do
		if table.contains(spell.vocation,player:getVocation():getId()) then
			spells[#spells + 1] = spell
		end
	end

	table.sort(spells, function(a, b) return a.reborn < b.reborn end)

	local prevLevel = -1
	for i, spell in ipairs(spells) do
		if prevLevel ~= spell.reborn then
			if i == 1 then
				text[#text == nil and 1 or #text+1] = "Spells for Reborn "
			else
				text[#text+1] = "\nSpells for Reborn"
			end
			text[#text+1] = "- [".. spell.reborn .. "]\n"
			prevLevel = spell.reborn
		end
		text[#text+1] = "  " .. spell.spellword .. " - " .. spell.spelltype .. " : " .. spell.manacost .. "\n"
	end

	player:showTextDialog(2175, table.concat(text))
	return false
end

showSpells:separator(" ")
showSpells:register()
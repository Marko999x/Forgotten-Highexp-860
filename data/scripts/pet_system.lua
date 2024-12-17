local summoncapture = Action()

function summoncapture.onUse(player, item, fromPosition, target, toPosition, isHotkey)

local config = {
	['Dwarf Geomancer'] = { reborn = 10, chance = 500, actionid = 46501, des = 'a Dwarf Geomancer Summon Stone', des2 = ''..player:getName()..' has captured this pet.'},
	['Terramite'] = { reborn = 20, chance = 500, actionid = 46502, des = 'a Terramite Summon Stone', des2 = ''..player:getName()..' has captured this pet.'},
	['Wailing Widow'] = { reborn = 50, chance = 350, actionid = 46503, des = 'a Wailing Widow Summon Stone', ''..player:getName()..' has captured this pet.'},
	['Lich'] = { reborn = 75, chance = 350, actionid = 46504, des = 'a Lich Summon Stone', des2 = ''..player:getName()..' has captured this pet.'},
	['Green Hulk'] = { reborn = 100, chance = 200, actionid = 46505, des = 'a Green Hulk Summon Stone', des2 = ''..player:getName()..' has captured this pet.'},
	['Gazer'] = { reborn = 130, chance = 100, actionid = 46506, des = 'a Gazer Summon Stone', des2 = ''..player:getName()..' has captured this pet.'},
	['Lost Husher'] = { reborn = 165, chance = 100, actionid = 46507, des = 'a Lost Husher Summon Stone', des2 = ''..player:getName()..' has captured this pet.'},
	['Hellhound'] = { reborn = 200, chance = 100, actionid = 46508, des = 'a Hellhound Summon Stone', des2 = ''..player:getName()..' has captured this pet.'}
}
		
	local ms = config[target:getName()]
	if not ms then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'This monster can not be captured.')
		return true
	end
	
	local cmaster = target:getMaster()
	if cmaster then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You can not capture summons from players.')
		return true 
	end
	
	if target:getHealth() >= target:getMaxHealth() * 0.1 then -- gives 10% of max health
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'The monster you try to capture does not have less than 10% health.')
        return true
    end
	
	local rd = math.random(1000)	
    if rd <= ms.chance then
		local is = player:addItem(2348, 1, true)
		player:getPosition():sendDistanceEffect(target:getPosition(), 5)
		target:getPosition():sendDistanceEffect(player:getPosition(), 5)
		is:setActionId(ms.actionid)
		is:setAttribute(ITEM_ATTRIBUTE_NAME, ms.des)
		is:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, ms.des2)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Congratz! You have captured "..target:getName().."!")
		target:getPosition():sendMagicEffect(1)
        Game.sendAnimatedText('Captured', target:getPosition(), TEXTCOLOR_RED)
		item:remove(1)
		target:remove(1)
	else
		target:getPosition():sendMagicEffect(1)
		player:getPosition():sendDistanceEffect(target:getPosition(), 5)
		Game.sendAnimatedText('Failed', target:getPosition(), TEXTCOLOR_RED)
		item:remove(1)
    end
    return true
end

summoncapture:id(34006)
--summoncapture:register()
------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------
local config = {
	[7529] = { monster = "dwarf geomancer", reborn = 0, summons = 1, extraHealth = 70000 },
	[46502] = { monster = "terramite", reborn = 20, summons = 1, extraHealth = 80000 },
	[46503] = { monster = "wailing widow", reborn = 50, summons = 1, extraHealth = 90000 },
	[46504] = { monster = "lich", reborn = 75, summons = 1, extraHealth = 100000 },
	[46505] = { monster = "green hulk", reborn = 100, summons = 1, extraHealth = 110000 },
	[46506] = { monster = "gazer", reborn = 130, summons = 1, extraHealth = 120000 },
	[46507] = { monster = "lost husher", reborn = 165, summons = 1, extraHealth = 130000 },
	[46508] = { monster = "hellhound", reborn = 200, summons = 1, extraHealth = 140000 }
}

local summonsystem = Action()

function summonsystem.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	
	local exhaust = 9090
	if player:getExhaustion(exhaust) > 0 then
		return player:sendTextMessage(MESSAGE_INFO_DESCR, "You can spawn your summon again in "..player:getExhaustion(exhaust).." secs")
	end
	
	local ta = config[item.itemid]
	if not ta then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "It seems like this summon stone is not supposed to work, upsssss.")
		return true
	end
	
    if player:getReborn() < ta.reborn then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You must be atleast reborn "..ta.reborn.." to use this summon.")
		return true
    end
		
	local tile = player:getTile()
	local ground = tile:hasFlag(TILESTATE_PROTECTIONZONE) and tile:getGround()
	if ground then
		player:sendCancelMessage("You cannot spawn your summons in protection zone.")
	    return true
	end
        
	local monsterr = player:getSummons()
	local maxSummons = ta.summons
    if #monsterr >= maxSummons then
		for i = 1, #monsterr do
			monsterr[i]:getPosition():sendMagicEffect(CONST_ME_POFF)
			monsterr[i]:getPosition():sendDistanceEffect(player:getPosition(), 5)
			Game.sendAnimatedText('REMOVED', monsterr[i]:getPosition(), TEXTCOLOR_RED)
			monsterr[i]:remove()
            player:setExhaustion(exhaust, 0)
        end
	else
    local monster = Game.createMonster(ta.monster, player:getPosition())
	player:getPosition():sendDistanceEffect(monster:getPosition(), 5)
	monster:setMaxHealth(monster:getMaxHealth() + (player:getReborn() * monster:getMaxHealth() / 2))
	player:addSummon(monster)
	--monster:rename('['..player:getName()..'] '..monster:getName()..'',''..player:getName()..' Pet '..monster:getName()..'')
	--monster:setMaxHealth(monster:getMaxHealth() + (player:getReborn() * ta.extraHealth))
	monster:setHealth(monster:getMaxHealth())
	Game.sendAnimatedText('SPAWNED', monster:getPosition(), TEXTCOLOR_RED)
    player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
    end
	return true
end

for i = 7529, 7530 do
    summonsystem:id(i)
end
summonsystem:register()

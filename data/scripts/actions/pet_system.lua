local summoncapture = Action()

function summoncapture.onUse(player, item, fromPosition, target, toPosition, isHotkey)

local config = {
	['Grizzly Da Bear'] = { chance = 500, actionid = 12000, des = 'It contains a captured Grizzly Da Bear, tammed by '..player:getName()..'\nMax HP[15000000000].'},
	['Worker Golem'] = { chance = 500, actionid = 12001, des = 'It contains a captured Worker Golem, tammed by '..player:getName()..'\nMax HP[15000000000].'},
	['The Masked Marauder'] = { chance = 350, actionid = 12002, des = 'It contains a captured The Masked Marauder, tammed by '..player:getName()..'\nMax HP[15000000000].'},
	['Fire Overlord'] = { chance = 350, actionid = 12003, des = 'It contains a captured Fire Overlord, tammed by '..player:getName()..'\nMax HP[15000000000].'},
	['Young Sea Serpent'] = { chance = 200, actionid = 12004, des = 'It contains a captured Young Sea Serpent, tammed by '..player:getName()..'\nMax HP[15000000000].'},
	['Slick Water Elemental'] = { chance = 100, actionid = 12005, des = 'It contains a captured Slick Water Elemental, tammed by '..player:getName()..'\nMax HP[15000000000].'},
	['Ice OverLord'] = { chance = 100, actionid = 12006, des = 'It contains a captured Ice OverLord, tammed by '..player:getName()..'\nMax HP[15000000000].'},
	['Earth OverLord'] = { chance = 100, actionid = 12007, des = 'It contains a captured Earth Overlord, tammed by '..player:getName()..'\nMax HP[15000000000].'},
	['Energy OverLord'] = { chance = 100, actionid = 12008, des = 'It contains a captured Energy OverLord, tammed by '..player:getName()..'\nMax HP[15000000000].'},
	['Mr Rabbit'] = { chance = 100, actionid = 12009, des = 'It contains a captured Mr Rabbit, tammed by '..player:getName()..'\nMax HP[15000000000].'},
	['Squirrel'] = { chance = 100, actionid = 12010, des = 'It contains a captured Squirrel, tammed by '..player:getName()..'\nMax HP[15000000000].'},
}
		
	local ms = config[target:getName()]
	if not ms then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, 'This monster can not be captured.')
		return true
	end
	
	local cmaster = target:getMaster()
	if cmaster then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, 'You can not capture summons from players.')
		return true 
	end
	
	--if target:getHealth() >= target:getMaxHealth() * 0.1 then -- gives 10% of max health
    --    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'The monster you try to capture does not have less than 10% health.')
    --    return true
    --end
	
	local rd = math.random(1000)	
    if rd <= ms.chance then
		local is = player:addItem(2345, 1, true)
		is:setActionId(ms.actionid)
		is:setAttribute(ITEM_ATTRIBUTE_NAME, 'Pet Holder')
		is:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, ms.des)
		player:say('Congratulations you have success to catch the pet !', TALKTYPE_MONSTER_SAY)
		item:remove(1)
		target:remove(1)
	else
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, 'Sorry you have failed to catch the pet')
		item:remove(1)
    end
    return true
end

summoncapture:id(2574)
summoncapture:register()
------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------
local config = {
	[46501] = { monster = "dwarf geomancer", level = 10, summons = 1, extraHealth = 70000 },
	[46502] = { monster = "terramite", level = 20, summons = 1, extraHealth = 80000 },
	[46503] = { monster = "wailing widow", level = 50, summons = 1, extraHealth = 90000 },
	[46504] = { monster = "lich", level = 75, summons = 1, extraHealth = 100000 },
	[46505] = { monster = "green hulk", level = 100, summons = 1, extraHealth = 110000 },
	[46506] = { monster = "gazer", level = 130, summons = 1, extraHealth = 120000 },
	[46507] = { monster = "lost husher", level = 165, summons = 1, extraHealth = 130000 },
	[46508] = { monster = "hellhound", level = 200, summons = 1, extraHealth = 140000 }
}

local summonsystem = Action()

function summonsystem.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	
	local exhaust = 9090
	if player:getExhaustion(exhaust) > 0 then
		return player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You can spawn your summon again in "..player:getExhaustion(exhaust).." secs")
	end
	
	local ta = config[item.actionid]
	if not ta then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "It seems like this summon stone is not supposed to work, upsssss.")
		return true
	end
	
    if player:getReborn() < ta.level then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You must be atleast level "..ta.level.." to use this summon.")
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
		for i=1, #monsterr do
			monsterr[i]:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            monsterr[i]:remove()
            player:setExhaustion(exhaust, 60)
        end
	else
    local monster = Game.createMonster(ta.monster, player:getPosition())
	player:getPosition():sendDistanceEffect(monster:getPosition(), 5)
	--monster:setMaxHealth(monster:getMaxHealth() + (player:getReborn() * 100000))
	player:addSummon(monster)
	--monster:rename('['..player:getName()..'] '..monster:getName()..'','['..player:getName()..' Pet] '..monster:getName()..'')
	--monster:setMaxHealth(monster:getMaxHealth() + (player:getReborn() * ta.extraHealth))
	--monster:setHealth(monster:getMaxHealth())
    player:getPosition():sendMagicEffect(29)
    end
	return true
end

summonsystem:id(2348)
summonsystem:register()

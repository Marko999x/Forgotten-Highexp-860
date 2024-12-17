local rewards = {
    { 2493, 1 }, 
    { 2494, 1 }, 
    { 2495, 1 }, 
    { 2520, 1 }, 
}

local quest = Action()

function quest.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local storage = 54001
    if player:getStorageValue(storage) == 1 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You alredy got your reward.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return true
    end

    local bag = Game.createItem(1993)
    for _, reward_id in pairs(rewards) do
        bag:addItem(reward_id[1], reward_id[2])
    end

    if player:addItemEx(bag) == RETURNVALUE_NOERROR then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a bag with demon items inside.")
        player:setStorageValue(storage, 1)
		player:getPosition():sendMagicEffect(140)
    else
        local weight = bag:getWeight()
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found a bag weighing " .. weight / 100 .. " oz, it's either too heavy or you do not have enough room.")
    end
    return true
end

quest:aid(54001)
--quest:register()
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local quests = Action()

local config = {
	--- Rebirth Set
	[50000] = { item = 2496, count = 1, storage = 50000 },
	--- Magic Longsword & Soft Boot
	[50001] = { item = 6132, count = 1, storage = 50001 },
	[50002] = { item = 2390, count = 1, storage = 50002 },
	--- Poi Quest
	[50003] = { item = 2280, count = 1, storage = 50003 },
	[50004] = { item = 8926, count = 1, storage = 50004 },
	[50005] = { item = 8927, count = 1, storage = 50005 },
	--- Club / Dragon Scale LEgs Quest
	[50006] = { item = 8929, count = 1, storage = 50006 },
	[50007] = { item = 2469, count = 1, storage = 50007 },
	--- Rebirth Legs
	[50008] = { item = 9928, count = 1, storage = 50008 },
	--- Rebirth 10 Weapons
	[50009] = { item = 8932, count = 1, storage = 50009 },
	[50010] = { item = 7450, count = 1, storage = 50010 },
	--- Rebirth Boots
	[50011] = { item = 3982, count = 1, storage = 50011 },
	--- Pally Weapon
	[50012] = { item = 5803, count = 1, storage = 50012 },
	[50013] = { item = 6529, count = 1, storage = 50013 },
	--- Epic Manarune
	[50014] = { item = 2284, count = 1, storage = 50014 },
	--- Mage Weapon
	[50015] = { item = 2433, count = 1, storage = 50015 },
	--- Freeze Rune
	[50016] = { item = 2309, count = 1, storage = 50016 },
	--- Super Sd Rune
	[50017] = { item = 2263, count = 1, storage = 50017 },
	--- Super Ring Rune
	[50018] = { item = 6512, count = 1, storage = 50018 },
	--- Donation Coin
	[50019] = { item = 9020, count = 2000, storage = 50019 },
	--- Backpack of Holding
	[50020] = { item = 2365, count = 1, storage = 50020 },
	--- Exp Eggs 
	[50021] = { item = 6541, count = 10, storage = 50021 },
	--- Underworld Robe
	[50022] = { item = 8890, count = 1, storage = 50022 },
	--- Underworld Robe
	[50023] = { item = 6542, count = 10, storage = 50023 },
	--- Blue Mage Armor
	[50024] = { item = 8866, count = 1, storage = 50024 },
	--- Blue Mage Helmet
	[50025] = { item = 7902, count = 1, storage = 50025 },

}
	
function quests.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local quest = config[item:getUniqueId()]
	if not quest then 
		return true
	end
  
	if player:getStorageValue(quest.storage) == -1 or player:getAccountType() == ACCOUNT_TYPE_GOD then
		local items = player:addItem(quest.item, quest.count)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You have found '..quest.count..'x ' .. ItemType(items:getId()):getName() .. '.')
		player:setStorageValue(quest.storage, 1)
		player:getPosition():sendMagicEffect(CONST_ME_DRAWBLOOD)
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'It is empty.')
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
	end
    return true
end

for i = 50000, 50022 do
	quests:uid(i)
end

quests:register()
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local questSpell = Action()

local config = {
    [1] = {spell = "utito poison"},
    [2] = {spell = "utito flam"},
    [3] = {spell = "utito energy"},
    [4] = {spell = "utito frigo"},
    [5] = {spell = "utito poison"},
    [6] = {spell = "utito flam"},
    [7] = {spell = "utito energy"},
    [8] = {spell = "utito flam"}
}

function questSpell.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local quest = config[player:getVocation():getId()]
	if player:hasLearnedSpell(quest.spell) then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You alredy learned the utito spell!')
        return true
    end
    player:getPosition():sendMagicEffect(140)
    player:learnSpell(quest.spell)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You have learned '..quest.spell..'')
    return true
end
	
--questSpell:aid(49001)
--questSpell:register()
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

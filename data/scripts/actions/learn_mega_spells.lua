local action = Action()

local spellName = "mega vis"

local vocations = {1, 5, 9, 13, 17, 21, 25}

function action.onUse(player, item, fromPos, target, toPos, isHotkey)
	if not table.contains(vocations, player:getVocation():getId()) then
		player:sendTextMessage(MESSAGE_INFO_DESCR, 'Your vocation can not learn this spell.')
		return true
	end
	if player:hasLearnedSpell(spellName) then
		player:sendTextMessage(MESSAGE_EVENT_ORANGE, 'You alredy learned '..spellName..' spell.')
		return true
	end
	player:learnSpell(spellName)
	player:sendTextMessage(MESSAGE_EVENT_ORANGE, 'Congratz! You learned '..spellName..' spell!')
	player:getPosition():sendMagicEffect(CONST_ME_HEARTS)
	item:remove(1)
	return true
end

action:id(1967)
action:register()
-------------------------------------------------------------------------------------------------------------
local action = Action()

local spellName = "mega frigo"

local vocations = {2, 6, 10, 14, 18, 22, 26}

function action.onUse(player, item, fromPos, target, toPos, isHotkey)
	if not table.contains(vocations, player:getVocation():getId()) then
		player:sendTextMessage(MESSAGE_INFO_DESCR, 'Your vocation can not learn this spell.')
		return true
	end
	if player:hasLearnedSpell(spellName) then
		player:sendTextMessage(MESSAGE_EVENT_ORANGE, 'You alredy learned '..spellName..' spell.')
		return true
	end
	player:learnSpell(spellName)
	player:sendTextMessage(MESSAGE_EVENT_ORANGE, 'Congratz! You learned '..spellName..' spell!')
	player:getPosition():sendMagicEffect(CONST_ME_HEARTS)
	item:remove(1)
	return true
end

action:id(1948)
action:register()
-------------------------------------------------------------------------------------------------------------
local action = Action()

local spellName = "mega holy"

local vocations = {3, 7, 11, 15, 19, 23, 27}

function action.onUse(player, item, fromPos, target, toPos, isHotkey)
	if not table.contains(vocations, player:getVocation():getId()) then
		player:sendTextMessage(MESSAGE_INFO_DESCR, 'Your vocation can not learn this spell.')
		return true
	end
	if player:hasLearnedSpell(spellName) then
		player:sendTextMessage(MESSAGE_EVENT_ORANGE, 'You alredy learned '..spellName..' spell.')
		return true
	end
	player:learnSpell(spellName)
	player:sendTextMessage(MESSAGE_EVENT_ORANGE, 'Congratz! You learned '..spellName..' spell!')
	player:getPosition():sendMagicEffect(CONST_ME_HEARTS)
	item:remove(1)
	return true
end

action:id(1961)
action:register()
-------------------------------------------------------------------------------------------------------------
local action = Action()

local spellName = "mega gran"

local vocations = {4, 8, 12, 16, 20, 24, 28}

function action.onUse(player, item, fromPos, target, toPos, isHotkey)
	if not table.contains(vocations, player:getVocation():getId()) then
		player:sendTextMessage(MESSAGE_INFO_DESCR, 'Your vocation can not learn this spell.')
		return true
	end
	if player:hasLearnedSpell(spellName) then
		player:sendTextMessage(MESSAGE_EVENT_ORANGE, 'You alredy learned '..spellName..' spell.')
		return true
	end
	player:learnSpell(spellName)
	player:sendTextMessage(MESSAGE_EVENT_ORANGE, 'Congratz! You learned '..spellName..' spell!')
	player:getPosition():sendMagicEffect(CONST_ME_HEARTS)
	item:remove(1)
	return true
end

action:id(1964)
action:register()




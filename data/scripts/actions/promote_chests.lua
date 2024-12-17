local config = {
	[5] = {newVocation = 9},
	[6] = {newVocation = 10},
	[7] = {newVocation = 11},
	[8] = {newVocation = 12}
}

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	local voc = config[player:getVocation():getId()]
	if player:getVocation():getId() > 8 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You alredy took the promotion.')
		return true
	end
	
	if not voc then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Sorry, you need to get the first promotion to get the new mixed promotion.')
		return true
	end
	
	player:setVocation(voc.newVocation)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Congratz you have been promoted to '..player:getVocation():getName()..'! You have received as a reward for getting the promotion a new spell!')
	player:getPosition():sendMagicEffect(36)
	player:save()
	return true
end

action:aid(6500)
action:register()
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local config = {
	[9] = {newVocation = 13},
	[10] = {newVocation = 14},
	[11] = {newVocation = 15},
	[12] = {newVocation = 16}
}

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	local voc = config[player:getVocation():getId()]
	if player:getVocation():getId() > 12 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You alredy took the promotion.')
		return true
	end
	
	if not voc then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Sorry, you need to get the mixed promotion to get the new spin promotion.')
		return true
	end
	player:setVocation(voc.newVocation)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Congratz you have been promoted to '..player:getVocation():getName()..'! You have received as a reward for getting the promotion a new spell!')
	player:getPosition():sendMagicEffect(36)
	player:save()
	return true
end

action:aid(6501)
action:register()
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local config = {
	[13] = {newVocation = 17},
	[14] = {newVocation = 18},
	[15] = {newVocation = 19},
	[16] = {newVocation = 20}
}

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	local voc = config[player:getVocation():getId()]
	if player:getVocation():getId() > 16 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You alredy took the promotion.')
		return true
	end
	
	if not voc then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Sorry, you need to get the spin promotion to get the new epic promotion.')
		return true
	end
	player:setVocation(voc.newVocation)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Congratz you have been promoted to '..player:getVocation():getName()..'! You have received as a reward for getting the promotion a new spell!')
	player:getPosition():sendMagicEffect(36)
	player:save()
	return true
end

action:aid(6502)
action:register()
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local config = {
	[17] = {newVocation = 21},
	[18] = {newVocation = 22},
	[19] = {newVocation = 23},
	[20] = {newVocation = 24}
}

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	local voc = config[player:getVocation():getId()]
	if player:getVocation():getId() > 20 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You alredy took the promotion.')
		return true
	end
	
	if not voc then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Sorry, you need to get the epic promotion to get the new nova promotion.')
		return true
	end
	player:setVocation(voc.newVocation)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Congratz you have been promoted to '..player:getVocation():getName()..'! You have received as a reward for getting the promotion a new spell!')
	player:getPosition():sendMagicEffect(36)
	player:save()
	return true
end

action:aid(6503)
action:register()
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local config = {
	[21] = {newVocation = 25},
	[22] = {newVocation = 26},
	[23] = {newVocation = 27},
	[24] = {newVocation = 28}
}

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	local voc = config[player:getVocation():getId()]
	if player:getVocation():getId() > 24 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You alredy took the promotion.')
		return true
	end
	
	if not voc then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Sorry, you need to get the nova promotion to get the new hellborn promotion.')
		return true
	end
	player:setVocation(voc.newVocation)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Congratz you have been promoted to '..player:getVocation():getName()..'! You have received as a reward for getting the promotion a new spell!')
	player:getPosition():sendMagicEffect(36)
	player:save()
	return true
end

action:aid(6504)
action:register()
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local moveEvent = MoveEvent()

function moveEvent.onStepIn(player, item, pos, fromPosition)
	if not player then
		return true
	end
	if player:isVip() then
		player:sendTextMessage(MESSAGE_EVENT_ORANGE, 'Welcome to VIP area!')
		player:teleportTo(Position(828, 1212, 7))
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	else
		player:teleportTo(fromPosition)
		player:sendTextMessage(MESSAGE_EVENT_ORANGE, 'Sorry, only VIP players can pass this teleport.')
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	end
	return true
end

moveEvent:aid(31052)
moveEvent:register()

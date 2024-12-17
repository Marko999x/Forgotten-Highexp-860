local moveEvent = MoveEvent()

function moveEvent.onStepIn(player, item, pos, fromPosition)
	if not player then
		return true
	end
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Currenty all cities are closed.')
	player:teleportTo(fromPosition)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

moveEvent:aid(31055)
moveEvent:register()

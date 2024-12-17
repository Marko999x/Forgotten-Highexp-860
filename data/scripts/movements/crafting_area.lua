local moveEvent = MoveEvent()

function moveEvent.onStepIn(player, item, pos, fromPosition)
	if not player then
		return true
	end
	player:teleportTo(fromPosition)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Currently all crafting area spawns are closed. It will be open in the future.')
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

moveEvent:aid(52778)
moveEvent:register()

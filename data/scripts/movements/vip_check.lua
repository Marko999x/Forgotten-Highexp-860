local moveEvent = MoveEvent()

function moveEvent.onStepIn(player, item, pos, fromPosition)
	if not player then
		return true
	end
	if not player:isVip() then
		player:teleportTo(Position(2000, 2000, 7))
		player:sendTextMessage(MESSAGE_EVENT_ORANGE, 'Sorry, only VIP players can pass! If you try to glitch again you will be banned.')
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	end
	return true
end

moveEvent:aid(31053)
moveEvent:register()

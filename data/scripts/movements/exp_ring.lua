local moveEvent = MoveEvent()

function moveEvent.onEquip(player, item, slot, isCheck)
	if isCheck then
		return true
	end
	player:sendTextMessage(MESSAGE_INFO_DESCR, 'DOUBLE EXP ON')
	return false
end

moveEvent:id(6300)
moveEvent:slot("ring")
moveEvent:register()


local moveEvent = MoveEvent()

function moveEvent.onDeEquip(player, item, slot, isCheck)
	player:sendTextMessage(MESSAGE_INFO_DESCR, 'DOUBLE EXP OFF')
	return false
end

moveEvent:id(6301)
moveEvent:slot("ring")
moveEvent:register()

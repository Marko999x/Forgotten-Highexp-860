local moveEvent = MoveEvent()

local config = { 
	{range = {0, 19}, position = Position(454, 774, 4)},
	{range = {20, 49}, position = Position(454, 791, 4)},
	{range = {50, 99}, position = Position(454, 799, 4)},
	{range = {100, 149}, position = Position(454, 807, 4)},
}

function moveEvent.onStepIn(player, item, pos, fromPosition)
	local rebirth = player:getReborn()
	for _, reb in pairs(config) do
		if rebirth >= reb.range[1] and rebirth <= reb.range[2] then
			player:teleportTo(reb.position)
			player:sendTextMessage(MESSAGE_INFO_DESCR, 'You have been teleported to monsters for your rebirth.')
			break
		end
	end
	return true
end

moveEvent:aid(30909)
moveEvent:register()

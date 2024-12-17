local movement = MoveEvent()
movement:type("stepin")

local config = {
	[12000] = { description = 'You have been teleported to the hunting area. Every hunting place contains a hidden chests which contains unique items or attribute points.' },
	[12001] = { reborn = 10 },
	[12002] = { reborn = 15 },
	[12003] = { reborn = 20 },
}

function movement.onStepIn(player, item, position, fromPosition)
	if not player then
		return true
	end
	local id = config[item:getActionId()]
	player:sendTextMessage(MESSAGE_EVENT_ORANGE, id.description)
    --player:teleportTo(fromPosition)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

for i = 12000, 12003 do
	movement:aid(i)
end

--movement:register()

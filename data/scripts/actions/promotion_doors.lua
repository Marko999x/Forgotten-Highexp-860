local action = Action()

local config = {
	[6505] = {reb = 50, pos = Position(1004, 998, 5)},
	[6506] = {reb = 100, pos = Position(1002, 998, 5)},
	[6507] = {reb = 200, pos = Position(1000, 998, 5)},
	[6508] = {reb = 400, pos = Position(998, 998, 5)},
	[6509] = {reb = 750, pos = Position(996, 998, 5)},
}

function action.onUse(player, item, fromPos, target, toPos, isHotkey)
	local promoteDoors = config[item:getActionId()]
	if player:getReborn() < promoteDoors.reb then
		player:sendTextMessage(MESSAGE_EVENT_ORANGE, 'Sorry, you must be rebirth '..promoteDoors.reb..' or higher to pass this door.')
		return true
	end
	player:teleportTo(promoteDoors.pos)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

for v, k in pairs(config) do
	action:aid(v)
end
action:register()
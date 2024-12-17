local action = Action()

local config = {
	[46500] = {rebirth = 5, position = Position(397, 473, 7)},
	[46501] = {rebirth = 15, position = Position(407, 473, 7)},
	[46502] = {rebirth = 30, position = Position(397, 480, 7)},
	[46503] = {rebirth = 50, position = Position(407, 480, 7)},
	[46504] = {rebirth = 100, position = Position(397, 487, 7)},
	[46505] = {rebirth = 200, position = Position(407, 487, 7)},
	[46506] = {rebirth = 300, position = Position(397, 494, 7)},
	[46507] = {rebirth = 500, position = Position(407, 494, 7)},
	[46508] = {rebirth = 700, position = Position(397, 501, 7)},
	[46509] = {rebirth = 850, position = Position(407, 501, 7)},
}

function action.onUse(player, item, fromPos, target, toPos, isHotkey)
	local rebBoss = config[item:getActionId()]
	if not rebBoss then
		return true
	end
	if not player then
		return true
	end
	if player:getReborn() < rebBoss.rebirth then
		player:sendTextMessage(MESSAGE_EVENT_ORANGE, 'Sorry, you need atleast '..rebBoss.rebirth..' rebirths to pass this door.')
		player:teleportTo(fromPosition)
		return true
	end
	player:teleportTo(rebBoss.position)
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
	return true
end

for v, k in pairs(config) do
	action:aid(v)
end
action:register()

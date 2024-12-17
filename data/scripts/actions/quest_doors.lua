local action = Action()

local config = {
	[48500] = {rebirth = 25, position = Position(583, 500, 7)},
	[48501] = {rebirth = 25, position = Position(597, 500, 7)},
	[48502] = {rebirth = 35, position = Position(597, 506, 7)},
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
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Sorry, you need atleast '..rebBoss.rebirth..' rebirths to pass this door.')
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

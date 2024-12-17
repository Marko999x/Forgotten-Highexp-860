local action = Action()

local config = {
	[48700] = {rebirth = 500, position = Position(447, 804, 4)},
	[48701] = {rebirth = 500, position = Position(447, 806, 4)},
	[48702] = {rebirth = 500, position = Position(447, 808, 4)},
	[48703] = {rebirth = 500, position = Position(447, 810, 4)},
	[48704] = {rebirth = 500, position = Position(461, 804, 4)},
	[48705] = {rebirth = 500, position = Position(461, 806, 4)},
	[48706] = {rebirth = 500, position = Position(461, 808, 4)},
	[48707] = {rebirth = 500, position = Position(461, 810, 4)},

	[48708] = {rebirth = 500, position = Position(461, 810, 4)},
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

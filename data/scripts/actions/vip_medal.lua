local action = Action()

function action.onUse(player, item, fromPos, target, toPos, isHotkey)
	for _, playerOnline in ipairs(Game.getPlayers()) do
		playerOnline:sendTextMessage(MESSAGE_STATUS_WARNING, 'CONGRATULATIONS, '..player:getName()..' You are now a VIP for 30 days! You can now enter the VIP-area and use unique features!')
	end
	player:addVipDays(30)
	player:getPosition():sendMagicEffect(28)
	item:remove(1)
	return true
end

action:id(5785)
action:register()



local action = Action()

function action.onUse(player, item, fromPos, target, toPos, isHotkey)
	for _, playerOnline in ipairs(Game.getPlayers()) do
		playerOnline:sendTextMessage(MESSAGE_STATUS_WARNING, 'CONGRATULATIONS, '..player:getName()..' You are now a VIP for 7 days! You can now enter the VIP-area and use unique features!')
	end
	player:addVipDays(7)
	player:getPosition():sendMagicEffect(28)
	item:remove(1)
	return true
end

action:id(6511)
action:register()


local action = Action()

local storage = 304930
local config = {
	[{1, 5}] = {itemId = 2160, itemCount = 2, text = "Batman"}
}

function action.onUse(player, item, fromPos, target, toPos, isHotkey)
	if player:getStorageValue(storage) > 0 then
		player:sendCancelMessage("This chest is empty.")
		return true
	end
	if table.contains(config, player:getVocation():getId()) then
		player:addItem(vocation.itemId, vocation.itemCount)
		player:getPosition():sendMagicEffect(15)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, vocation.text)
	end
	return true
end

action:aid(10577)
action:register()
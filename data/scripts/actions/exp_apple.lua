local action = Action()

local expAppleStorage = 29582

function action.onUse(player, item, fromPos, target, toPos, isHotkey)
	
	player:setStorageValue(expAppleStorage, os.time() + 7200)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You have activated double experience for 2 hours')
	player:getPosition():sendTextMessage(CONST_ME_SKULLHORIZONTAL)
	player:getPosition():sendTextMessage(CONST_ME_SKULLVERTICAL)
	item:remove(1)
	return true
end

action:id(10553)
action:register()

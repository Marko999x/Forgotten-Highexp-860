local storage = 9332

function onSay(player, words, param)
	if player:getStorageValue(storage) > os.time() then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You can use the command again in: "..player:getStorageValue(storage) - os.time().." seconds.")
		return false
	end
	if player:getGroup():getAccess() then
		player:setSex(player:getSex() == PLAYERSEX_FEMALE and PLAYERSEX_MALE or PLAYERSEX_FEMALE)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have changed your sex.")
		return false
	end
	player:setSex(player:getSex() == PLAYERSEX_FEMALE and PLAYERSEX_MALE or PLAYERSEX_FEMALE)
	player:sendTextMessage(MESSAGE_INFO_DESCR, "You have changed your sex.")
	player:setStorageValue(storage, 60 + os.time())
	return false
end

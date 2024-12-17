function onSay(player, words, param)
    if not param or param == '' then
        player:sendTextMessage(36, "Usage: !exiva on or !exiva off")
        return false
    end
	if not player:getVocation():getId() == 1 or not player:getVocation():getId() == 5 then
		return true
	end
	local storage = 3944
	if param == "on" then
		if player:getStorageValue(storage) == 1 then
			player:setStorageValue(storage, -1)
			player:sendTextMessage(36, "Players can exiva you now.")
		end
	elseif param == "off" then
		if player:getStorageValue(storage) == -1 then
			player:setStorageValue(storage, 1)
			player:sendTextMessage(36, "Players can not exiva you now.")
		end
	end
	return false
end

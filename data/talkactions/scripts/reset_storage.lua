local resetStorage = TalkAction("/storage")

function resetStorage.onSay(player,words,param)
	if not player:getGroup():getAccess() then
		return true
	end

	if player:getAccountType() < ACCOUNT_TYPE_GOD then
		return false
	end

	local split = param:splitTrimmed(",")
	if not split[1] then
		player:sendCancelMessage("Insufficient parameters.")
		return true
	end
	if not split[2] then
		player:sendCancelMessage("Insufficient parameters.")
		return true
	end

	local target = Player(split[1])
	if not target then
		player:sendCancelMessage("A player with that name is not online.")
		return false
	end
	local value = -1
	if tonumber(split[3]) >= 0 then
		value = tonumber(split[3])
	end

	target:setStorageValue(split[2],value)
	player:sendCancelMessage(split[1] .. "Had storage: ".. split[2] .." changed.")
	return true
end

resetStorage:separator(" ")
resetStorage:register()
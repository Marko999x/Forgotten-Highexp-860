-- <talkaction words="/points" separator=" " script="change premium points.lua" />

function string:firstToUpper()
    return self:gsub("^%l", string.upper)
end

function onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end

	if player:getAccountType() < ACCOUNT_TYPE_GOD then
		return false
	end
	
    local split = param:splitTrimmed(",")
    if param == '' then
        doPlayerSendTextMessage(player, MESSAGE_STATUS_CONSOLE_BLUE, "Missing params.")
        return true
    end

    local command = split[1]
    if not command or not isInArray({"add", "remove"}, command:lower()) then
        doPlayerSendTextMessage(player, MESSAGE_STATUS_CONSOLE_BLUE, "Wrong usage, type '/points add, whiteblXK, 500' or '/points remove, whiteblXK, 500'")
        return true
    end
    
    local name, accountId = split[2], nil
    local resultId = db.storeQuery('SELECT `account_id` FROM `players` WHERE `name` = ' .. db.escapeString(name) .. ' LIMIT 1;')
    if resultId ~= false then
        accountId = result.getDataInt(resultId, "account_id")
        result.free(resultId)
    end

    if not accountId then
        doPlayerSendTextMessage(player, MESSAGE_STATUS_CONSOLE_BLUE, "Player with this name doesn't exsist.")
        return true
    end

    local points = split[3]
    if not points or not isNumber(points) then
        doPlayerSendTextMessage(player, MESSAGE_STATUS_CONSOLE_BLUE, "Missing ammount of points.")
        return true
    end
    
    local target = Player(name)
    command = command:lower()
    if command == "add" then
        doPlayerSendTextMessage(player, MESSAGE_STATUS_CONSOLE_ORANGE, string.format("You have added %s premium points to %s.", points, name:firstToUpper()))
        if target ~= nil then
            doPlayerSendTextMessage(target, MESSAGE_STATUS_CONSOLE_ORANGE, string.format("You have got %s premium points from %s.", points, player:getName()))
        end

        db.query("UPDATE `accounts` SET `premium_points` = `premium_points` + " .. points .. " WHERE `id` = " .. accountId)
    elseif command == "remove" then
        local currentPoints = 0
        local resultId = db.storeQuery('SELECT `premium_points` FROM `accounts` WHERE `id` = ' .. accountId .. ' LIMIT 1;')
        if resultId ~= false then
            currentPoints = result.getDataInt(resultId, "premium_points")
            result.free(resultId)
        end

        local change = math.max(0, currentPoints - points)
        doPlayerSendTextMessage(player, MESSAGE_STATUS_CONSOLE_ORANGE, string.format("You have removed %s premium points from %s.", change == 0 and "all" or points, name))
        if target ~= nil then
            doPlayerSendTextMessage(target, MESSAGE_STATUS_CONSOLE_ORANGE, string.format("Your %s premium points has been removed by %s.", change == 0 and "all" or points, player:getName()))
        end

        db.query("UPDATE `accounts` SET `premium_points` = " .. change .. " WHERE `id` = " .. accountId)
    end
 
    return true
end
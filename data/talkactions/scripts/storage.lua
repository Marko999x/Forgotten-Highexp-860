function onSay(player, words, param)
    if not player:getGroup():getAccess() then
        return true
    end

    local split = param:split(",")
    local target = Player(split[1])
   
    if target == nil then
        player:sendCancelMessage("A player with that name is not online.")
        return false
    end

    local value = tonumber(split[2])
   
    if(value == nil or value <= 0)then
        player:sendCancelMessage("You need to put the storage to verify.")
        return false
    end

    local storage = getPlayerStorageValue(target, value)   
    local key = split[3]
    if key == nil then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Storage Key: " .. value .. " Storage Value: " .. storage)
    else
        setPlayerStorageValue(target.uid, value, key)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have set Storage Key: " .. value .. " Storage Value: " .. key .. ".")
    end
    return false
end
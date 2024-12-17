function onSay(player, words, param)
    if player:getStorageValue(48091) <= 0 then
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "effects active.")
        player:setStorageValue(48091, 1)
    else
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "effects deactive.")
        player:setStorageValue(48091, -1)     
    end 
    return false
end
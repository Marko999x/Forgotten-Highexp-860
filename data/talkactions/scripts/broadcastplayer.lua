local config = {
storage = 19400, --time storage
exhtime = 1 * 60, -- time 1=1min
price = 1000, -- price for use or broadcast
level = 100 -- level pra to use or broadcast
}


function onSay(player, words, param)
local timetobr = player:getStorageValue(config.storage)-os.time()
    if (param == '') then
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Command param required.")
    elseif player:getLevel() < config.level then
            player:SendCancelMessage(cid, "You have to be level "..config.Level.." or more in order to use broadcast.")
    elseif player:getStorageValue(config.storage) > os.time() then
            player:sendTextMessage(MESSAGE_STATUS_SMALL, "You have to wait "..timetobr.."seconds until you can broadcast again.")
    elseif player:getMoney() < config.price then
                player:sendTextMessage(MESSAGE_STATUS_SMALL, "You do not have "..config.price.." gold for broadcasting.")
    return true
    end
        player:removeMoney(config.price)
        player:setStorageValue(config.storage, os.time() + config.exhtime)
            print("> " .. player:getName() .. " broadcasted: \"" .. param .. "\".")
    for _, targetPlayer in ipairs(Game.getPlayers()) do
        targetPlayer:sendPrivateMessage(player, param, MESSAGE_EVENT_ADVANCE)
    end
    return true
end
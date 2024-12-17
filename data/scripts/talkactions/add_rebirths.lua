local addRebornScript = TalkAction("/addrebirth")

function addRebornScript.onSay(player, words, param)
    if player:getAccountType() < ACCOUNT_TYPE_GOD then
        return false
    end
    local split = param:splitTrimmed(",")
    local target = Player(split[1])
    if not target then
        player:sendCancelMessage("A player with that name is not online.")
        return false
    end
    local amount = tonumber(split[2])
    if not amount or amount < 1 then
        player:sendCancelMessage("Insufficient parameters.")
        return false
    end
    if amount > 125 then
        player:sendTextMessage(MESSAGE_EVENT_ORANGE, 'You can not add more than 125 rebirths at the same time to avoid getting debug.')
        return false
    end
    target:setStorageValue(999999, 0)
    for i = 1, amount do
        target:addLevel(1500000)
    end
    target:setStorageValue(999999, -1)
    target:addLevel(1)
    player:sendTextMessage(MESSAGE_EVENT_ORANGE, ''..target:getName()..' has received '..amount..'x rebirths from '..player:getName()..'')
    return false
end

addRebornScript:separator(" ")
addRebornScript:register()
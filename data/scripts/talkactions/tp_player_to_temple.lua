local talkaction = TalkAction("/t")

local effect = CONST_ME_TELEPORT

function talkaction.onSay(player, words, param)
    if player:getAccountType() < ACCOUNT_TYPE_GOD then
        return false
    end
    if param == '' then
        player:teleportTo(player:getTown():getTemplePosition())
        player:getPosition():sendMagicEffect(effect)
    end
    local target = Player(param)
    if not target then
        player:sendCancelMessage("A player with that name is not online.")
        return false
    end
    target:teleportTo(player:getTown():getTemplePosition())
    target:getPosition():sendMagicEffect(effect)
    target:sendTextMessage(MESSAGE_INFO_DESCR, 'You have been teleported from ['..player:getName()..'] to temple.')
    return false
end

talkaction:separator(" ")
--talkaction:register()
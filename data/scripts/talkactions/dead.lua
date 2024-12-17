local deadTalk = TalkAction("!dead")

function deadTalk.onSay(player, words)
    if player:getStorageValue(93019) == 1 then
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, 'You can not use dead in jail.')
        return false
    end
    player:getPosition():sendMagicEffect(CONST_ME_HITBYFIRE)
    player:addHealth(-9999999909999)
    return false
end

deadTalk:separator(" ")
deadTalk:register()

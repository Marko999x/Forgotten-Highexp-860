local config = {
    effect = 25,
    text = 'AFK'
}

event = event or {}

function delayedAnimatedText(cid)
    local player = Player(cid)
    if player then
        Game.sendAnimatedText(config.text, player:getPosition(), 210)
        event[cid] = addEvent(delayedAnimatedText, 1 * 2000, cid)
    else
        event[cid] = nil
    end
end

function onSay(player, words, param)
    if not param or param == '' then
        player:sendTextMessage(36, "Command param required")
        return false
    end

    local cid = player.uid
    if param == "on" then
        if not event[cid] then
            player:setMovementBlocked(true)
            player:say('AFK online', TALKTYPE_MONSTER_SAY)
            event[cid] = addEvent(delayedAnimatedText, 1 * 1000, player:getId())
        else
            player:say('AFK online alredy', TALKTYPE_MONSTER_SAY)
        end
    elseif param == "off" then
        if event[cid] then
            player:setMovementBlocked(false)
			player:say('AFK offline', TALKTYPE_MONSTER_SAY)
            stopEvent(event[cid])
            event[cid] = nil
        end
    end
    return false
end
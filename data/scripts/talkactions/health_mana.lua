local talkAction = TalkAction("!health")

function talkAction.onSay(player, words, param, type)
    player:sendTextMessage(MESSAGE_EVENT_ORANGE, 'Your max health: '..player:getMaxHealth()..'')
    return false
end

talkAction:register()



local talkAction = TalkAction("!mana")

function talkAction.onSay(player, words, param, type)
    player:sendTextMessage(MESSAGE_EVENT_ORANGE, 'Your max mana: '..player:getMaxMana()..'')
    return false
end

talkAction:register()

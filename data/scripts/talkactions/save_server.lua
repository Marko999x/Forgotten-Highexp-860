local saveServerCommand = TalkAction("/save")

function saveServerCommand.onSay(player, words, param)
    if player:getAccountType() < ACCOUNT_TYPE_GOD then
        return false
    end
    saveServer()
    print('Gameworld has been saved by: '..player:getName()..'')
    player:sendTextMessage(MESSAGE_EVENT_ORANGE, 'You saved the gameworld.')
    return false
end

saveServerCommand:separator(" ")
saveServerCommand:register()
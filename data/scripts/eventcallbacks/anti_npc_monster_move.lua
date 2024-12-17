local ec = EventCallback

function ec.onMoveCreature(player, creature, fromPosition, toPosition)
    if player:getAccountType() == ACCOUNT_TYPE_GOD then
        return true
    end
    if creature:isNpc() or creature:isMonster() then
        player:sendTextMessage(MESSAGE_INFO_DESCR,'You can not push a monster or a npc.')
        return false
    end
    return true
end

ec:register()

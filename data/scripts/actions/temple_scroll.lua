local action = Action()

local exhaustTpScroll = {}

function action.onUse(player, item, fromPos, target, toPos, isHotkey)

    if player:hasCondition(CONDITION_INFIGHT) == true then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You can not use it if you are in a fight.')
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return true
    end
    local playerGuid = player:getGuid()
    local timeAmount = exhaustTpScroll[playerGuid]
    if timeAmount and timeAmount > os.time() then
    	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You must wait " .. (timeAmount - os.time()) .. " seconds.")
    	return true
    end
    player:getPosition():sendMagicEffect(CONST_ME_BATS)
    player:teleportTo(Position(2000,2000,7))
    player:getPosition():sendMagicEffect(CONST_ME_BATS)
    exhaustTpScroll[playerGuid] = os.time() + 15 -- 60 seconds
    return true
end

action:id(5952)
action:register()

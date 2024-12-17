local config = {
    ['temple'] = { pos = Position(1000,1000,7), text = "temple", effect = 1 },
    ['depo'] = { pos = Position(2000,2000,7), text = "depo", effect = 1 },
    ['monks'] = { pos = Position(1000,1000,7), text = "depo", effect = 1 }
}

local fly = TalkAction("!fly")

function fly.onSay(player, words, param)
    
    local fly = config[param:lower()]
    if not fly then
        player:sendTextMessage(36, "Unknown destination")
        return false
    end
  
	local storage = 52346
    if player:getStorageValue(storage) >= os.time() then
        player:sendTextMessage(MESSAGE_INFO_DESCR, 'You can fly again in '..player:getStorageValue(storage) - os.time()..' seconds')
        return false
    end
	
    if player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT) then
        player:sendTextMessage(MESSAGE_INFO_DESCR, 'Sorry but you can not fly while being in a fight.')
        return false
    end
	
    player:say('Bye', TALKTYPE_MONSTER_SAY)
    player:teleportTo(fly.pos)
    player:say('Welcome', TALKTYPE_MONSTER_SAY)
    player:getPosition():sendMagicEffect(fly.effect)
	player:setStorageValue(storage, os.time() + 10)
    Game.broadcastMessage(''..player:getName()..' has fly to '..fly.text..'', MESSAGE_INFO_DESCR)
    return false
end

fly:separator(" ")
fly:register()
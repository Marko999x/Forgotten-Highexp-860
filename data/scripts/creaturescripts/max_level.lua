--------------------------------------------------------------------------------
-- EVENT
--------------------------------------------------------------------------------
local maxLevelMessage = CreatureEvent("maxLevelMessage")

function maxLevelMessage.onKill(player, target)
    if target:isPlayer() or target:getMaster() then
		return true
	end
	if player:getLevel() > 717216 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You have reached 717217 level, please go to reborn npc and start a new life.')
		return true
	end
    return true
end

--maxLevelMessage:register()
--------------------------------------------------------------------------------
-- LOGIN --
--------------------------------------------------------------------------------
local loginEvent = CreatureEvent("maxLevelMessageLogin")

function loginEvent.onLogin(player)
    player:registerEvent("maxLevelMessage")
    return true
end

--loginEvent:register()
-- data/scripts/(optional)talkactions
-- admplayer.lua

local addBackpack = TalkAction("!backpack")

function addBackpack.onSay(player, words, param)

	local exhaust = 7236
	if player:getExhaustion(exhaust) > 0 then
		return player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You can buy backpack again in "..player:getExhaustion(exhaust).." secs")
	end
	
	player:setExhaustion(exhaust, 60)
	player:addItem(1988, 1)

	return false
end
	
	

addBackpack:separator(" ")
addBackpack:register()
function onSay(player, words, param)

	local exhaust = 7237
	if player:getExhaustion(exhaust) > 0 then
		return player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You can buy runes again in "..player:getExhaustion(exhaust).." secs")
	end
	
    player:addItem(1988, 1)
	player:setExhaustion(exhaust, 60)
end
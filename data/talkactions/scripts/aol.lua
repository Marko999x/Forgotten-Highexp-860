local price_aol = 1000

function onSay(player, words, param)

	local exhaust = 7237
	if player:getExhaustion(exhaust) > 0 then
		return player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You can buy aol again in "..player:getExhaustion(exhaust).." secs")
	end
    player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
    player:addItem(2173, 1)
	player:say('You have bought a amulet of loss', TALKTYPE_MONSTER_SAY)
	player:setExhaustion(exhaust, 10)
    return false
end
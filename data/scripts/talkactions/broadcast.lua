local broadcast = TalkAction("!broadcast")

local exhaustTableBroadcast = {}

function broadcast.onSay(player, words, param)
	local playerGuid = player:getGuid()
	local timeAmount = exhaustTableBroadcast[playerGuid]
	if timeAmount and timeAmount > os.time() then
		player:sendTextMessage(MESSAGE_INFO_DESCR, 'You must wait ' .. (timeAmount - os.time()) .. ' seconds befor using broadcast again.')
		return false
	end
	if player:removeItem(9020, 50) then
		exhaustTableBroadcast[playerGuid] = os.time() + 30 -- 60 seconds
		for _, targetPlayer in ipairs(Game.getPlayers()) do
			targetPlayer:sendTextMessage(MESSAGE_INFO_DESCR, ''..player:getName()..' ['..player:getReborn()..']: '..param..'')
		end
	else
		player:sendTextMessage(MESSAGE_INFO_DESCR, 'You need 50 donation coins to broadcast.')
	end
	return false
end

broadcast:separator(" ")
broadcast:register()
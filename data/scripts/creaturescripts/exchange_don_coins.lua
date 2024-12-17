local tileeffect = GlobalEvent("exChangeCoins")

function tileeffect.onThink(interval)
	
	for _, player in pairs(Game.getPlayers()) do
		if player then
			local donCoin = player:getItemCount(9020) > 1999
			if not donCoin then
				return true
			end
			player:removeItem(9020, 2000)
			player:addItem(5097, 1)
			player:sendTextMessage(MESSAGE_INFO_DESCR, '2000 donation coin have been converted into 1 mega donation coin.')
		end
	end
    return true
end

tileeffect:interval(7000)
tileeffect:register()
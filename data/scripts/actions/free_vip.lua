local action = Action()

function action.onUse(player, item, fromPos, target, toPos, isHotkey)
	if player:getAccountStorageValue(903029) == 1 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, 'You alredy took free vip with this account.')
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return true
	end
	player:addVipDays(3)
	player:sendTextMessage(MESSAGE_INFO_DESCR, 'Congratz, you took 3 days of free vip! You can use now !fly and you got 10% extra exp. Have fun!')
	fromPos:sendDistanceEffect(player:getPosition(), CONST_ANI_FIRE)
	player:setAccountStorageValue(903029, 1)
	player:getPosition():sendMagicEffect(28)
	return true
end


action:aid(65432)
action:register()

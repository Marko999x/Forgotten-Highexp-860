local action = Action()

local config = {
	-- Sorc
	[39840] = {cost = 25, amount = 100, runeId = 2312},
	-- Druid
	[39841] = {cost = 25, amount = 100, runeId = 2282},
	-- Pally
	[39842] = {cost = 25, amount = 100, runeId = 2298},
	-- Knight
	[39843] = {cost = 25, amount = 100, runeId = 2302},
}
function action.onUse(player, item, fromPos, target, toPos, isHotkey)
	local runes = config[item:getActionId()]
	if not runes then
		return true
	end
	if item:getId() == 9825 then
		item:transform(item:getId() + 1)
	elseif item:getId() == 9826 then
		item:transform(item:getId() - 1)
	end
	if player:removeItem(5097, runes.cost) then
		player:addItem(runes.runeId, runes.amount)
		player:sendTextMessage(MESSAGE_INFO_DESCR, 'You have bought 100 runes')
		player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
		fromPos:sendDistanceEffect(player:getPosition(), 31)
	else
		player:sendTextMessage(MESSAGE_INFO_DESCR, 'You need '..runes.cost..' MDC to buy this.')
		fromPos:sendMagicEffect(CONST_ME_POFF)
	end
	return true
end

for v, k in pairs(config) do
	action:aid(v)
end
action:register()

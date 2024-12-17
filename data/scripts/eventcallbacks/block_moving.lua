local ids = {9999, 6000}

local ec = EventCallback

ec.onMoveItem = function(self, item, count, fromPosition, toPosition, fromCylinder, toCylinder)

	if table.contains(ids, item:getActionId()) then
		--self:sendTextMessage(MESSAGE_STATUS_DEFAULT, 'Sorry but you can not move this object.')
		return false
	end

	return true
end

ec:register()

local ids = {9999, 6000}

local ec = EventCallback

ec.onTradeRequest = function(self, target, item)

	if table.contains(ids, item:getActionId()) then
		--self:sendTextMessage(MESSAGE_STATUS_DEFAULT, 'Sorry, not possible.')
		return false
	end

	return true
end

ec:register()


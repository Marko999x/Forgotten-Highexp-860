local adminGuid = 7
local lvl = 1
local townId = 3

local castles_Globalevent2 = GlobalEvent("castles_Globalevent2")

function castles_Globalevent2.onThink()
	local castles = Game.getHouses()
	for _,castle in pairs(castles) do
		if castle:getTown() and castle:getTown():getId() == townId then
			if castle:getOwnerGuid() == 0 then
				castle:setOwnerGuid(adminGuid)
			end
		end
	end
	return true
end

castles_Globalevent2:interval(4000)
castles_Globalevent2:register()

local castles_Onuse = Action()

function castles_Onuse.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	if player:getLevel() < lvl then
		return player:sendCancelMessage('You have to be at least Level ' .. lvl .. ' to purchase a house.')
	end

	if player:getZone() ~= ZONE_PROTECTION then
		return player:sendCancelMessage('You cannot use this while PZlocked.')
	end

	local playerGuid = player:getGuid()
	local selectedCastle = nil
	
	local castles = Game.getHouses()
	
	for _,castle in pairs(castles) do
		if castle:getTown() and castle:getTown():getId() == townId then
			local owner = castle:getOwnerGuid()
			
			if owner == playerGuid then
				return player:sendCancelMessage('Your character already owns a castle.')
			elseif owner == 0 or owner == adminGuid then
				if selectedCastle == nil then
					selectedCastle = castle
				end
			end
		end
	end

    if selectedCastle == nil then
        return player:sendCancelMessage('There are no castles available at this moment.')
    end

	selectedCastle:setOwnerGuid(playerGuid)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE,'Welcome to your new home, ' .. selectedCastle:getName().. '! You can now step into the teleport. To get here again, enter the teleport in Temple +1')
	player:teleportTo(selectedCastle:getExitPosition(),true)
	item:remove(1)

    return true
end

castles_Onuse:id(12637)
castles_Onuse:register()
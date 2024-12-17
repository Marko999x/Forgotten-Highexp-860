local config = {
	teleportAction = 42935,
	topArenaStorage = 429311,
	topArenaStorage2 = 429312,
	minRebirth = 50,
	waitingRoom = Position(668, 614, 7),
	eventStart = "00:13:30",
	topLeft = Position(563, 616, 7),
	bottomRight = Position(587, 626, 7),
	teleportPosition = Position(1003, 1003, 7),
	centralArenaPosition = Position(575, 621, 7),
	templePosition = Position(2000, 2000, 7),
}

local moveEvent = MoveEvent()

function moveEvent.onStepIn(player, item, pos, fromPosition)
	if player:getReborn() < config.minRebirth then
		player:sendTextMessage(MESSAGE_INFO_DESCR, 'Sorry, you must be atleast rebirth 50 to practice on Top Arena event.')
		player:teleportTo(fromPosition)
		return true
	end
	if Game.getStorageValue(config.topArenaStorage) == 0 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, 'Sorry but there are no places anymore.')
		player:teleportTo(fromPosition)
		return true
	end
	Game.setStorageValue(config.topArenaStorage, Game.getStorageValue(config.topArenaStorage) - 1)
	Game.setStorageValue(config.topArenaStorage2, Game.getStorageValue(config.topArenaStorage2) + 1)
	for _, players in ipairs(Game.getPlayers()) do
		players:sendTextMessage(MESSAGE_EVENT_ADVANCE, '[EVENT] '..player:getName()..' has joined TOP Arena event. There are still '..Game.getStorageValue(config.topArenaStorage)..' places left!')
	end
	player:teleportTo(config.waitingRoom)
	--player:teleportTo(Position(999,1000,7))
	player:sendTextMessage(MESSAGE_INFO_DESCR, 'You have joined top arena event.')
	player:setStorageValue(config.teleportAction, 1)
	return true
end

moveEvent:aid(config.teleportAction)
moveEvent:register()
---------------------------------------------------------------------------------------------------------------------------
local globalEvent = GlobalEvent("topArenaEvent")

function globalEvent.onTime(interval)
	Game.setStorageValue(config.topArenaStorage, 50)
	Game.setStorageValue(config.topArenaStorage2, 0)
	local teleport = Game.createItem(1387, 1, config.teleportPosition)
	teleport:setActionId(config.teleportAction)
	for _, players in ipairs(Game.getPlayers()) do
		players:sendTextMessage(MESSAGE_EVENT_ADVANCE, '[EVENT] TOP Arena Event teleported appeared in the events room. The event will start in 3 minutes.')
	end
	addEvent(function()
		for _, players in ipairs(Game.getPlayers()) do
			players:sendTextMessage(MESSAGE_EVENT_ADVANCE, '[EVENT] TOP Arena Event teleported appeared in the events room. The event will start in 2 minutes.')
		end
	end, 60000)
	addEvent(function()
		for _, players in ipairs(Game.getPlayers()) do
			players:sendTextMessage(MESSAGE_EVENT_ADVANCE, '[EVENT] TOP Arena Event teleported appeared in the events room. The event will start in 1 minutes.')
		end
	end, 120000)
	addEvent(function()
		for _, players in ipairs(Game.getPlayers()) do
			if Game.getStorageValue(config.topArenaStorage2) < 2 then
				players:sendTextMessage(MESSAGE_EVENT_ADVANCE, '[EVENT] TOP Arena has failed to start because there was not enough players.')
				if players:getStorageValue(config.teleportAction) == 1 then
					players:teleportTo(config.templePosition)
					players:setStorageValue(config.teleportAction, 0)
				end
				local item = Tile(config.teleportPosition):getItemById(1387)
				if item then
					item:remove()
				end
				return true
			end
			for _, players in ipairs(Game.getPlayers()) do
				players:sendTextMessage(MESSAGE_EVENT_ADVANCE, '[EVENT] TOP Arena Event has started! Good luck to everyone!')
				if players:getStorageValue(config.teleportAction) == 1 then
					players:teleportTo(Position(
						math.random(config.topLeft.x, config.bottomRight.x),
						math.random(config.topLeft.y, config.bottomRight.y),
						config.topLeft.z
					))
					players:getPosition():sendMagicEffect(CONST_ME_ENERGYAREA)
					local item = Tile(config.teleportPosition):getItemById(1387)
					if item then
						item:remove()
					end
				end
			end
		end
	end, 180000)
	return true
end

globalEvent:time(config.eventStart)
--globalEvent:register()
---------------------------------------------------------------------------------------------------------------------------
local creatureEvent = CreatureEvent("topArenaEventDeath")

function creatureEvent.onPrepareDeath(creature, killer)
	if creature:getStorageValue(config.teleportAction) < 1 or killer:getStorageValue(config.teleportAction) < 1 then
		return true
	end
	creature:addHealth(creature:getMaxHealth())
	creature:addMana(creature:getMaxMana())
	creature:teleportTo(config.templePosition)
	creature:setStorageValue(config.teleportAction, 0)
	Game.setStorageValue(config.topArenaStorage2, Game.getStorageValue(config.topArenaStorage2) - 1)
	for _, players in ipairs(Game.getPlayers()) do
		players:sendTextMessage(MESSAGE_EVENT_ADVANCE, '[EVENT] '..creature:getName()..' has been killed from the Top Arena Event. There are still '..Game.getStorageValue(config.topArenaStorage2)..' players left in the Top Arena Event.')
	end
	if Game.getStorageValue(config.topArenaStorage2) > 1 then
		return true
	end
	local spectators = Game.getSpectators(config.centralArenaPosition, false, false, 20, 20, 20, 20)
	for i = 1, #spectators do
    	local spectator = spectators[i]
    	if spectator then
			spectator:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, 'Congratz for the Top Arena Event win!')
			spectator:teleportTo(config.templePosition)
			spectator:setStorageValue(config.teleportAction, 0)
			spectator:setStorageValue(24389, os.time() + 604800)
			for _, players in ipairs(Game.getPlayers()) do
				players:sendTextMessage(MESSAGE_EVENT_ADVANCE, '[EVENT] '..spectator:getName()..' has won the Top Arena Event, congratz! He has received as reward: 50% exp boost and a top arena effect!')
			end
		end
	end
	return true
end

creatureEvent:register()
-------------------------------------------------------------------------------------------------------------
local creatureEvent = CreatureEvent("topArenaEventDeathLogin")

function creatureEvent.onLogin(player)
	player:registerEvent("topArenaEventDeath")
	return true
end

creatureEvent:register()
---------------------------------------------------------------------------------------------------------------------------
local talkAction = TalkAction("!arena")

function talkAction.onSay(player, words, param, type)
	if player:getAccountType() < ACCOUNT_TYPE_GOD then
        return false
    end
	Game.setStorageValue(config.topArenaStorage, 50)
	Game.setStorageValue(config.topArenaStorage2, 0)
	local teleport = Game.createItem(1387, 1, config.teleportPosition)
	teleport:setActionId(config.teleportAction)
	for _, players in ipairs(Game.getPlayers()) do
		players:sendTextMessage(MESSAGE_EVENT_ADVANCE, '[EVENT] TOP Arena Event teleported appeared in the events room. The event will start in 3 minutes.')
	end
	addEvent(function()
		for _, players in ipairs(Game.getPlayers()) do
			players:sendTextMessage(MESSAGE_EVENT_ADVANCE, '[EVENT] TOP Arena Event teleported appeared in the events room. The event will start in 2 minutes.')
		end
	end, 60000)
	addEvent(function()
		for _, players in ipairs(Game.getPlayers()) do
			players:sendTextMessage(MESSAGE_EVENT_ADVANCE, '[EVENT] TOP Arena Event teleported appeared in the events room. The event will start in 1 minutes.')
		end
	end, 120000)
	addEvent(function()
		for _, players in ipairs(Game.getPlayers()) do
			if Game.getStorageValue(config.topArenaStorage2) < 2 then
				players:sendTextMessage(MESSAGE_EVENT_ADVANCE, '[EVENT] TOP Arena has failed to start because there was not enough players.')
				if players:getStorageValue(config.teleportAction) == 1 then
					players:teleportTo(config.templePosition)
					players:setStorageValue(config.teleportAction, 0)
				end
				local item = Tile(config.teleportPosition):getItemById(1387)
				if item then
					item:remove()
				end
				return true
			end
			for _, players in ipairs(Game.getPlayers()) do
				players:sendTextMessage(MESSAGE_EVENT_ADVANCE, '[EVENT] TOP Arena Event has started! Good luck to everyone!')
				if players:getStorageValue(config.teleportAction) == 1 then
					players:teleportTo(Position(
						math.random(config.topLeft.x, config.bottomRight.x),
						math.random(config.topLeft.y, config.bottomRight.y),
						config.topLeft.z
					))
					players:getPosition():sendMagicEffect(CONST_ME_ENERGYAREA)
					local item = Tile(config.teleportPosition):getItemById(1387)
					if item then
						item:remove()
					end
				end
			end
		end
	end, 180000)
	return true
end

talkAction:register()
---------------------------------------------------------------------------------------------------------------------------
local expItem = Action()

local items = {{28388, 1}, {31151, 1}, {9971, 25}, {11259, 5}, {35359, 20}, {9020, 10}, {31552, 1}}

local function secondsToReadable(s)
    local hours   = math.floor(s / 3600)
    local minutes = math.floor(math.fmod(s, 3600)/60)
    local seconds = math.floor(math.fmod(s, 60))
    return (hours   > 0 and (hours   .. ' hour'   .. (hours   > 1 and 's ' or ' ')) or '') ..
           (minutes > 0 and (minutes .. ' minute' .. (minutes > 1 and 's ' or ' ')) or '') ..
           (seconds > 0 and (seconds .. ' second' .. (seconds > 1 and 's ' or ' ')) or '')
end

function expItem.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	local randomIndex = math.random(1, #items)
	local itemId = items[randomIndex][1]
	local itemCount = items[randomIndex][2]
	local exhaust = 53964

	if player:getStorageValue(exhaust) - os.time() > 0 then
		local timeRemaining = secondsToReadable(player:getStorageValue(exhaust) - os.time())
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You can take your daily reward again in: ".. timeRemaining .."")
		return true
	end

	local item = player:addItem(itemId, itemCount)
	player:setStorageValue(exhaust, os.time() + 1)
	--player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have received "..itemCount.."x "..itemId:getName().."")
	print(item:getName())
    return true
end

expItem:aid(64053)
expItem:register()
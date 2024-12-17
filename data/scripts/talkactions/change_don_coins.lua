local talkAction = TalkAction("!exchange")

local playerExhaustTableTalk = {}

function talkAction.onSay(player, words, param, type)
	local playerGuid = player:getGuid()
	local timeAmount = playerExhaustTableTalk[playerGuid]
	if timeAmount and timeAmount > os.time() then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You must wait " .. (timeAmount - os.time()) .. " seconds.")
		return false
	end
	if player:getItemCount(9020) < 2000 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, 'You need 2000 donation coins in order to change for 1 MDC.')
		return false
	end
	player:removeItem(9020, 2000)
	player:addItem(5097, 1)
	player:sendTextMessage(MESSAGE_INFO_DESCR, '2000 donation coin has been converted into 1 mega donation coin.')
	playerExhaustTableTalk[playerGuid] = os.time() + 5
	return false
end

--talkAction:accountType(ACCOUNT_TYPE_GOD)
--talkAction:access(true)
--talkAction:separator(" ")
talkAction:register()

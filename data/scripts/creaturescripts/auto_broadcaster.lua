local info_message = GlobalEvent("info_message")

local message = {'If you want donate then please message one of the admins. You can only donate with amazon cards or paysafe cards. Paypal is blocked because of chargebacks!.'}

function info_message.onThink(interval)
    for _, player in ipairs(Game.getPlayers()) do
        if player:isInGhostMode() then
            return true
        end
		if player then
			player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, '[INFORMATION] '..message[math.random(#message)])
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, '[INFORMATION] '..message[math.random(#message)])
		end
	end
    return true
end

info_message:interval(900 * 1000)
info_message:register()
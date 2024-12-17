local talk = TalkAction("/commands", "!commands")

function talk.onSay(player, words, param)
	player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE,
                .. "!buypremium" .. "\n"
                .. "!buyhouse" .. "\n"
                .. "!sellhouse" .. "\n"
                .. "!leavehouse" .. "\n"
                .. "!spells" .. "\n"
                .. "!uptime" .. "\n"
                .. "!kills" .. "\n"
                .. "!online" .. "\n"
                .. "!serverinfo" .. "\n"
                .. "!commands" .. "\n"
                .. "!aol" .. "\n"
                .. "!blessing" .. "\n"
                .. "!blessings" .. "\n"
                .. "!skillpoints" .. "\n"
                .. "!points" .. "\n"
                .. "!point" .. "\n"
                .. "!home" .. "\n"
                .. "!autoloot")
    return false
end

talk:separator(" ")
talk:register()

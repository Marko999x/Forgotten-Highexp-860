
local test = TalkAction("/additem")

function test.onSay(player, words, param)
    local params = param:split(",")
    if #params < 3 then
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Ungültige Syntax. Verwende: /addItem playername,item id,item amount")
        return false
    end

    local targetName = params[1]
    local itemID = tonumber(params[2])
    local itemCount = tonumber(params[3])

    if not itemID or not itemCount then
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Ungültige Item-ID oder Menge.")
        return false
    end

    local target = Player(targetName)
    if not target then
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Spieler nicht gefunden.")
        return false
    end

    if target:addItem(itemID, itemCount) then
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Item wurde dem Spieler hinzugefügt.")
        target:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Ein Admin hat dir ein Item hinzugefügt.")
    else
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Item konnte nicht hinzugefügt werden.")
    end

    return false
end 


test:separator(" ")
test:register()
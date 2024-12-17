local function doCheckHouses()

    local registros = db.storeQuery(
                          "SELECT `houses`.`owner`, `houses`.`id` FROM `houses`,`players` WHERE `houses`.`owner` != 0 AND `houses`.`owner` = `players`.`id`;")

    if registros ~= false then
        local count = 0

        repeat
            count = count + 1

            local owner = result.getNumber(registros, "owner")
            local houseId = result.getNumber(registros, "id")
            local house = House(houseId)

            if house and (owner > 0) then
                print(house:getName())
                house:setOwnerGuid(0)
            end
        until not result.next(registros)
        result.free(registros)
    end
    print('Houses Cleaned')
    return true
end

local cleanhouse = TalkAction("/cleanhouse")

function cleanhouse.onSay(player, words, param)
    if not player:getGroup():getAccess() or player:getAccountType() <
        ACCOUNT_TYPE_GOD then
        player:sendCancelMessage("Only admins can use this command.")
        return true
    end
    addEvent(doCheckHouses, 10 * 1000)
    player:sendCancelMessage("Cleaning houses.")
    return true
end

cleanhouse:separator(" ")
cleanhouse:register()
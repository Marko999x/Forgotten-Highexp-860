local config = {
	["temple"] = { pos = Position(1000,1000,7), text = "temple", effect = 1 },
	["depo"] = { pos = Position(1000,1000,7), text = "depo", effect = 1 },
	["monks"] = { pos = Position(1000,1000,7), text = "depo", effect = 1 }
}

local fly = TalkAction("!fly")

function fly.onSay(player)

    if not player:isPremium() and config.premium then
        player:sendCancelMessage("Sorry, you need to have a premium account.")
        return false
    end

    if player:getLevel() < 100 then
        player:sendCancelMessage("You need to reach level 100 to use this command.")
        return false
    end
    
	if param == config[param] then
    player:teleportTo(pos)
    player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
	end
    return false
end

fly:register()
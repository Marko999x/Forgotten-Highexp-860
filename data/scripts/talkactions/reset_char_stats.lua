local resetChar = TalkAction("/resChar")

function resetChar.onSay(player, words, param)
	if player:getAccountType() == 6 then
    local playerId = player:getGuid()
	player:remove() 
	db.query("UPDATE `players` SET `level` = '8', `reborn` = '0', `health` = '185', `healthmax` = '185', `experience` = '4200', `maglevel` = '1', `mana` = '90', `manamax` = '90', `manaspent` = '0', `cap` = '470', `skill_fist` = '10', `skill_fist_tries` = '0', `skill_club` = '10', `skill_club_tries` = '0', `skill_sword` = '10', `skill_sword_tries` = '0', `skill_axe` = '10', `skill_axe_tries` = '0', `skill_dist` = '10', `skill_dist_tries` = '0', `skill_shielding` = '10', `skill_shielding_tries` = '0', `skill_fishing` = '10', `skill_fishing_tries` = '0' WHERE `id` = " .. playerId)
	end
    return false
end

resetChar:register()

local resCharPeople = TalkAction("/resetguy")

function resCharPeople.onSay(player, words, param)
    if player:getAccountType() < ACCOUNT_TYPE_GOD then
        return false
    end
    local split = param:splitTrimmed(",")
    local target = Player(split[1])
    if not target then
        player:sendCancelMessage("A player with that name is not online.")
        return false
    end
    local amount = tonumber(split[2])
    if not amount or amount < 1 then
        player:sendCancelMessage("Insufficient parameters.")
        return false
    end
	local playerId = target:getGuid()
	target:remove() 
	db.query("UPDATE `players` SET `level` = '8', `reborn` = '0', `health` = '185', `healthmax` = '185', `experience` = '4200', `maglevel` = '1', `mana` = '90', `manamax` = '90', `manaspent` = '0', `cap` = '470', `skill_fist` = '10', `skill_fist_tries` = '0', `skill_club` = '10', `skill_club_tries` = '0', `skill_sword` = '10', `skill_sword_tries` = '0', `skill_axe` = '10', `skill_axe_tries` = '0', `skill_dist` = '10', `skill_dist_tries` = '0', `skill_shielding` = '10', `skill_shielding_tries` = '0', `skill_fishing` = '10', `skill_fishing_tries` = '0' WHERE `id` = " .. playerId)
    return false
end

resCharPeople:separator(" ")
resCharPeople:register()
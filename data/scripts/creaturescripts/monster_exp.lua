local creatureEvent = CreatureEvent("expOnKill")

local config = {
    -- Rebirth 0 Monsters
    ["Troll Champion"] = {exp = 1521, rebirth = 20},
    ["Sexy Lady"] = {exp = 1511, rebirth = 20},
    -- Rebirth 20 Monsters
    ["Plagued Mino"] = {exp = 3121, rebirth = 50},
    ["Dark Sorcerer"] = {exp = 3121, rebirth = 50},
    -- Rebirth 50 Monsters
    ["Plagued Hydra"] = {exp = 6121, rebirth = 100},
    ["Plagued Old Widow"] = {exp = 6121, rebirth = 100},
    ["Plagued Tiger"] = {exp = 6121, rebirth = 100},
    -- Rebirth 100 Monsters
    ["Mr Die"] = {exp = 12121, rebirth = 150},
    ["Stupid Skeleton"] = {exp = 12121, rebirth = 150},
    ["Stupid Skeleton"] = {exp = 12121, rebirth = 150},
    ["Plagued Fire Overlord"] = {exp = 12121, rebirth = 150},
    ["Plagued Hero"] = {exp = 12121, rebirth = 150},
    -- Rebirth 150 Monsters
    ["Terror Bird"] = {exp = 24121, rebirth = 200},
    ["Defiler"] = {exp = 24121, rebirth = 200},
}

function creatureEvent.onKill(player, target)
    local monster = config[target:getName()]
    if not monster then
        return true
    end
    if player:getReborn() < monster.rebirth then
        player:addExperience(monster.exp, true)
    else
        player:addExperience(monster.exp / 2, true)
    end
    return true
end

creatureEvent:register()

local creatureEvent = CreatureEvent("expOnKillLogin")

function creatureEvent.onLogin(player)
    player:registerEvent("expOnKill")
    return true
end

creatureEvent:register()


local creatureEvent = CreatureEvent("expOnKill")

local config = {
    -- Rebirth 0 Monsters
    ["Troll Champion"] = {exp = 4000, rebirth = 20, chance = 100},
    ["Sexy Lady"] = {exp = 4000, rebirth = 20, chance = 10},
    -- Rebirth 20 Monsters
    ["Plagued Mino"] = {exp = 8000, rebirth = 50, chance = 10},
    ["Dark Sorcerer"] = {exp = 8000, rebirth = 50, chance = 10},
    -- Rebirth 50 Monsters
    ["Plagued Hydra"] = {exp = 16000, rebirth = 100, chance = 10},
    ["Plagued Old Widow"] = {exp = 16000, rebirth = 100, chance = 10},
    ["Plagued Tiger"] = {exp = 16000, rebirth = 100, chance = 10},
    -- Rebirth 100 Monsters
    ["Mr Die"] = {exp = 32000, rebirth = 150, chance = 10},
    ["Stupid Skeleton"] = {exp = 32000, rebirth = 150, chance = 10},
    ["Bad Boy"] = {exp = 32000, rebirth = 150, chance = 10},
    ["Plagued Fire Overlord"] = {exp = 32000, rebirth = 150, chance = 10},
    ["Plagued Hero"] = {exp = 32000, rebirth = 150, chance = 10},
    -- Rebirth 150 Monsters
    ["Terror Bird"] = {exp = 48000, rebirth = 200, chance = 10},
    ["Defiler"] = {exp = 48000, rebirth = 200, chance = 10},
}

function creatureEvent.onKill(player, target)
    local monster = config[target:getName()]
    if not monster then
        return true
    end
    --if math.random(1, 100) <= monster.chance then
        --local monster = Game.createMonster(target:getName(), target:getPosition())
        --monster:setMaxHealth(monster:getMaxHealth() * 2)
        --monster:setHealth(monster:getMaxHealth())
        --monster:setMonsterExp(monster:getMonsterExp() * 2)
        --monster:setSkull(SKULL_GREEN)
        --monster:rename('[SUPER] '..monster:getName()..'', '[SUPER] '..monster:getName()..'')
    --end
    --if player:getReborn() < monster.rebirth then
        player:addExperience(monster.exp)
    --else
     --   player:addExperience(monster.exp / 2)
    --end
    return true
end

creatureEvent:register()

local creatureEvent = CreatureEvent("expOnKillLogin")

function creatureEvent.onLogin(player)
    player:registerEvent("expOnKill")
    return true
end

creatureEvent:register()


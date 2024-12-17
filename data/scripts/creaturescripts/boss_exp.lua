local creatureEvent = CreatureEvent("expOnKillBoss")

local config = {
    -- Rebirth 5
    ["Earth Elemental"] = {exp = 40000},
    -- Rebirth 15
    ["Kongra"] = {exp = 45000},
    -- Rebirth 30
    ["Conan"] = {exp = 50000},
    -- Rebirth 50
    ["Chakoya Windcaller"] = {exp = 55000},
    -- Rebirth 100
    ["Marid"] = {exp = 60000},
    -- Rebirth 200
    ["Avalanche"] = {exp = 65000},
    -- Rebirth 300
    ["Gozzler"] = {exp = 70000},
    -- Rebirth 500
    ["Braindeath"] = {exp = 75000},
    -- Rebirth 700
    ["Hellgorak"] = {exp = 80000},
    -- Rebirth 850
    ["Leviathan"] = {exp = 850000},
}

function creatureEvent.onKill(player, target)
    local monster = config[target:getName()]
    if not monster then
        return true
    end
    player:addExperience(monster.exp)
    return true
end

creatureEvent:register()

local creatureEvent = CreatureEvent("expOnKillLoginBoss")

function creatureEvent.onLogin(player)
    player:registerEvent("expOnKillBoss")
    return true
end

creatureEvent:register()


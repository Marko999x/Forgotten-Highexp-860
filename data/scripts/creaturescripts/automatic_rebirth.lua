local automaticRebirth = CreatureEvent("automaticRebirth")

local rates = {
	{range = {0, 99}, level = 717217},
    {range = {100, 199}, level = 834434},
    {range = {200, 299}, level = 951651},
    {range = {300, 399}, level = 1068868},
    {range = {400, 499}, level = 1186085},
    {range = {500, 599}, level = 1303302},
    {range = {600, 699}, level = 1420519},
    {range = {700, 799}, level = 1537736},
    {range = {800, 899}, level = 1654953},
    {range = {900, 999}, level = 1772170},
    {range = {1000, 1099}, level = 1889387},
    {range = {1100, 1199}, level = 2006604},
    {range = {1200, 1299}, level = 2123821},
}

function automaticRebirth.onAdvance(player, skill, oldLevel, newLevel)
    if player:getStorageValue(999999) == -1 then
        return true
    end
    if player:getStorageValue(999999) > -1 then
        local rebornLvl = player:getReborn()
        for _, thing in pairs(rates) do
            if rebornLvl >= thing.range[1] and rebornLvl <= thing.range[2] then
                if newLevel == thing.level then
                    player:doReborn()
                end
                break
            end
        end
    end
    return true
end

automaticRebirth:register()

local automaticRebirthLogin = CreatureEvent("automaticRebirthLogin")

function automaticRebirthLogin.onLogin(player)
    player:registerEvent("automaticRebirth")
    return true
end

automaticRebirthLogin:register()


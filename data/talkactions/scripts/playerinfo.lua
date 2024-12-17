local talk = TalkAction("!playerinfo")

local exhaustTable, exhaustTimer = {}, 60 -- in milliseconds

function talk.onSay(player, words, param)
    local cur_player, cur_time = player:getId(), os.mtime()
    if exhaustTable[cur_player] and exhaustTable[cur_player] > cur_time then
        player:sendCancelMessage("This talkaction is on cooldown. Can use again in " .. ((exhaustTable[cur_player] - cur_time) / 1000) .. " seconds.")
        return false
    end
    
    local target = Player(param)
    if not target then
        player:sendCancelMessage("Player '" .. param:lower() .. "' either does not exist or is offline.")
        exhaustTable[cur_player] = cur_time + 5000
        return false
    end
    exhaustTable[cur_player] = cur_time + exhaustTimer
    
    local text = "\nName: " .. target:getName()
    text = text .. "\nTime Online: " .. os.date('!%T', os.time() - target:getLastLoginSaved())
    
    local killCount = target:getSkullTime()
    text = text .. "\nFrags: " .. (killCount > 0 and math.ceil(killCount / configManager.getNumber(configKeys.FRAG_TIME)) or 0)
    
    local skull = target:getSkull()
    text = text .. "\nSkull: " .. (skull == 3 and "white" or skull == 4 and "red" or skull == 5 and "black" or "none")
    
    local pzLockTime = (target:isPzLocked() and target:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT):getTicks() / 1000 or 0)
    text = text .. "\nPZ Lock: " .. (pzLockTime > 0 and os.date('!%T', pzLockTime) or "none")
    
    text = text .. "\nLevel: " .. target:getLevel()
    text = text .. "\nSex: " .. (target:getSex() == 0 and "female" or "male")
    text = text .. "\nVocation: " .. target:getVocation():getName()
    text = text .. "\nHealth: " .. target:getHealth() .. "/" .. target:getMaxHealth()
    text = text .. "\nMana: " .. target:getMana() .. "/" .. target:getMaxMana()
    text = text .. "\nSoul: " .. target:getSoul() .. "/" .. target:getMaxSoul()
    text = text .. "\nCapacity: " .. (target:getFreeCapacity() / 100) .. "/" .. (target:getCapacity() / 100)
    
    local feedTime = target:getCondition(CONDITION_REGENERATION, CONDITIONID_DEFAULT)
    text = text .. "\nFeed Time: " .. os.date('!%T', (feedTime and feedTime:getTicks() / 1000 or 0))
    
    text = text .. "\nMagic: " .. target:getMagicLevel()
    text = text .. "\nFist: " .. target:getSkillLevel(SKILL_FIST) .. ", with " .. (100 - target:getSkillPercent(SKILL_FIST)) .. "% to next level"
    text = text .. "\nClub: " .. target:getSkillLevel(SKILL_CLUB) .. ", with " .. (100 - target:getSkillPercent(SKILL_CLUB)) .. "% to next level"
    text = text .. "\nSword: " .. target:getSkillLevel(SKILL_SWORD) .. ", with " .. (100 - target:getSkillPercent(SKILL_SWORD)) .. "% to next level"
    text = text .. "\nAxe: " .. target:getSkillLevel(SKILL_AXE) .. ", with " .. (100 - target:getSkillPercent(SKILL_AXE)) .. "% to next level"
    text = text .. "\nDistance: " .. target:getSkillLevel(SKILL_DISTANCE) .. ", with " .. (100 - target:getSkillPercent(SKILL_DISTANCE)) .. "% to next level"
    text = text .. "\nShielding: " .. target:getSkillLevel(SKILL_SHIELD) .. ", with " .. (100 - target:getSkillPercent(SKILL_SHIELD)) .. "% to next level"
    text = text .. "\nFishing: " .. target:getSkillLevel(SKILL_FISHING) .. ", with " .. (100 - target:getSkillPercent(SKILL_FISHING)) .. "% to next level"
    
    player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, text)
    return false
end

talk:separator(" ")
talk:register()
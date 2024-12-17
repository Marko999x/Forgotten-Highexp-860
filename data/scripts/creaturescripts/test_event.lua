local creatureevent = CreatureEvent("HeartCorpse")

function creatureevent.onDeath(creature, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
    if not killer:isPlayer() then
        return true
    end
    local heart = corpse:addItem(2353, 1)
    heart:setAttribute(ITEM_ATTRIBUTE_NAME, ''..creature:getName().."'s Heart")
    heart:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, ''..killer:getName()..' ['..killer:getLevel()..'] has killed '..creature:getName()..' ['..creature:getLevel()..']')
    return true
end

creatureevent:register()
---------------------------------------------------------------------------------------
-- Register script onLogin
---------------------------------------------------------------------------------------
local creatureevent = CreatureEvent("HeartCorpseLogin")

function creatureevent.onLogin(player)
    player:registerEvent("HeartCorpse")
    return true
end

creatureevent:type("login")
creatureevent:register()
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
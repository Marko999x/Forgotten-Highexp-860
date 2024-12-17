local creatureEvent = CreatureEvent("summonExtraDamageReceive")

function creatureEvent.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    if creature:isPlayer() or attacker:isPlayer() or attacker:getMaster() then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end
    if creature and creature:getMaster() then
        primaryDamage = primaryDamage + (creature:getMaxHealth() * 14 / 100)
        secondaryDamage = secondaryDamage + (creature:getMaxHealth() * 14 / 100)
    end
    return primaryDamage, primaryType, secondaryDamage, secondaryType
end

creatureEvent:register()

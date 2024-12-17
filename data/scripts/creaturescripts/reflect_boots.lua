local creatureEventCustom = CreatureEvent("richBootsReflect")

local distanceEffect = CONST_ANI_ENERGYBALL

function creatureEventCustom.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    if not creature or not attacker or not attacker:isPlayer() then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end
    local boots = creature:getSlotItem(CONST_SLOT_FEET)
    if boots and boots.itemid == 2644 then
        if attacker:isPlayer() then
            return doTargetCombatHealth(attacker, creature, COMBAT_PHYSICALDAMAGE, primaryDamage, secondaryDamage, CONST_ME_MAGIC_BLUE, ORIGIN_SPELL)
        end
    end
    return primaryDamage, primaryType, secondaryDamage, secondaryType
end

--creatureEventCustom:register()
-------------------------------------------------------------------------------------------------------------------------------------
local creatureEventCustom = CreatureEvent("richBootsReflect1")

local distanceEffect = CONST_ANI_ENERGYBALL

function creatureEventCustom.onManaChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    if not creature or not attacker or not attacker:isPlayer() then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end
    local boots = creature:getSlotItem(CONST_SLOT_FEET)
    if boots and boots.itemid == 2644 then
        if attacker:isPlayer() then
            return doTargetCombatMana(creature, attacker, COMBAT_PHYSICALDAMAGE, primaryDamage, secondaryDamage, CONST_ME_MAGIC_BLUE, ORIGIN_SPELL)
        end
    end
    return primaryDamage, primaryType, secondaryDamage, secondaryType
end

--creatureEventCustom:register()
-------------------------------------------------------------------------------------------------------------------------------------
local creatureEvent = CreatureEvent("richBootsReflectLogin")

function creatureEvent.onLogin(player)
	player:registerEvent("richBootsReflect")
	return true
end

creatureEvent:register()
-------------------------------------------------------------------------------------------------------------------------------------
local creatureEvent = CreatureEvent("richBootsReflectLogin1")

function creatureEvent.onLogin(player)
	player:registerEvent("richBootsReflect1")
	return true
end

creatureEvent:register()

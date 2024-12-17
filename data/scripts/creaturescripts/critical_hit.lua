local creatureEventCustom = CreatureEvent("critHitHealth")

local distanceEffect = CONST_ANI_ENERGYBALL

local function effecto(cid)
    local player = Player(cid)
    if not player then
        return true
    end
    local pos = player:getPosition()
    Position(pos.x+0, pos.y+0, pos.z):sendDistanceEffect(pos, distanceEffect)
    Position(pos.x+0, pos.y-0, pos.z):sendDistanceEffect(pos, distanceEffect)
    Position(pos.x-0, pos.y-0, pos.z):sendDistanceEffect(pos, distanceEffect)
    Position(pos.x-0, pos.y+0, pos.z):sendDistanceEffect(pos, distanceEffect)
    Position(pos.x-1, pos.y+0, pos.z):sendDistanceEffect(pos, distanceEffect)
    Position(pos.x+1, pos.y+0, pos.z):sendDistanceEffect(pos, distanceEffect)
    Position(pos.x-0, pos.y+1, pos.z):sendDistanceEffect(pos, distanceEffect)
    Position(pos.x+0, pos.y-1, pos.z):sendDistanceEffect(pos, distanceEffect)
    Position(pos.x+1, pos.y+1, pos.z):sendDistanceEffect(pos, distanceEffect)
    Position(pos.x+1, pos.y-1, pos.z):sendDistanceEffect(pos, distanceEffect)
    Position(pos.x-1, pos.y-1, pos.z):sendDistanceEffect(pos, distanceEffect)
    Position(pos.x-1, pos.y+1, pos.z):sendDistanceEffect(pos, distanceEffect)
    Position(pos.x-2, pos.y+0, pos.z):sendDistanceEffect(pos, distanceEffect)
    Position(pos.x+2, pos.y+0, pos.z):sendDistanceEffect(pos, distanceEffect)
    Position(pos.x-0, pos.y+2, pos.z):sendDistanceEffect(pos, distanceEffect)
    Position(pos.x+0, pos.y-2, pos.z):sendDistanceEffect(pos, distanceEffect)
    Position(pos.x+2, pos.y+2, pos.z):sendDistanceEffect(pos, distanceEffect)
    Position(pos.x+2, pos.y-2, pos.z):sendDistanceEffect(pos, distanceEffect)
    Position(pos.x-2, pos.y-2, pos.z):sendDistanceEffect(pos, distanceEffect)
    Position(pos.x-2, pos.y+2, pos.z):sendDistanceEffect(pos, distanceEffect)
    Position(pos.x-3, pos.y+0, pos.z):sendDistanceEffect(pos, distanceEffect)
    Position(pos.x+3, pos.y+0, pos.z):sendDistanceEffect(pos, distanceEffect)
    Position(pos.x-0, pos.y+3, pos.z):sendDistanceEffect(pos, distanceEffect)
    Position(pos.x+0, pos.y-3, pos.z):sendDistanceEffect(pos, distanceEffect)
end

function creatureEventCustom.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    if not creature or not attacker or not attacker:isPlayer() then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end
    if math.random(1, 100) <= 1 then
        primaryDamage = primaryDamage + (primaryDamage * 25 / 100)
        secondaryDamage = secondaryDamage + (secondaryDamage * 25 / 100)
        Game.sendAnimatedText('CRITICAL', attacker:getPosition(), TEXTCOLOR_LIGHTGREEN)
        for i = 1, 3 do
            addEvent(effecto, i * 100, attacker.uid)
        end
    end
    return primaryDamage, primaryType, secondaryDamage, secondaryType
end

creatureEventCustom:register()
-------------------------------------------------------------------------------------------------------------------------------------
local creatureEventCustom = CreatureEvent("critHitMana")

local distanceEffect = CONST_ANI_ENERGYBALL

function creatureEventCustom.onManaChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    if not creature or not attacker or not attacker:isPlayer() then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end
    if math.random(1, 100) <= 1 then
        primaryDamage = primaryDamage + (primaryDamage * 25 / 100)
        secondaryDamage = secondaryDamage + (secondaryDamage * 25 / 100)
        Game.sendAnimatedText('CRITICAL', attacker:getPosition(), TEXTCOLOR_LIGHTGREEN)
        for i = 1, 3 do
            addEvent(effecto, i * 100, attacker.uid)
        end
    end
    return primaryDamage, primaryType, secondaryDamage, secondaryType
end

creatureEventCustom:register()
-------------------------------------------------------------------------------------------------------------------------------------
local creatureEvent = CreatureEvent("critHitLoginHealth")

function creatureEvent.onLogin(player)
	player:registerEvent("critHitHealth")
	return true
end

creatureEvent:register()
-------------------------------------------------------------------------------------------------------------------------------------
local creatureEvent = CreatureEvent("critHitLoginMana")

function creatureEvent.onLogin(player)
	player:registerEvent("critHitMana")
	return true
end

creatureEvent:register()

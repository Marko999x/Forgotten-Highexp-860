local config = {

	firstType = COMBAT_HOLYDAMAGE,
	secondType = COMBAT_HOLYDAMAGE,
	thirdType = COMBAT_FIREDAMAGE,

	firstEffect = 18,
	secondEffect = 7,
	thirdEffect = 7,
	
	firstDistanceEffect = 11,
	secondDistanceEffect = 11,
	thirdDistanceEffect = 11,
	
	firstMinDmg = 500000,
	firstMaxDmg = 750000,
	secondMinDmg = 500000,
	secondMaxDmg = 750000,
	thirdMinDmg = 500000,
	thirdMaxDmg = 750000,
	
	magicLevel = 25
}

local areaOne = {
{0, 0, 1, 1, 1, 1, 1, 0, 0},
{0, 1, 1, 0, 0, 0, 1, 1, 0},
{1, 1, 0, 0, 0, 0, 0, 1, 1},
{1, 0, 0, 0, 0, 0, 0, 0, 1},
{1, 0, 0, 0, 2, 0, 0, 0, 1},
{1, 0, 0, 0, 0, 0, 0, 0, 1},
{1, 1, 0, 0, 0, 0, 0, 1, 1},
{0, 1, 1, 0, 0, 0, 1, 1, 0},
{0, 0, 1, 1, 1, 1, 1, 0, 0}
}

local areaTwo = {
{0, 0, 1, 1, 1, 0, 0},
{0, 1, 1, 1, 1, 1, 0},
{1, 1, 1, 0, 1, 1, 1},
{1, 1, 0, 2, 0, 1, 1},
{1, 1, 1, 0, 1, 1, 1},
{0, 1, 1, 1, 1, 1, 0},
{0, 0, 1, 1, 1, 0, 0}
}

local areaThree = {
{0, 0, 0, 0, 0},
{0, 0, 1, 0, 0},
{0, 1, 2, 1, 0},
{0, 0, 1, 0, 0},
{0, 0, 0, 0, 0}
}

function onGetFormulaValues(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = config.firstMinDmg + (reborn * 250000)
	local max = config.firstMaxDmg + (reborn * 350000)
	return -min, -max
end
function onGetFormulaValues1(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = config.firstMinDmg + (reborn * 250000)
	local max = config.firstMaxDmg + (reborn * 350000)
	return -min, -max
end
function onGetFormulaValues2(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = config.firstMinDmg + (reborn * 250000)
	local max = config.firstMaxDmg + (reborn * 350000)
	return -min, -max
end

local magicareaOne  = createCombatArea(areaOne)
local magicareaTwo  = createCombatArea(areaTwo)
local magicareaThree = createCombatArea(areaThree)

local combatOne = Combat()
local combatTwo = Combat()
local combatThree = Combat()

combatOne:setArea(magicareaOne)
combatTwo:setArea(magicareaTwo)
combatThree:setArea(magicareaThree)

combatOne:setParameter(COMBAT_PARAM_TYPE, config.firstType)
combatTwo:setParameter(COMBAT_PARAM_TYPE, config.secondType)
combatThree:setParameter(COMBAT_PARAM_TYPE, config.thirdType)

combatOne:setParameter(COMBAT_PARAM_EFFECT, config.firstEffect)
combatTwo:setParameter(COMBAT_PARAM_EFFECT, config.secondEffect)
combatThree:setParameter(COMBAT_PARAM_EFFECT, config.thirdEffect)

function onTargetTile(creature, position)
    creature:getPosition():sendDistanceEffect(position, config.firstDistanceEffect)
end

function onTargetTile1(creature, position)
    creature:getPosition():sendDistanceEffect(position, config.secondDistanceEffect)
end

function onTargetTile2(creature, position)
    creature:getPosition():sendDistanceEffect(position, config.thirdDistanceEffect)
end

combatOne:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")
combatTwo:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues1")
combatThree:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues2")

combatOne:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")
combatTwo:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile1")
combatThree:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile2")

local function firstCombat(cid, target)
    local player = Player(cid)
    if not player then return end
    return combatOne:execute(player, target)
end

local function secondCombat(cid, target)
    local player = Player(cid)
    if not player then return end
    return combatTwo:execute(player, target)
end

local function thridCombat(cid, target)
    local player = Player(cid)
    if not player then return end
    return combatThree:execute(player, target)
end

local spell = Spell(SPELL_INSTANT)

function spell.onCastSpell(player, target)
	addEvent(firstCombat, 200, player:getId(), target)
	addEvent(secondCombat, 200, player:getId(), target)
	addEvent(thridCombat, 1, player:getId(), target)
	addEvent(firstCombat, 1200, player:getId(), target)
	addEvent(secondCombat, 1200, player:getId(), target)
	addEvent(thridCombat, 1000, player:getId(), target)
	addEvent(firstCombat, 2200, player:getId(), target)
	addEvent(secondCombat, 2200, player:getId(), target)
	addEvent(thridCombat, 2000, player:getId(), target)
    return true
end

spell:name("forgotten legend")
spell:words("forgotten legend")
spell:group("attack")
spell:vocation("sorcerer", "druid", "paladin", "knight", "master sorcerer", "elder druid", "royal paladin", "elite knight", "mixed master sorcerer", "mixed elder druid", "mixed royal paladin", "mixed elite knight", "spin master sorcerer", "spin elder druid", "spin royal paladin", "spin elite knight", "epic master sorcerer", "epic elder druid", "epic royal paladin", "epic elite knight", "nova master sorcerer", "nova elder druid", "nova royal paladin", "nova elite knight", "hellborn master sorcerer", "hellborn elder druid", "hellborn royal paladin", "hellborn elite knight" )
spell:id(24)
spell:cooldown(1000)
spell:groupCooldown(1000)
spell:isSelfTarget(false)
spell:level(1)
spell:mana(10)
spell:blockWalls(true)
spell:register()
------------------------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------------------------
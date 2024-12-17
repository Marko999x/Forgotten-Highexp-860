local config = {

	firstType = COMBAT_ENERGYDAMAGE,
	secondType = COMBAT_FIREDAMAGE,
	thirdType = COMBAT_FIREDAMAGE,

	firstEffect = 48,
	secondEffect = 7,
	thirdEffect = 7,
	
	firstDistanceEffect = 5,
	secondDistanceEffect = 11,
	thirdDistanceEffect = 11,
	
	firstMinDmg = 17000000,
	firstMaxDmg = 22000000,
	secondMinDmg = 1500000,
	secondMaxDmg = 2000000,
	thirdMinDmg = 150000,
	thirdMaxDmg = 200000,
	
	magicLevel = 25
}

local areaOne = {
{0, 0, 0, 1, 1, 1, 0, 0, 0},
{0, 1, 1, 1, 1, 1, 1, 1, 0},
{1, 1, 1, 1, 1, 1, 1, 1, 1},
{0, 1, 1, 1, 1, 1, 1, 1, 0},
{0, 1, 1, 1, 2, 1, 1, 1, 0},
{0, 1, 1, 1, 1, 1, 1, 1, 0},
{1, 1, 1, 1, 1, 1, 1, 1, 1},
{0, 1, 1, 1, 1, 1, 1, 1, 0},
{0, 0, 0, 1, 1, 1, 0, 0, 0}
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
	local min = config.firstMinDmg + (reborn * 2000000) 
	local max = config.firstMaxDmg + (reborn * 2300000) 
	return -min, -max
end
function onGetFormulaValues1(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = config.firstMinDmg + (reborn * config.firstMinDmg / 2) 
	local max = config.firstMaxDmg + (reborn * config.firstMaxDmg / 2)
	return -min, -max
end
function onGetFormulaValues2(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = config.firstMinDmg + (reborn * config.firstMinDmg / 2)
	local max = config.firstMaxDmg + (reborn * config.firstMaxDmg / 2)
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
	addEvent(firstCombat, 1, player:getId(), target)
    return true
end

spell:name("demoniac star")
spell:words("demoniac star")
spell:group("attack")
spell:isSelfTarget(false)
spell:vocation("sorcerer", "druid", "master sorcerer", "elder druid", "mixed master sorcerer", "mixed elder druid", "spin master sorcerer", "spin elder druid", "epic master sorcerer", "epic elder druid", "nova master sorcerer", "nova elder druid", "hellborn master sorcerer", "hellborn elder druid")
spell:id(88)
spell:cooldown(1000)
spell:groupCooldown(1000)
spell:reborn(25)
spell:mana(1000)
spell:blockWalls(true)
spell:register()
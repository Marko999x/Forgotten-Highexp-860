local config = {

	firstType = COMBAT_EARTHDAMAGE,
	secondType = COMBAT_FIREDAMAGE,
	thirdType = COMBAT_FIREDAMAGE,

	firstEffect = CONST_ME_PLANTATTACK,
	secondEffect = CONST_ME_FIREAREA,
	thirdEffect = 7,
	
	firstDistanceEffect = CONST_ANI_DEATH,
	secondDistanceEffect = CONST_ANI_DEATH,
	thirdDistanceEffect = 11,
	
	firstMinDmg = 50000000,
	firstMaxDmg = 52000000,
	secondMinDmg = 50000000,
	secondMaxDmg = 52000000,
	thirdMinDmg = 150000,
	thirdMaxDmg = 200000,
	
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
{1, 1, 1, 1, 1, 1, 1},
{1, 1, 1, 2, 1, 1, 1},
{1, 1, 1, 1, 1, 1, 1},
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
	local min = config.firstMinDmg + (reborn * 1300000)
	local max = config.firstMaxDmg + (reborn * 1400000)
	return -min, -max
end
function onGetFormulaValues1(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = config.firstMinDmg + (reborn * 1300000)
	local max = config.firstMaxDmg + (reborn * 1400000)
	return -min, -max
end
function onGetFormulaValues2(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = config.firstMinDmg + (reborn * 1300000)
	local max = config.firstMaxDmg + (reborn * 1400000)
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
--combatTwo:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile1")
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
	addEvent(secondCombat, 1, player:getId(), target)
	addEvent(firstCombat, 500, player:getId(), target)
	addEvent(secondCombat, 500, player:getId(), target)
	addEvent(firstCombat, 1000, player:getId(), target)
	addEvent(secondCombat, 1000, player:getId(), target)
    return true
end

spell:name("blind anger")
spell:words("blind anger")
spell:group("attack")
spell:isSelfTarget(true)
spell:vocation("spin master sorcerer", "epic master sorcerer", "nova master sorcerer", "hellborn master sorcerer")
spell:id(119)
spell:cooldown(1000)
spell:groupCooldown(1000)
spell:reborn(100)
spell:mana(1000)
spell:blockWalls(true)
spell:register()
------------------------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------------------------
local config = {

	firstType = COMBAT_EARTHDAMAGE,
	secondType = COMBAT_ICEDAMAGE,
	thirdType = COMBAT_FIREDAMAGE,

	firstEffect = CONST_ME_PLANTATTACK,
	secondEffect = CONST_ME_ICETORNADO,
	thirdEffect = 7,
	
	firstDistanceEffect = CONST_ANI_DEATH,
	secondDistanceEffect = CONST_ANI_DEATH,
	thirdDistanceEffect = 11,
	
	firstMinDmg = 50000000,
	firstMaxDmg = 52000000,
	secondMinDmg = 50000000,
	secondMaxDmg = 52000000,
	thirdMinDmg = 150000,
	thirdMaxDmg = 200000,
	
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
{1, 1, 1, 1, 1, 1, 1},
{1, 1, 1, 2, 1, 1, 1},
{1, 1, 1, 1, 1, 1, 1},
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
	local min = config.firstMinDmg + (reborn * 1300000)
	local max = config.firstMaxDmg + (reborn * 1400000)
	return -min, -max
end
function onGetFormulaValues1(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = config.firstMinDmg + (reborn * 1300000)
	local max = config.firstMaxDmg + (reborn * 1400000)
	return -min, -max
end
function onGetFormulaValues2(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = config.firstMinDmg + (reborn * 1300000)
	local max = config.firstMaxDmg + (reborn * 1400000)
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
--combatTwo:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile1")
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
	addEvent(secondCombat, 1, player:getId(), target)
	addEvent(firstCombat, 500, player:getId(), target)
	addEvent(secondCombat, 500, player:getId(), target)
	addEvent(firstCombat, 1000, player:getId(), target)
	addEvent(secondCombat, 1000, player:getId(), target)
    return true
end

spell:name("druid fury")
spell:words("druid fury")
spell:group("attack")
spell:isSelfTarget(true)
spell:vocation("spin elder druid", "epic elder druid", "nova elder druid", "hellborn elder druid")
spell:id(56)
spell:cooldown(1000)
spell:groupCooldown(1000)
spell:reborn(100)
spell:mana(1000)
spell:blockWalls(true)
spell:register()
------------------------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------------------------
local config = {

	firstType = COMBAT_HOLYDAMAGE,
	secondType = COMBAT_HOLYDAMAGE,
	thirdType = COMBAT_FIREDAMAGE,

	firstEffect = 38,
	secondEffect = 50,
	thirdEffect = 7,
	
	firstDistanceEffect = 28,
	secondDistanceEffect = 28,
	thirdDistanceEffect = 11,
	
	firstMinDmg = 52000000,
	firstMaxDmg = 54000000,
	secondMinDmg = 52000000,
	secondMaxDmg = 54000000,
	thirdMinDmg = 150000,
	thirdMaxDmg = 200000,
	
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
{1, 1, 1, 1, 1, 1, 1},
{1, 1, 1, 2, 1, 1, 1},
{1, 1, 1, 1, 1, 1, 1},
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
	local min = config.firstMinDmg + (reborn * 1500000)
	local max = config.firstMaxDmg + (reborn * 1600000)
	return -min, -max
end
function onGetFormulaValues1(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = config.firstMinDmg + (reborn * 1500000)
	local max = config.firstMaxDmg + (reborn * 1600000)
	return -min, -max
end
function onGetFormulaValues2(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = config.firstMinDmg + (reborn * 1500000)
	local max = config.firstMaxDmg + (reborn * 1600000)
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
--combatTwo:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile1")
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
	addEvent(secondCombat, 1, player:getId(), target)
	addEvent(firstCombat, 500, player:getId(), target)
	addEvent(secondCombat, 500, player:getId(), target)
	addEvent(firstCombat, 1000, player:getId(), target)
	addEvent(secondCombat, 1000, player:getId(), target)
    return true
end

spell:name("san condition")
spell:words("exevo san condition")
spell:group("attack")
spell:isSelfTarget(true)
spell:vocation("spin royal paladin", "epic royal paladin", "nova royal paladin", "hellborn royal paladin")
spell:id(23)
spell:cooldown(1000)
spell:groupCooldown(1000)
spell:reborn(100)
spell:mana(1000)
spell:blockWalls(true)
spell:register()
------------------------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------------------------
local config = {

	firstType = COMBAT_HOLYDAMAGE,
	secondType = COMBAT_HOLYDAMAGE,
	thirdType = COMBAT_FIREDAMAGE,

	firstEffect = 35,
	secondEffect = 1,
	thirdEffect = 7,
	
	firstDistanceEffect = 26,
	secondDistanceEffect = 26,
	thirdDistanceEffect = 11,
	
	firstMinDmg = 48000000,
	firstMaxDmg = 50000000,
	secondMinDmg = 48000000,
	secondMaxDmg = 50000000,
	thirdMinDmg = 150000,
	thirdMaxDmg = 200000,
	
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
{1, 1, 1, 1, 1, 1, 1},
{1, 1, 1, 2, 1, 1, 1},
{1, 1, 1, 1, 1, 1, 1},
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
	local min = config.firstMinDmg + (reborn * 1000000)
	local max = config.firstMaxDmg + (reborn * 1100000)
	return -min, -max
end
function onGetFormulaValues1(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = config.firstMinDmg + (reborn * 1000000)
	local max = config.firstMaxDmg + (reborn * 1100000)
	return -min, -max
end
function onGetFormulaValues2(player, level, magicLevel)
	local reborn = player:getReborn()
	local min = config.firstMinDmg + (reborn * 1000000)
	local max = config.firstMaxDmg + (reborn * 1100000)
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
--combatTwo:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile1")
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
	addEvent(secondCombat, 1, player:getId(), target)
	addEvent(firstCombat, 500, player:getId(), target)
	addEvent(secondCombat, 500, player:getId(), target)
	addEvent(firstCombat, 1000, player:getId(), target)
	addEvent(secondCombat, 1000, player:getId(), target)
    return true
end

spell:name("super gran")
spell:words("exori super gran")
spell:group("attack")
spell:isSelfTarget(true)
spell:vocation("spin elite knight", "epic elite knight", "nova elite knight", "hellborn elite knight")
spell:id(62)
spell:cooldown(1000)
spell:groupCooldown(1000)
spell:reborn(100)
spell:mana(1000)
spell:blockWalls(true)
spell:register()
----------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------

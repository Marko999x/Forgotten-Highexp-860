local config = {
	[1] = { minDmg = 4000000, maxDmg = 4500000, mLvlDmg = 375000, rebDmg = 600000 },
	[2] = { minDmg = 3500000, maxDmg = 4000000, mLvlDmg = 375000, rebDmg = 500000 },
	[3] = { minDmg = 5000000, maxDmg = 5500000, mLvlDmg = 700000, rebDmg = 700000 },
	[4] = { minDmg = 2500000, maxDmg = 3000000, mLvlDmg = 2000000, rebDmg = 400000 },
	[5] = { minDmg = 4000000, maxDmg = 4500000, mLvlDmg = 375000, rebDmg = 600000 },
	[6] = { minDmg = 3500000, maxDmg = 4000000, mLvlDmg = 375000, rebDmg = 500000 },
	[7] = { minDmg = 5000000, maxDmg = 5500000, mLvlDmg = 700000, rebDmg = 700000 },
	[8] = { minDmg = 2500000, maxDmg = 3000000, mLvlDmg = 2000000, rebDmg = 400000 },
	[9] = { minDmg = 4000000, maxDmg = 4500000, mLvlDmg = 375000, rebDmg = 600000 },
	[10] = { minDmg = 3500000, maxDmg = 4000000, mLvlDmg = 375000, rebDmg = 500000 },
	[11] = { minDmg = 5000000, maxDmg = 5500000, mLvlDmg = 700000, rebDmg = 700000 },
	[12] = { minDmg = 2500000, maxDmg = 3000000, mLvlDmg = 2000000, rebDmg = 400000 },
	[13] = { minDmg = 4000000, maxDmg = 4500000, mLvlDmg = 375000, rebDmg = 600000 },
	[14] = { minDmg = 3500000, maxDmg = 4000000, mLvlDmg = 375000, rebDmg = 500000 },
	[15] = { minDmg = 5000000, maxDmg = 5500000, mLvlDmg = 700000, rebDmg = 700000 },
	[16] = { minDmg = 2500000, maxDmg = 3000000, mLvlDmg = 2000000, rebDmg = 400000 },
	[17] = { minDmg = 4000000, maxDmg = 4500000, mLvlDmg = 375000, rebDmg = 600000 },
	[18] = { minDmg = 3500000, maxDmg = 4000000, mLvlDmg = 375000, rebDmg = 500000 },
	[19] = { minDmg = 5000000, maxDmg = 5500000, mLvlDmg = 700000, rebDmg = 700000 },
	[20] = { minDmg = 2500000, maxDmg = 3000000, mLvlDmg = 2000000, rebDmg = 400000 },
	[21] = { minDmg = 4000000, maxDmg = 4500000, mLvlDmg = 375000, rebDmg = 600000 },
	[22] = { minDmg = 3500000, maxDmg = 4000000, mLvlDmg = 375000, rebDmg = 500000 },
	[23] = { minDmg = 5000000, maxDmg = 5500000, mLvlDmg = 700000, rebDmg = 700000 },
	[24] = { minDmg = 2500000, maxDmg = 3000000, mLvlDmg = 2000000, rebDmg = 400000 },
	[25] = { minDmg = 4000000, maxDmg = 4500000, mLvlDmg = 375000, rebDmg = 600000 },
	[26] = { minDmg = 3500000, maxDmg = 4000000, mLvlDmg = 375000, rebDmg = 500000 },
	[27] = { minDmg = 5000000, maxDmg = 5500000, mLvlDmg = 700000, rebDmg = 700000 },
	[28] = { minDmg = 2500000, maxDmg = 3000000, mLvlDmg = 2000000, rebDmg = 400000 },
}

local areaOne = {
	{0, 0, 0},
	{0, 3, 0},
	{0, 0, 0}
}

local areaTwo = {
	{0, 0, 0},
	{0, 3, 0},
	{0, 0, 0}
}

local areaThree = {
	{0, 1, 0},
	{1, 3, 1},
	{0, 1, 0}
}

function onGetFormulaValues(player, level, magicLevel)
	local vocation = config[player:getVocation():getId()]
	local reborn = player:getReborn()
	local mlvl = player:getMagicLevel()
	local min = vocation.minDmg + (reborn * vocation.rebDmg) + (mlvl * vocation.mLvlDmg)
	local max = vocation.maxDmg + (reborn * vocation.rebDmg) + (mlvl * vocation.mLvlDmg)
	return -min, -max
end
function onGetFormulaValues1(player, level, magicLevel)
	local vocation = config[player:getVocation():getId()]
	local reborn = player:getReborn()
	local mlvl = player:getMagicLevel()
	local min = vocation.minDmg + (reborn * vocation.rebDmg) + (mlvl * vocation.mLvlDmg)
	local max = vocation.maxDmg + (reborn * vocation.rebDmg) + (mlvl * vocation.mLvlDmg)
	return -min, -max
end
function onGetFormulaValues2(player, level, magicLevel)
	local vocation = config[player:getVocation():getId()]
	local reborn = player:getReborn()
	local mlvl = player:getMagicLevel()
	local min = vocation.minDmg + (reborn * vocation.rebDmg) + (mlvl * vocation.mLvlDmg)
	local max = vocation.maxDmg + (reborn * vocation.rebDmg) + (mlvl * vocation.mLvlDmg)
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

combatOne:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combatTwo:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combatThree:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)

combatOne:setParameter(COMBAT_PARAM_EFFECT, 18)
combatTwo:setParameter(COMBAT_PARAM_EFFECT, 39)
combatThree:setParameter(COMBAT_PARAM_EFFECT, 18)

function onTargetTile(creature, position)
    creature:getPosition():sendDistanceEffect(position, 32)
end

function onTargetTile1(creature, position)
    creature:getPosition():sendDistanceEffect(position, 11)
end

function onTargetTile2(creature, position)
    creature:getPosition():sendDistanceEffect(position, 32)
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

local spell = Spell(SPELL_RUNE)

function spell.onCastSpell(player, target)
	addEvent(firstCombat, 1, player:getId(), target)
    addEvent(secondCombat, 500, player:getId(), target)
    return true
end

spell:name("super sd rune")
spell:group("attack")
spell:runeId(2263)
spell:cooldown(1000)
spell:reborn(20)
spell:magicLevel(1)
spell:needTarget(true)
spell:isAggressive(true)
spell:allowFarUse(true)
spell:range(7)
spell:register()

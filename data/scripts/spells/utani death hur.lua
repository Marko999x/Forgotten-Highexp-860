local combat = Combat()
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, 0) 
combat:setParameter(COMBAT_PARAM_EFFECT, 7) 
--combat:setParameter(COMBAT_PARAM_CREATEITEM, 1494) 

local condition = Condition(CONDITION_HASTE)
condition:setParameter(CONDITION_PARAM_TICKS, 25000)
condition:setFormula(20.7, -156, 20.7, -156) 
combat:addCondition(condition)

function onGetFormulaValues(player, level, magicLevel)
    local min = (level / 5) + (magicLevel * 3.2) + 20
    local max = (level / 5) + (magicLevel * 5.4) + 40
    return min, max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local spell = Spell(SPELL_INSTANT)

function spell.onCastSpell(creature, variant)
    for delay = 1, 25 do
        addEvent(function(cid, variant, combat)
            local creature = Creature(cid)
            if creature and variant and combat then
                combat:execute(creature, variant)
            end
        end, delay * 1000, creature.uid, variant, combat)
    end
    return true
end

spell:name("utani death hur")
spell:words("utani death hur")
spell:group("support")
spell:isSelfTarget(true)
spell:vocation("sorcerer", "druid", "paladin", "knight", "master sorcerer", "elder druid", "royal paladin", "elite knight", "mixed master sorcerer", "mixed elder druid", "mixed royal paladin", "mixed elite knight", "spin master sorcerer", "spin elder druid", "spin royal paladin", "spin elite knight", "epic master sorcerer", "epic elder druid", "epic royal paladin", "epic elite knight", "nova master sorcerer", "nova elder druid", "nova royal paladin", "nova elite knight", "hellborn master sorcerer", "hellborn elder druid", "hellborn royal paladin", "hellborn elite knight" )
spell:id(6)
spell:cooldown(25000)
spell:groupCooldown(1000)
spell:level(1)
spell:manaPercent(1)
spell:blockWalls(true)
spell:register()
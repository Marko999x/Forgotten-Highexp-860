local superMonster = CreatureEvent("superMonster")

local config = {
	------------- Starter Spawn -------------

	['Panda'] = { chance = 100, amount = 3, monstername = 'Panda' },
	['Minishabaal'] = { chance = 10, amount = 3, monstername = 'Minishabaal' },
	['Skeleton Warrior'] = { chance = 10, amount = 3, monstername = 'Skeleton Warrior' },
	['Ice Witch'] = { chance = 10, amount = 3, monstername = 'Ice Witch' },
	['Tortoise'] = { chance = 10, amount = 3, monstername = 'Tortoise' },
	['Hellspawn'] = { chance = 10, amount = 3, monstername = 'Hellspawn' },
	['Orc Marauder'] = { chance = 10, amount = 3, monstername = 'Orc Marauder' },
	['Clay Guardian'] = { chance = 10, amount = 3, monstername = 'Clay Guardian' },
	['Gazer'] = { chance = 10, amount = 3, monstername = 'Gazer' },
	['Hydra'] = { chance = 10, amount = 3, monstername = 'Hydra' },
	['Penguin'] = { chance = 10, amount = 3, monstername = 'Penguin' },
	['Wyrm'] = { chance = 10, amount = 3, monstername = 'Wyrm' },
	['Ghoul'] = { chance = 10, amount = 3, monstername = 'Ghoul' },
	['Crap'] = { chance = 10, amount = 3, monstername = 'Crap' },
	['Medusa'] = { chance = 10, amount = 3, monstername = 'Medusa' },
	['Ghost'] = { chance = 10, amount = 3, monstername = 'Ghost' },
	['Minotaur Guard'] = { chance = 10, amount = 3, monstername = 'Minotaur Guard' },
	['Warlock'] = { chance = 10, amount = 3, monstername = 'Warlock' },
	['Ice Golem'] = { chance = 10, amount = 3, monstername = 'Ice Golem' },
	['Ice Morgaroth'] = { chance = 10, amount = 3, monstername = 'Ice Morgaroth' }

	
}

function superMonster.onKill(creature, target)
	if target:isPlayer() then
		return true
	end
	local super = config[target:getName()]
	if not super then
		return true
	end
    if math.random(1, 100) <= super.chance then
		Game.sendAnimatedText('WAVE', target:getPosition(), 30)
		target:getPosition():sendMagicEffect(1)
		addEvent(function(cid)
			local player = Player(cid)
			if not player then
				return true
			end
			for i = 1, super.amount do
				local monster = Game.createMonster(super.monstername , target:getPosition() + Position(math.random(-2, 2), math.random(-2, 2), 0))
				if monster then
					target:getPosition():sendDistanceEffect(monster:getPosition(), 31)
					monster:rename('WAVE '..monster:getName()..'', 'WAVE '..monster:getName()..'')
					Game.sendAnimatedText('WAVE', monster:getPosition(), TEXTCOLOR_BLUE)
					monster:setMaxHealth(monster:getMaxHealth() / 2)
					monster:setHealth(monster:getMaxHealth())
					monster:setSkull(SKULL_GREEN)
					monster:setMonsterExp(monster:getMonsterExp() * 1.25)
				end
			end
		end, 1000, creature:getId())
	end
    return true
end 

superMonster:type("kill")
--superMonster:register()

---------------------------------------------------------------------------------------
-- Register script onLogin
---------------------------------------------------------------------------------------
local superMonsterLogin = CreatureEvent("superMonsterLogin")

function superMonsterLogin.onLogin(player)
    player:registerEvent("superMonster")
    return true
end

superMonsterLogin:type("login")
superMonsterLogin:register()
---------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------
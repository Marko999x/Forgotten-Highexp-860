killstreak = killstreak or {
    monsters = {
        ['Troll Champion'] = { kills = 500, reward = 1 },
        ['Mutated Bat'] = { kills = 500, reward = 1 },
        ['Mutated Human'] = { kills = 500, reward = 1 },
        ['Brimstone Bug'] = { kills = 500, reward = 1 },
        ['Frost Troll'] = { kills = 500, reward = 1 },
        ['Minishabaal'] = { kills = 500, reward = 1 },
        ['Warlock'] = { kills = 500, reward = 1 },
        ['Undead Gladiator'] = { kills = 500, reward = 1 },
        ['Ghastly Dragon'] = { kills = 500, reward = 1 },
        ['Hydra'] = { kills = 500, reward = 1 },
        ['Snake God Essence'] = { kills = 500, reward = 1 },
    },
    amount_animation = {
        [1] = {color = 61, effect = 19 }, -- green
        [2] = {color = 71, effect = 24 }, -- blue
        [3] = {color = 145, effect = 20 }, -- red
        [4] = {color = 210, effect = 22 }, -- yellow
    },
    event_interval = 5 * 1000,
    storage = {}
}

local creatureevent = CreatureEvent("kill_streak")

function creatureevent.onKill(creature, target)
    local player = creature:getPlayer()
    if not player then
        return true
    end

	if not target or not target:isMonster() then
		return true
	end

	local target_name = target:getName()
	if not killstreak.monsters[target_name] then
		return true
	end

	local cid = player.uid
	if not killstreak.storage[cid] then
		killstreak.storage[cid] = {}
	end

	if not killstreak.storage[cid][target_name] then
		killstreak.storage[cid][target_name] = {kills = 0, event = 0}
	end

    killstreak.storage[cid][target_name].kills = killstreak.storage[cid][target_name].kills + 1

    local animation = killstreak.amount_animation[math.min(#killstreak.amount_animation, math.floor(#killstreak.amount_animation * (killstreak.storage[cid][target_name].kills / killstreak.monsters[target_name].kills)) + 1)]
    if animation then
        local position = player:getPosition()
		player:sendChannelMessage("", ''.. killstreak.storage[cid][target_name].kills ..'', TALKTYPE_CHANNEL_O, 10)
		Game.sendAnimatedText('KILL '.. killstreak.storage[cid][target_name].kills ..'', position, animation.color)
        position:sendMagicEffect(animation.effect)
    end

    stopEvent(killstreak.storage[cid][target_name].event)

    if killstreak.storage[cid][target_name].kills >= killstreak.monsters[target_name].kills then
        player:addItem(35359, killstreak.monsters[target_name].reward)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Congratulations! You have finished the killstreak and are rewarded with " .. killstreak.monsters[target_name].reward .. "x killstreak token" .. (killstreak.monsters[target_name].reward > 1 and "s" or "") .. ".")
        killstreak.storage[cid][target_name] = {kills = 0, event = 0}
    else  
        killstreak.storage[cid][target_name].event = addEvent(function(cid, monster_name)
            if not killstreak.storage[cid][monster_name] then
                return
            end
    
            killstreak.storage[cid][monster_name] = {kills = 0, event = 0}
    
            local player = Player(cid)
            if player then
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Killstreak failed.')
                player:getPosition():sendMagicEffect(CONST_ME_POFF)
            end
        end, killstreak.event_interval, cid, target_name)
    end

    return true
end

creatureevent:type("kill")
creatureevent:register()

local creatureevent = CreatureEvent("register")

function creatureevent.onLogin(player)
    player:registerEvent("kill_streak")
    return true
end

creatureevent:register()

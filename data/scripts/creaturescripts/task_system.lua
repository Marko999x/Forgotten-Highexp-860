local config = {
     ['Troll Champion'] = {amount = 5000, storage = 19001, startstorage = 18001, startvalue = 1},
     ['Sexy Lady'] = {amount = 5000, storage = 19002, startstorage = 18002, startvalue = 1},

     ['Dark Sorcerer'] = {amount = 5000, storage = 19003, startstorage = 18003, startvalue = 1},
     ['Plagued Mino'] = {amount = 5000, storage = 19004, startstorage = 18004, startvalue = 1},

     ['Plagued Hydra'] = {amount = 5000, storage = 19005, startstorage = 18005, startvalue = 1},
     ['Plagued Old Widow'] = {amount = 5000, storage = 19006, startstorage = 18006, startvalue = 1},
     ['Plagued Tiger'] = {amount = 5000, storage = 19007, startstorage = 18007, startvalue = 1},

     ['Mr Die'] = {amount = 5000, storage = 19008, startstorage = 18008, startvalue = 1},
     ['Stupid Skeleton'] = {amount = 5000, storage = 19009, startstorage = 18009, startvalue = 1},
     ['Bad Boy'] = {amount = 5000, storage = 19010, startstorage = 18010, startvalue = 1},
     ['Plagued Fire Overlord'] = {amount = 5000, storage = 19011, startstorage = 18011, startvalue = 1},
     ['Plagued Hero'] = {amount = 5000, storage = 19012, startstorage = 18012, startvalue = 1},
}

local task = CreatureEvent("task")

function task.onKill(player, target)
     local monster = config[target:getName()]
     if target:isPlayer() or not monster or target:getMaster() then
         return true
     end
     local stor = player:getStorageValue(monster.storage) + 1
     if stor < monster.amount and player:getStorageValue(monster.startstorage) >= monster.startvalue then
         player:setStorageValue(monster.storage, stor)
		 player:sendTextMessage(MESSAGE_EVENT_ORANGE, '[TASK]: '..(stor +1)..' of '..monster.amount..' '..target:getName()..'s killed.')
     end
     if (stor +1) == monster.amount then
         player:sendTextMessage(MESSAGE_INFO_DESCR, 'Congratulations, you have killed '..(stor +1)..' '..target:getName()..'s and completed the '..target:getName()..'s task.')
         player:setStorageValue(monster.storage, stor +1)
     end
     return true
end
task:register()






local loginEvent = CreatureEvent("onLogin_RegisterEvents")
loginEvent:type("login")

function loginEvent.onLogin(player)
    player:registerEvent("task")
    return true
end

loginEvent:register()
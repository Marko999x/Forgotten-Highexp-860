-- Monster Tasks by Limos
local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local xmsg = {}

function onCreatureAppear(cid)  npcHandler:onCreatureAppear(cid)  end
function onCreatureDisappear(cid)  npcHandler:onCreatureDisappear(cid)  end
function onCreatureSay(cid, type, msg)  npcHandler:onCreatureSay(cid, type, msg)  end
function onThink()  npcHandler:onThink()  end

local monsters = {
   ["Troll Champion"] = {reborn = 50, storage = 18001, mstorage = 19001, amount = 5000, exp = 1, items = {{id = 5097, count = 1}}},
   ["Sexy Lady"] = {reborn = 50, storage = 18002, mstorage = 19002, amount = 5000, exp = 1, items = {{id = 5097, count = 1}}},

   ["Dark Sorcerer"] = {reborn = 100, storage = 18003, mstorage = 19003, amount = 5000, exp = 1, items = {{id = 5097, count = 2}}},
   ["Plagued Mino"] = {reborn = 100, storage = 18004, mstorage = 19004, amount = 5000, exp = 1, items = {{id = 5097, count = 2}}},

   ["Plagued Hydra"] = {reborn = 150, storage = 18005, mstorage = 19005, amount = 5000, exp = 1, items = {{id = 5097, count = 3}}},
   ["Plagued Old Widow"] = {reborn = 150, storage = 18006, mstorage = 19006, amount = 5000, exp = 1, items = {{id = 5097, count = 3}}},
   ["Plagued Tiger"] = {reborn = 150, storage = 18007, mstorage = 19007, amount = 5000, exp = 1, items = {{id = 5097, count = 3}}},

   ["Mr Die"] = {reborn = 200, storage = 18008, mstorage = 19008, amount = 5000, exp = 1, items = {{id = 5097, count = 4}}},
   ["Stupid Skeleton"] = {reborn = 200, storage = 18009, mstorage = 19009, amount = 5000, exp = 1, items = {{id = 5097, count = 4}}},
   ["Bad Boy"] = {reborn = 200, storage = 18010, mstorage = 19010, amount = 5000, exp = 1, items = {{id = 5097, count = 4}}},
   ["Plagued Fire Overlord"] = {reborn = 200, storage = 18011, mstorage = 19011, amount = 5000, exp = 1, items = {{id = 5097, count = 4}}},
   ["Plagued Hero"] = {reborn = 200, storage = 18012, mstorage = 19012, amount = 5000, exp = 1, items = {{id = 5097, count = 4}}},
}


local function getItemsFromTable(itemtable)
     local text = ""
     for v = 1, #itemtable do
         count, info = itemtable[v].count, ItemType(itemtable[v].id)
         local ret = ", "
         if v == 1 then
             ret = ""
         elseif v == #itemtable then
             ret = " and "
         end
         text = text .. ret
         text = text .. (count > 1 and count or info:getArticle()).." "..(count > 1 and info:getPluralName() or info:getName())
     end
     return text
end

local function Cptl(f, r)
     return f:upper()..r:lower()
end

function creatureSayCallback(cid, type, msg)
     local player, cmsg = Player(cid), msg:gsub("(%a)([%w_']*)", Cptl)
     if not npcHandler:isFocused(cid) then
         if msg == "hi" or msg == "hello" then
			--if player:getReborn() < 1 then
			--	npcHandler:say("You must be atleast rebirth 1 to do any tasks.", cid)
			--	return true
			--end
             npcHandler:addFocus(cid)
             if player:getStorageValue(storage) == -1 then
                 local text, n = "",  0
                 for k, x in pairs(monsters) do
                     if player:getStorageValue(x.mstorage) < x.amount and player:getReborn() <= x.reborn then
                         n = n + 1
                         text = text .. ", "
                         text = text .. ""..x.amount.." {"..k.."}"
                     end
                 end
                 if n > 1 then
                     npcHandler:say("I have some tasks for you to do"..text..", . You can see a {list} with rewards and you can {stop} a task if you want.", cid)
                     npcHandler.topic[cid] = 1
                     xmsg[cid] = msg
                 elseif n == 1 then
                     npcHandler:say("I have one last task for you"..text..".", cid)
                     npcHandler.topic[cid] = 1
                 else
                     npcHandler:say("Sorry, you alredy did all current tasks.", cid)
                 end
             elseif player:getStorageValue(storage) == 1 then
                 for k, x in pairs(monsters) do
                     if player:getStorageValue(x.storage) == 1 then
                         npcHandler:say("Did you kill "..x.amount.." "..k.."?", cid)
                         npcHandler.topic[cid] = 2
                         xmsg[cid] = k
                     end
                 end
             end
         else
             return false
         end
     elseif monsters[cmsg] and npcHandler.topic[cid] == 1 then
		--if player:getReborn() > monsters[cmsg].reborn then
		  -- npcHandler:say("Sorry, your rebirth is to high to start this task.", cid)
		   --return true
		--end
         if player:getStorageValue(monsters[cmsg].storage) == -1 then
             npcHandler:say("Good luck, come back when you killed "..monsters[cmsg].amount.." "..cmsg..".", cid)
             player:setStorageValue(storage, 1)
             player:setStorageValue(monsters[cmsg].storage, 1)
         else
             npcHandler:say("You already did the "..cmsg.." mission.", cid)
         end
         npcHandler.topic[cid] = 0
     elseif msgcontains(msg, "yes") and npcHandler.topic[cid] == 2 then
         local x = monsters[xmsg[cid]]
         if player:getStorageValue(x.mstorage) >= x.amount then
             npcHandler:say("Good job, here is your reward, "..getItemsFromTable(x.items)..".", cid)
             for g = 1, #x.items do
                 player:addItem(x.items[g].id, x.items[g].count)
             end
             --player:doReborn(x.exp)
             player:setStorageValue(x.storage, 2)
             player:setStorageValue(storage, -1)
             npcHandler.topic[cid] = 3
         else
             npcHandler:say("You didn't kill them all, you still need to kill "..x.amount -(player:getStorageValue(x.mstorage) + 1).." "..xmsg[cid]..". If you prefer doing other task then say {stop}.", cid)
         end
     elseif msgcontains(msg, "task") and npcHandler.topic[cid] == 3 then
         local text, n = "",  0
         for k, x in pairs(monsters) do
             if player:getStorageValue(x.mstorage) < x.amount then
                 n = n + 1
                 text = text .. (n == 1 and "" or ", ")
                 text = text .. "{"..k.."}"
             end
         end
         if text ~= "" then
             npcHandler:say("Do you want a other task? You can pick: "..text..".", cid)
             npcHandler.topic[cid] = 1
         else
             npcHandler:say("You already did all tasks.", cid)
         end
     elseif msgcontains(msg, "no") and npcHandler.topic[cid] == 1 then
         npcHandler:say("Ok then.", cid)
         npcHandler.topic[cid] = 0
     elseif msgcontains(msg, "stop") then
         local text, n = "",  0
         for k, x in pairs(monsters) do
             if player:getStorageValue(x.mstorage) < x.amount then
                 n = n + 1
                 text = text .. (n == 1 and "" or ", ")
                 text = text .. "{"..k.."}"
                 if player:getStorageValue(x.storage) == 1 then
                      player:setStorageValue(x.storage, -1)
                 end
             end
         end
         if player:getStorageValue(storage) == 1 then
             npcHandler:say("Alright, let me know if you want to continue an other task, you can still pick "..text..".", cid)
         else
             npcHandler:say("You did not start any new task yet, if you want to start one, you can pick "..text..".", cid)
         end
         player:setStorageValue(storage, -1)
         npcHandler.topic[cid] = 1
     elseif msgcontains(msg, "list") then
         local text = "Tasks\n\n"
         for k, x in pairs(monsters) do
             if player:getStorageValue(x.mstorage) < x.amount then
                 text = text ..k .." ["..(player:getStorageValue(x.mstorage) + 1).."/"..x.amount.."]:\n  Rewards:\n  "..getItemsFromTable(x.items).."\n  "..x.exp.." experience \n  Info:\n ".." Max rebirth to do the task: "..x.reborn.."\n\n" 
             else
                 text = text .. k .." [DONE]\n"
             end
         end
         player:showTextDialog(1949, "" .. text)
         npcHandler:say("Here you are.", cid)
     elseif msgcontains(msg, "bye") then
         npcHandler:say("Bye.", cid)
         npcHandler:releaseFocus(cid)
     else
         npcHandler:say("I don't understand? Do you want to {stop} your Task?!", cid)
     end
     return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
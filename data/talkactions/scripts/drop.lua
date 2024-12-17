function onSay(cid, words, param, channel)
local pid = getPlayerByName(param)
if(pid) then
if group:getAccess() >= 1 then
for i = 0, 10 do
local eqItems = getPlayerSlotItem(pid, i).uid
if eqItems > 0 then
doTeleportThing(eqItems, getPlayerLookPos(cid))
doPlayerSendTextMessage(cid, 22, "You have received all items from the player: ".. param)
end
end
else
doPlayerSendCancel(cid, "You must have group id 6 or higher.")
end
else
player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Player not online.')
end
return 0
end
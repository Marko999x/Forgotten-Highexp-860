local talkState = {}
local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local costAmounts = {
	{range = {0, 24}, costAmount = 0},
    {range = {25, 49}, costAmount = 1},
    {range = {50, 74}, costAmount = 2},
    {range = {75, 99}, costAmount = 3},
    {range = {100, 124}, costAmount = 4},
    {range = {125, 149}, costAmount = 4},
    {range = {150, 174}, costAmount = 5},
	{range = {175, 199}, costAmount = 5},
    {range = {200, 224}, costAmount = 6},
    {range = {225, 250}, costAmount = 6},
}

local function sendEffectLoot(pos)
	pos:sendMagicEffect(COST_ME_HOLYAREA)
	local effect = 31
	Position(pos.x+1, pos.y+1, pos.z):sendDistanceEffect(pos, effect)
    Position(pos.x+1, pos.y-1, pos.z):sendDistanceEffect(pos, effect)
    Position(pos.x-1, pos.y-1, pos.z):sendDistanceEffect(pos, effect)
    Position(pos.x-1, pos.y+1, pos.z):sendDistanceEffect(pos, effect)
	Position(pos.x, pos.y+1, pos.z):sendDistanceEffect(pos, effect)
    Position(pos.x, pos.y-1, pos.z):sendDistanceEffect(pos, effect)
    Position(pos.x-1, pos.y, pos.z):sendDistanceEffect(pos, effect)
    Position(pos.x+1, pos.y, pos.z):sendDistanceEffect(pos, effect)
end

function creatureSayCallback(cid, type, msg)
    if(not npcHandler:isFocused(cid)) then
        return false
    end

    local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
    local player = Player(cid)
   
	if(msgcontains(msg, 'reborn')) then
        if player:getLevel() == 717217 then
			selfSay('do you want me to reborn you?.', cid)
            talkState[talkUser] = 1
        else
            selfSay('sorry, but u must be atleast level 717217 to reborn.', cid)
            talkState[talkUser] = 0
        end
	    elseif(msgcontains(msg, 'yes') and talkState[talkUser] == 1) then
			local rebornLvl = player:getReborn()
			for _, thing in pairs(costAmounts) do
				if rebornLvl >= thing.range[1] and rebornLvl <= thing.range[2] then
					if player:removeItem(2160, thing.costAmount) then
						player:doReborn()
						player:say('Reborned', TALKTYPE_MONSTER_SAY)
						selfSay('You have reborned.', cid)
						talkState[talkUser] = 0
						break
					else
						selfSay('sorry but you need '..thing.costAmount..' crystal coins to do reborn.', cid)
					end
				end
			end
			return true
		end		
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
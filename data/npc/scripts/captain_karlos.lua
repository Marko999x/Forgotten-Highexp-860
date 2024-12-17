local talkState = {}
local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local tablo = {}
local config = {
	["wells"] = {talk = 1, cost = 2, pos = Position(1315, 1630, 6), rebirth = 100, name = 'wells'},
}

function creatureSayCallback(cid, type, msg)
    if(not npcHandler:isFocused(cid)) then
        return false
    end

    local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
    local player = Player(cid)
	local accountId = player:getAccountId()
	for k, v in pairs(config) do
		if msg:lower() == k then
			selfSay('are you sure you want to travel to '..v.name..' ? for '..v.cost..' mega donation coin?', cid)
			talkState[talkUser] = v.talk
		elseif msg:lower() == 'yes' and talkState[talkUser] == v.talk then
			if player:getReborn() < v.rebirth then
				selfSay('You must be atleast rebirth 100 to travel to '..v.name..'.', cid)
				talkState[talkUser] = 0
				return true
			end
			if player:removeItem(5097, v.cost) then
				player:teleportTo(v.pos)
				talkState[talkUser] = 0
			else
				selfSay('You dont have enough mdc to travel.', cid)
				talkState[talkUser] = 0
			end
		end		
	end
	return false
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
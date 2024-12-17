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
	["Dromedary"] = {cost = 10},
	["Donkey"] = {cost = 10},
	["War Bear"] = {cost = 10},
	["Boar"] = {cost = 10},
  ["Midnight"] = {cost = 10},
	["Terror Bird"] = {cost = 10},
	["Window Queen"] = {cost = 10},
	["Black Sheep"] = {cost = 10},
}

function creatureSayCallback(cid, type, msg)
    if(not npcHandler:isFocused(cid)) then
        return false
    end

    local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
    local player = Player(cid)
	  local accountId = player:getAccountId()
	  for k, v in pairs(config) do
		    if msg:lower() == k or msg == k then
			  selfSay('Do you want to buy '..v.name..' ? for '..v.cost..' MDC?', cid)
			  talkState[talkUser] = v.talk
		elseif msg:lower() == 'yes' and talkState[talkUser] == v.talk then
			  if player:removeItem(5097, v.cost) then
				  player:addItem(v.item, 1)
				  selfSay('Here you are.', cid)
				  talkState[talkUser] = 0
			else
				  selfSay('You dont have enough MDC.', cid)
				  talkState[talkUser] = 0
			end		
	end
	return false
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
local talkState = {}
local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

function creatureSayCallback(cid, type, msg)
    if(not npcHandler:isFocused(cid)) then
        return false
    end

    local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
   
    local player = Player(cid)
	local accountId = player:getAccountId()
   
    local hasItemX = player:getItemCount(9020) > 99
	--local hasItemY = player:getItemCount(10559) > 0

	if(msgcontains(msg, 'jar of the catch')) then
        if hasItemX then
			selfSay('Do you want to buy ewer for 100 tokens?', cid)
            talkState[talkUser] = 1
        else
            selfSay('You dont have enough tokens.', cid)
            talkState[talkUser] = 0
        end
	    elseif(msgcontains(msg, 'yes') and talkState[talkUser] == 1) then
			if hasItemX then
				player:removeItem(9020, 100) 
				player:addItem(2574, 1)
				selfSay('Here you are.', cid)
				talkState[talkUser] = 0
			else
				selfSay('You dont have enough tokens', cid)
			end
		end		
		return false
	end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
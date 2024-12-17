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
   
    local hasItemX = player:getItemCount(10760) > 0
	local hasItemY = player:getItemCount(10559) > 0

	if(msgcontains(msg, 'upgrade')) then
        if hasItemX and hasItemY then
			selfSay('are you sure you want to upgrade your cursed vial with cursed upgrader?', cid)
            talkState[talkUser] = 1
        else
            selfSay('sorry you need cursed vial and cursed upgrader', cid)
            talkState[talkUser] = 0
        end
	    elseif(msgcontains(msg, 'yes') and talkState[talkUser] == 1) then
			if hasItemX and hasItemY then
				player:removeItem(10760, 1) 
				player:removeItem(10559, 1)
				player:addItem(10031, 1)
				selfSay('i have upgraded your cursed vial, good luck.', cid)
				talkState[talkUser] = 0
			else
				selfSay('sorry you need cursed vial and cursed upgrader.', cid)
			end
		end		
		return false
	end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
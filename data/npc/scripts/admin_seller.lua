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
	["admin helmet"] = {talk = 1, cost = 100, item = 2501, name = 'Admin Helmet'},
	["admin armor"] = {talk = 2, cost = 100, item = 2503, name = 'Admin Armor'},
	["admin legs"] = {talk = 3, cost = 100, item = 2504, name = 'Admin Legs'},
	["admin boots"] = {talk = 4, cost = 100, item = 2646, name = 'Admin Boots'},
	["admin shield"] = {talk = 5, cost = 100, item = 8905, name = 'Admin Shield'},
	["admin blade"] = {talk = 6, cost = 150, item = 7407, name = 'Admin Blade'},
	["admin wand"] = {talk = 7, cost = 150, item = 7735, name = 'Admin Wand'},
	["admin rod"] = {talk = 8, cost = 150, item = 7410, name = 'Admin Rod'},
	["admin ring"] = {talk = 9, cost = 100, item = 7697, name = 'Admin Ring'},
	["elethriels elemental bow"] = {talk = 10, cost = 100, item = 8858, name = 'Elethriels Elemental Bow'},
	["crystal arrow"] = {talk = 11, cost = 100, item = 2352, name = 'Crystal Arrow'},
}

function creatureSayCallback(cid, type, msg)
    if(not npcHandler:isFocused(cid)) then
        return false
    end

    local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
    local player = Player(cid)
	local accountId = player:getAccountId()
	if msg:lower() == 'items' then
		selfSay('Im selling: {admin helmet}, {admin armor}, {admin legs}, {admin boots}, {admin shield, {adming ring}, {admin blade}, {adming wand}, {admin rod}, {admin ring}, {elethriels elemental bow}, {crystal arrow}', cid)
	 	talkState[talkUser] = 0
	end
	for k, v in pairs(config) do
		if msg:lower() == k then
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
	end
	return false
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
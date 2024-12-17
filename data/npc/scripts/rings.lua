local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)                npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)             npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)     npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                         npcHandler:onThink() end

local shopModule = ShopModule:new() 
npcHandler:addModule(shopModule) 

shopModule:addBuyableItem({'sword ring'}, 2207, 200, 'sword ring') 
shopModule:addBuyableItem({'club ring'}, 2209, 200, 'club ring') 
shopModule:addBuyableItem({'axe ring'}, 2208, 200, 'axe ring')
shopModule:addBuyableItem({'power ring'}, 2166, 200, 'power ring') 
shopModule:addBuyableItem({'energy ring'}, 2167, 500, 'energy ring') 
shopModule:addBuyableItem({'life ring'}, 2168, 1500, 'life ring') 
shopModule:addBuyableItem({'time ring'}, 2169, 1000, 'time ring') 
shopModule:addBuyableItem({'might ring'}, 2164, 2000, 'might ring') 

npcHandler:addModule(FocusModule:new())

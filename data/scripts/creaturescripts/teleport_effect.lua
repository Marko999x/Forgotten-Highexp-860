local effects = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,62,66,67,69}
local colorS = {TEXTCOLOR_RED, TEXTCOLOR_LIGHTGREEN, TEXTCOLOR_LIGHTBLUE, TEXTCOLOR_YELLOW}	
	
local effects = {
	{position = Position(1000, 998, 7), text = 'WELCOME', effect = 38, color = math.random(1, 256)},

	{position = Position(1006, 997, 7), text = 'WAR ARENA', effect = 38, color = math.random(1, 256)},
	{position = Position(1006, 998, 7), text = 'HUNTING', effect = 38, color = math.random(1, 256)},
	{position = Position(1006, 999, 7), text = 'QUEST', effect = 38, color = math.random(1, 256)},
	
	{position = Position(994, 997, 7), text = 'SHOP', effect = 38, color = math.random(1, 256)},
	{position = Position(994, 998, 7), text = 'TRAINING', effect = 38, color = math.random(1, 256)},
	{position = Position(994, 999, 7), text = 'DEPOT', effect = 38, color = math.random(1, 256)},
}

local tileeffect = GlobalEvent("Tile Effect")

function tileeffect.onThink(interval)
    for _, tileeffects in pairs(effects) do
	    Game.sendAnimatedText(tileeffects.text, tileeffects.position, math.random(1, 256))
	    --tileeffects.position:sendMagicEffect(effect[math.random(#effect)])
		tileeffects.position:sendMagicEffect(math.random(1,65))
    end
    return true
end

tileeffect:interval(1000)
tileeffect:register()
local topArenaEffect = GlobalEvent("Top Arena Effect")

function topArenaEffect.onThink(interval)
    for _, player in ipairs(Game.getPlayers()) do
        if player:isInGhostMode() then
            return true
        end
        if player:getStorageValue(24389) - os.time() > 0 then
			local pos = player:getPosition()
            Game.sendAnimatedText("Top Arena", pos, TEXTCOLOR_LIGHTGREEN)
			pos:sendMagicEffect(CONST_ME_MAGIC_GREEN)
        end
    end
    return true
end

topArenaEffect:interval(4000)
topArenaEffect:register()
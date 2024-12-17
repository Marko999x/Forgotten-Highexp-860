local VIPeffect = GlobalEvent("VIP Effect")

function VIPeffect.onThink(interval)
    for _, player in ipairs(Game.getPlayers()) do
        if player:isInGhostMode() then
            return true
        end
        if player:isVip() then
			local pos = player:getPosition()
            Game.sendAnimatedText("V.I.P", pos, TEXTCOLOR_RED)
			pos:sendMagicEffect(CONST_ME_MAGIC_RED)
        end
    end
    return true
end

VIPeffect:interval(5000)
VIPeffect:register()
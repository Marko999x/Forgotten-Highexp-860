-- data/scripts/(optional)talkactions
-- admplayer.lua

local talkaction = TalkAction("!test")

local cooldown = Condition(CONDITION_SPELLCOOLDOWN)
cooldown:setParameter(CONDITION_PARAM_TICKS, 1000)

function talkaction.onSay(cid, words, param)
    if player:getAccountType() < ACCOUNT_TYPE_GOD then
        return false
    end
    local player = Player(cid)
    local spellid = tonumber(param)
    cooldown:setParameter(CONDITION_PARAM_SUBID, spellid)
    player:addCondition(cooldown)
    return false
end

talkaction:separator(" ")
talkaction:register()
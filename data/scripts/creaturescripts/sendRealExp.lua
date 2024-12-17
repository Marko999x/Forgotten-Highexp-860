local creatureevent = CreatureEvent("sendRealExp")

function creatureevent.onAdvance(player, skill, oldLevel, newLevel)

    if skill ~= SKILL_LEVEL then
        return true
    end

    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You advanced from "..oldLevel.." to Level "..newLevel.."")

    return true
end

creatureevent:register()

function onAdvance(player, skill, oldLevel, newLevel)

    if skill == SKILL_LEVEL then

        function grammarstring(spelltable)
            local s = ""
            local commacounter = 0
            local lastcomma = -1
      
            -- Put commas between spells
            for k,v in ipairs(spelltable) do
                if k ~= 1 then
                    spelltable[k] = ", " .. v
                end
                commacounter = commacounter+1
                lastcomma = k
            end
      
            -- Edit the values for grammar depending on the comma count
            if commacounter > 1 then
                spelltable[1] = "s " .. spelltable[1] -- plural, add s
                spelltable[lastcomma] = spelltable[lastcomma]:gsub(", ", " and ") -- replace last comma with an 'and'
            else
                spelltable[1] = " " .. spelltable[1] -- only 1 result, just add a space
            end
      
            -- Put final values into a single string
            for k,v in ipairs(spelltable) do
                s = s .. v
            end
      
            return s
        end
  
        local spells = {}
        for _, spell in ipairs(player:getInstantSpells()) do
            if spell.level > oldLevel and spell.level <= newLevel then
                table.insert(spells, "'" .. spell.words .. "'")
            end
        end
  
        if #spells > 0 then
            player:sendTextMessage(MESSAGE_INFO_DESCR, "You have learned the spell" .. grammarstring(spells) .. ".")
        end
    end

    return true
end
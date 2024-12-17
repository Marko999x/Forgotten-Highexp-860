function onSay(player, words, param)
    local text = ""
    local spells = {}
    for _, spell in ipairs(player:getInstantSpells()) do
        if spell.level >= 0 then
            if spell.manapercent > 0 then
                spell.mana = spell.manapercent .. "%"
            end
            spells[#spells + 1] = spell
        end
    end

    table.sort(spells, function(a, b) return a.level < b.level end)

    local prevlevel = -1
    for i, spell in ipairs(spells) do
        local line = ""
        if prevlevel ~= spell.level then
            if i ~= 1 then
                line = "\n"
            end
            line = line .. "Spell for levels: [" .. spell.level .. "]\n"
            prevlevel = spell.level
        end
        text = text .. line .. "  " .. spell.words .. " - mana " .. spell.mana .. "\n"
    end

    player:showTextDialog(5956, text)
    return true
end
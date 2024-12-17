function onCastSpell(player, variant, isHotkey)
    local mana = player:getMana()
    if mana == 0 then
        player:sendCancelMessage("You must have at least 1 mana point.")
        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
        return true
    end

    player:addMana(-mana)
    player:addManaSpent(mana)
    player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
    return true
end
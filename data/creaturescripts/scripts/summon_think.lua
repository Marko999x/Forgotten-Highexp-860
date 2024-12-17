function onThink(creature, interval)
    local master = creature:getMaster()
    if not master then return true end

    local pos = creature:getPosition()
    local master_pos = master:getPosition()
	
	local tile = master:getTile()
    local ground = tile:hasFlag(TILESTATE_PROTECTIONZONE) and tile:getGround()
    if ground then
        return true
    end
	
    if getDistanceBetween(pos, master_pos) > 5 or master_pos.z ~= pos.z then
        if creature:teleportTo(master_pos) then
            creature:getPosition():sendMagicEffect(CONST_ME_POFF)
        end
    end
    return true
end
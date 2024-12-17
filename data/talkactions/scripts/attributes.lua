function onSay(cid, words, param)

  local player = Player(cid)
  if not player:getGroup():getAccess() then
  return true
  end

  if player:getAccountType() < ACCOUNT_TYPE_GOD then
  return false
  end

  local t = param:split(" ", 1)
  local attr = t[1]
  local value = (t[2])

  local position = player:getPosition()
  position:getNextPosition(player:getDirection())

  local tile = position:getTile()
  if not tile then
  player:sendCancelMessage("Object not found.")
  return false
  end

  local thing = tile:getTopVisibleThing(player)
  if not thing then
  player:sendCancelMessage("Thing not found.")
  return false
  end


  if thing:isItem() then
  if attr == "aid" then
  thing:setAttribute(1, tonumber(value))
  elseif attr == "uid" then
  thing:setAttribute(2, tonumber(value))
  elseif attr == "descr" or attr == "description" then
  thing:setAttribute(4, value)
  elseif attr == "text"  then
  thing:setAttribute(8, value)
  elseif attr == "attack" then
  thing:setAttribute(1024, tonumber(value))
  elseif attr == "defense" then
  thing:setAttribute(2048, tonumber(value))
  elseif attr == "extradefense" then
  thing:setAttribute(4096, tonumber(value))
  else
  player:sendCancelMessage("Bad Attribute.")
  return true
  end
  end

  position:sendMagicEffect(CONST_ME_MAGIC_RED)
  return false
end
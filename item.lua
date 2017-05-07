item = {}
-- Equipment --
item.Weapon = {name = nil, atk = 0, dmg = 0}
function item.Weapon:new(o)
  o = o or {}
  setmetatable(o,self)
  self.__index = self
  return o
end
--
item.Armor = {name = nil, defense = 0}
function item.Armor:new(o)
  o = o or {}
  setmetatable(o,self)
  self.__index = self
  return o
end
-- end Equipment --
--
unarmed = item.Weapon:new()
  unarmed.name = "Unarmed"
  unarmed.atk = 0
  unarmed.dmg = 1
naked = item.Armor:new()
  naked.name = "Naked"
  naked.defense = 0
--
return item
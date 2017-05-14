item = {}
--
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
--
--> Item Library <--
-- Weapons --
unarmed = item.Weapon:new()
  unarmed.name = "Unarmed"
  unarmed.atk = 0
  unarmed.dmg = 1
longsword = item.Weapon:new()
  longsword.name = "Longsword"
  longsword.atk = 1
  longsword.dmg = 3
dirk = item.Weapon:new()
  dirk.name = "Dirk"
  dirk.atk = 1
  dirk.dmg = 2
staff = item.Weapon:new()
  staff.name = "Staff"
  staff.atk = 1
  staff.dmg = 1
bastard_sword = item.Weapon:new()
  bastard_sword.name = "Bastard Sword"
  bastard_sword.atk = 2
  bastard_sword.dmg = 4

-- Armor --
naked = item.Armor:new()
  naked.name = "Naked"
  naked.defense = 0
thief_armor = item.Armor:new()
  thief_armor.name = "Thief's Armor"
  thief_armor.defense = 1
merc_armor = item.Armor:new()
  merc_armor.name = "Mercenary Armor"
  merc_armor.defense = 2
robes = item.Armor:new()
  robes.name = "Robes"
  robes.defense = 0
chainmail = item.Armor:new()
  chainmail.name = "Chainmail Armor"
  chainmail.defense = 3
--
return item

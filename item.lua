item = {}
--
item.Item = {name = nil, value = 0, item_type = "generic item", equipped = false}
function item.Item:new(o)
  o = o or {}
  setmetatable(o,self)
  self.__index = self
  return o
end
--
item.Flask = {name = "Flask", value = 0, max_fill = 1, item_type = "flask"}
  item.Flask.uses = item.Flask.max_fill
function item.Flask:new(o)
  o = o or {}
  setmetatable(o,self)
  self.__index = self
  return o
end
--
item.Weapon = {name = nil, atk = 0, dmg = 0, value = 0, item_type = "weapon", prof_class = 0, equipped = false}
function item.Weapon:new(o)
  o = o or {}
  setmetatable(o,self)
  self.__index = self
  return o
end
--
item.Armor = {name = nil, defense = 0, value = 0, item_type = "armor", prof_class = 0, equipped = false}
function item.Armor:new(o)
  o = o or {}
  setmetatable(o,self)
  self.__index = self
  return o
end
--
item.Trinket = {name = nil, atk = 0, dmg = 0, defense = 0, item_type = "trinket", prof_class = 0, equipped = false}
function item.Trinket:new(o)
  o = o or {}
  setmetatable(o,self)
  self.__index = self
  return o
end
--

--> Item Library <--

-- Items --
s_rock = item.Item:new()
  s_rock.name = "Shiny Rock"
  s_rock.value = 5

-- Weapons --
unarmed = item.Weapon:new()
  unarmed.name = "Unarmed"
  unarmed.atk = 0
  unarmed.dmg = 1
longsword = item.Weapon:new()
  longsword.name = "Longsword"
  longsword.atk = 1
  longsword.dmg = 3
  longsword.value = 10
  longsword.prof_class = 2
dirk = item.Weapon:new()
  dirk.name = "Dirk"
  dirk.atk = 1
  dirk.dmg = 2
  dirk.value = 8
  dirk.prof_class = 1
staff = item.Weapon:new()
  staff.name = "Staff"
  staff.atk = 1
  staff.dmg = 1
  staff.value = 5
bastard_sword = item.Weapon:new()
  bastard_sword.name = "Bastard Sword"
  bastard_sword.atk = 2
  bastard_sword.dmg = 4
  bastard_sword.value = 20

-- Armor --
naked = item.Armor:new()
  naked.name = "Naked"
  naked.defense = 0
thief_armor = item.Armor:new()
  thief_armor.name = "Thief's Armor"
  thief_armor.defense = 1
  thief_armor.value = 10
  thief_armor.prof_class = 1
merc_armor = item.Armor:new()
  merc_armor.name = "Mercenary Armor"
  merc_armor.defense = 2
  merc_armor.value = 12
  merc_armor.prof_class = 2
robes = item.Armor:new()
  robes.name = "Robes"
  robes.defense = 0
  robes.value = 5
chainmail = item.Armor:new()
  chainmail.name = "Chainmail Armor"
  chainmail.defense = 3
  chainmail.value = 25
  chainmail.prof_class = 2

-- Trinkets --
none = item.Trinket:new()
  none.name = "None"

--
return item

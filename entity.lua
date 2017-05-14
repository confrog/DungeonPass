require "item"
--
entity = {}
--
-- Player Object --
entity.Player = {}
  entity.Player.name = "Player"
  entity.Player.level = 1
  entity.Player.xp = 0
  entity.Player.next_lvl = 50 * entity.Player.level
  entity.Player.max_hp = 10
  entity.Player.hp_bonus = 0
  entity.Player.hp = entity.Player.max_hp
  entity.Player.inventory = {coins = 0}
  entity.Player.equipped = {weapon = unarmed, armor = naked}
  entity.Player.atk = entity.Player.equipped.weapon.atk
  entity.Player.dmg = entity.Player.equipped.weapon.dmg
  entity.Player.defense = 10 + entity.Player.equipped.armor.defense
  entity.Player.atk_circ = {circ = nil, duration = 0}
function entity.Player:new(o)
  o = o or {}
  setmetatable(o,self)
  self.__index = self
  return o
end
function entity.Player:gain_hp(n)
  self.hp = self.hp + n
  if self.hp > self.max_hp then self.hp = self.max_hp end
end
function entity.Player:lose_hp(n)
  self.hp = self.hp - n
end
function entity.Player:equip_update()
  self.atk = self.equipped.weapon.atk
  self.dmg = self.equipped.weapon.dmg
  self.defense = 10 + self.equipped.armor.defense
end
function entity.Player:level_up()
  if self.xp >= self.next_lvl then
    self.xp = self.xp - self.next_lvl
    self.level = self.level + 1
    self.max_hp = self.max_hp + self.hp_bonus + 5
    self.hp = self.max_hp
    return true
  else
    return false
  end
end
-- Warrior --
entity.Warrior = entity.Player:new()
  entity.Warrior.max_hp = 12
  entity.Warrior.hp = entity.Warrior.max_hp
  entity.Warrior.hp_bonus = 2
  entity.Warrior.inventory = {longsword,merc_armor, coins = 0}
  entity.Warrior.equipped = {weapon = longsword, armor = merc_armor}
  entity.Warrior.abilities = {lvl1 = power_atk, lvl3 = second_wind}
function entity.Warrior:new(o)
  o = o or {}
  setmetatable(o,self)
  self.__index = self
  return o
end
--
entity.Thief = entity.Player:new()
  entity.Thief.max_hp = 10
  entity.Thief.hp_bonus = 1
  entity.Thief.hp = entity.Thief.max_hp
  entity.Thief.inventory = {dirk,thief_armor, coins = 0}
  entity.Thief.equipped = {weapon = dirk, armor = thief_armor}
  entity.Thief.abilities = {}
function entity.Thief:new(o)
  o = o or {}
  setmetatable(o,self)
  self.__index = self
  return o
end
--
entity.Mage = entity.Player:new()
  entity.Mage.max_hp = 8
  entity.Mage.hp = entity.Mage.max_hp
  entity.Mage.inventory = {staff,robes, coins = 0}
  entity.Mage.equipped = {weapon = staff, armor = robes}
  entity.Mage.abilities = {}
function entity.Mage:new(o)
  o = o or {}
  setmetatable(o,self)
  self.__index = self
  return o
end
--
entity.Monster = {}
  entity.Monster.name = nil
  entity.Monster.max_hp = 10
  entity.Monster.hp = entity.Monster.max_hp
  entity.Monster.loot = {}
  entity.Monster.atk = 0
  entity.Monster.dmg = 0
  entity.Monster.defense = 10
  entity.Monster.xp_value = 0
  entity.Monster.atk_circ = {circ = nil, duration = 0}
function entity.Monster:new(o)
  o = o or {}
  setmetatable(o,self)
  self.__index = self
  return o
end
function entity.Monster:monster_update()
  self.hp = self.max_hp
end
function entity.Monster:gain_hp(n)
  self.hp = self.hp + n
  if self.hp > self.max_hp then self.hp = self.max_hp end
end
function entity.Monster:lose_hp(n)
  self.hp = self.hp - n
end
--
return entity

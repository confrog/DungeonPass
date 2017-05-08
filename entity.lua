require "item"
entity = {}
--
entity.Player = {}
  entity.Player.name = "Player"
  entity.Player.max_hp = 10
  entity.Player.hp = entity.Player.max_hp
  entity.Player.inventory = {coins = 0}
  entity.Player.equipped = {weapon = unarmed, armor = naked}
  entity.Player.atk = entity.Player.equipped.weapon.atk
  entity.Player.dmg = entity.Player.equipped.weapon.dmg
  entity.Player.defense = 10 + entity.Player.equipped.armor.defense
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
--
entity.Monster = {}
  entity.Monster.name = nil
  entity.Monster.max_hp = 10
  entity.Monster.hp = entity.Monster.max_hp
  entity.Monster.loot = {}
  entity.Monster.atk = 0
  entity.Monster.dmg = 0
  entity.Monster.defense = 10
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

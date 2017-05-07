require "item"
entity = {}
--
entity.Entity = {}
  entity.Entity.name = nil
  entity.Entity.max_hp = 10
  entity.Entity.hp = entity.Entity.max_hp
  entity.Entity.inventory = {}
  entity.Entity.equipped = {weapon = unarmed, armor = naked}
  entity.Entity.atk = entity.Entity.equipped.weapon.atk
  entity.Entity.dmg = entity.Entity.equipped.weapon.dmg
  entity.Entity.defense = 10 + entity.Entity.equipped.armor.defense
function entity.Entity:new(o)
  o = o or {}
  setmetatable(o,self)
  self.__index = self
  return o
end
function entity.Entity:gain_hp(n)
  self.hp = self.hp + n
  if self.hp > self.max_hp then self.hp = self.max_hp end
end
function entity.Entity:lose_hp(n)
  self.hp = self.hp - n
end
function entity.Entity:equip_update()
  self.atk = self.equipped.weapon.atk
  self.dmg = self.equipped.weapon.dmg
  self.defense = 10 + self.equipped.armor.defense
end
--
return entity
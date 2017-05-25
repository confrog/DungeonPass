require "item"
require "abilities"
--
entity = {}
--
-- Player Object --
entity.Player = {}
  entity.Player.name = "Player"
  entity.Player.class = "None"
  entity.Player.level = 1
  entity.Player.xp = 0
  entity.Player.next_lvl = 50 * entity.Player.level
  entity.Player.max_hp = 10
  entity.Player.hp_bonus = 0
  entity.Player.hp = entity.Player.max_hp
  entity.Player.inventory = {coins = 0}
  entity.Player.equipped = {weapon = unarmed, armor = naked, trinket = nil}
  entity.Player.atk = entity.Player.equipped.weapon.atk
  entity.Player.dmg = entity.Player.equipped.weapon.dmg
  entity.Player.defense = 10 + entity.Player.equipped.armor.defense
  entity.Player.atk_circ = {circ = nil, duration = 0}
  entity.Player.status = "alive"
  entity.Player.fled = false
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
function entity.Player:equip_item(item)  
  if item.item_type == "weapon" then
    self.equipped.weapon.equipped = false
    self.equipped.weapon = item
    item.equipped = true
    ui:message(item.name.." equipped")
  elseif item.item_type == "armor" then
    self.equipped.armor.equipped = false
    self.equipped.armor = item
    item.equipped = true
    ui:message(item.name.." equipped")
  elseif item.item_type == "trinket" then
    self.equipped.trinket.equipped = false
    self.equipped.trinket = item
    item.equipped = true
    ui:message(item.name.." equipped")
  else
    ui:message("This item cannot be equipped.")
  end
  utility.sleep(2)
end
function entity.Player:level_up()
  if self.xp >= self.next_lvl then
    self.xp = self.xp - self.next_lvl
    self.level = self.level + 1
    self.max_hp = self.max_hp + self.hp_bonus + 5
    self.hp = self.max_hp
    if self.class == "Warrior" then
      if self.level == 3 then
        table.insert(self.abilities, second_wind)
      elseif self.level == 6 then
        --write lvl 6 ability
      elseif self.level == 9 then
        --write lvl 9 ability
      end
    elseif self.class == "Thief" then
      if self.level == 3 then
        -- write lvl 3 ability
      elseif self.level == 6 then
        --write lvl 6 ability
      elseif self.level == 9 then
        --write lvl 9 ability
      end
    elseif self.class == "Mage" then
      if self.level == 3 then
        -- write lvl 3 ability
      elseif self.level == 6 then
        --write lvl 6 ability
      elseif self.level == 9 then
        --write lvl 9 ability
      end
    end
    return true
  else
    return false
  end
end
-- Warrior --
entity.Warrior = entity.Player:new()
  entity.Warrior.class = "Warrior"
  entity.Warrior.max_hp = 12
  entity.Warrior.hp = entity.Warrior.max_hp
  entity.Warrior.hp_bonus = 2
  entity.Warrior.inventory = {longsword, merc_armor, coins = 0}
  entity.Warrior.equipped = {weapon = longsword, armor = merc_armor, trinket = nil}
  entity.Warrior.abilities = {power_atk, second_wind}
  entity.Warrior.equipped.weapon.equipped = true
  entity.Warrior.equipped.armor.equipped = true
function entity.Warrior:new(o)
  o = o or {}
  setmetatable(o,self)
  self.__index = self
  return o
end
--
entity.Thief = entity.Player:new()
  entity.Thief.class = "Thief"
  entity.Thief.max_hp = 10
  entity.Thief.hp_bonus = 1
  entity.Thief.hp = entity.Thief.max_hp
  entity.Thief.inventory = {dirk, thief_armor, coins = 0}
  entity.Thief.equipped = {weapon = dirk, armor = thief_armor, trinket = nil}
  entity.Thief.abilities = {}
  entity.Thief.equipped.weapon.equipped = true
  entity.Thief.equipped.armor.equipped = true
function entity.Thief:new(o)
  o = o or {}
  setmetatable(o,self)
  self.__index = self
  return o
end
--
entity.Mage = entity.Player:new()
  entity.Mage.class = "Mage"
  entity.Mage.max_hp = 8
  entity.Mage.hp = entity.Mage.max_hp
  entity.Mage.inventory = {staff, robes, coins = 0}
  entity.Mage.equipped = {weapon = staff, armor = robes, trinket = nil}
  entity.Mage.abilities = {}
  entity.Mage.equipped.weapon.equipped = true
  entity.Mage.equipped.armor.equipped = true
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
  entity.Monster.fled = false
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

function p_input()
  io.write(">>> ")
  input_value = tostring(io.read())
  return input_value
end
--
function d20_roll(circ)
  if circ == "+" then
    math.randomseed(os.time())
    roll1 = math.random(20)
    math.randomseed(os.time()^2)
    roll2 = math.random(20)
    roll_f = math.max(roll1,roll2)
    return roll_f
  elseif circ == "-" then
    math.randomseed(os.time()^3)
    roll1 = math.random(20)
    math.randomseed(os.time()^4)
    roll2 = math.random(20)
    roll_f = math.min(roll1,roll2)
    return roll_f
  else
    math.randomseed(os.time()^5)
    roll_f = math.random(20)
    return roll_f
  end
end
--
function attack(attacker, target, circ)
  roll_base = d20_roll(circ)
  atk_roll = roll_base + attacker.atk
  if roll_base == 20 then
    target:lose_hp(attacker.dmg*2)
    print("critical hit: "..(attacker.dmg*2).." damage")
  elseif atk_roll >= target.defense then
    target:lose_hp(attacker.dmg)
    print("roll: "..atk_roll.."\nhit: "..attacker.dmg.." damage")
  else
    print("miss: "..atk_roll)
  end
end
--
table_1 = {}
table_1.r2c = "return to camp"
-- Equipment --
Weapon = {name = nil, atk = 0, dmg = 0}
function Weapon:new(o)
  o = o or {}
  setmetatable(o,self)
  self.__index = self
  return o
end
--
Armor = {name = nil, defense = 0}
function Armor:new(o)
  o = o or {}
  setmetatable(o,self)
  self.__index = self
  return o
end
--
unarmed = Weapon:new()
  unarmed.name = "Unarmed"
  unarmed.atk = 0
  unarmed.dmg = 1
naked = Armor:new()
  naked.name = "Naked"
  naked.defense = 0
--
Entity = {}
  Entity.max_hp = 10
  Entity.hp = Entity.max_hp
  Entity.inventory = {}
  Entity.equipped = {weapon = unarmed, armor = naked}
  Entity.atk = Entity.equipped.weapon.atk
  Entity.dmg = Entity.equipped.weapon.dmg
  Entity.defense = 10 + Entity.equipped.armor.defense
function Entity:new(o)
  o = o or {}
  setmetatable(o,self)
  self.__index = self
  return o
end
function Entity:gain_hp(n)
  self.hp = self.hp + n
  if self.hp > self.max_hp then self.hp = self.max_hp end
end
function Entity:lose_hp(n)
  self.hp = self.hp - n
  if self.hp <= 0 then return "is_dead" end
end
function Entity:equip_update()
  self.atk = self.equipped.weapon.atk
  self.dmg = self.equipped.weapon.dmg
  self.defense = 10 + self.equipped.armor.defense
end
--
--
--
gerblin_sword = Weapon:new()
  gerblin_sword.name = "Gerblin Sword"
  gerblin_sword.atk = 1
  gerblin_sword.dmg = 2
gerblin_rags = Armor:new()
  gerblin_rags.name = "Gerblin Rags"
  gerblin_rags.defense = 1

gerblin = Entity:new()
gerblin.inventory[1] = gerblin_sword
gerblin.inventory[2] = gerblin_rags
gerblin.equipped.weapon = gerblin.inventory[1]
gerblin.equipped.armor = gerblin.inventory[2]
gerblin:equip_update()


slime = Entity:new()
attack(gerblin,slime,nil)

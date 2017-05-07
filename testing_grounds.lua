function p_input()
  io.write(">>> ")
  input_value = tostring(io.read())
  return input_value
end
--
require "entity"
require "item"
require "combat"
--
--
--
gerblin_sword = item.Weapon:new()
  gerblin_sword.name = "Gerblin Sword"
  gerblin_sword.atk = 1
  gerblin_sword.dmg = 2
gerblin_rags = item.Armor:new()
  gerblin_rags.name = "Gerblin Rags"
  gerblin_rags.defense = 1

gerblin = entity.Entity:new()
gerblin.name = "Gerblin"
gerblin.inventory[1] = gerblin_sword
gerblin.inventory[2] = gerblin_rags
gerblin.equipped.weapon = gerblin.inventory[1]
gerblin.equipped.armor = gerblin.inventory[2]
gerblin:equip_update()

slime = entity.Entity:new()
slime.name = "Slime"

combat.fight(gerblin,slime)

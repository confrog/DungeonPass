function p_input()
  io.write(">>> ")
  input_value = tostring(io.read())
  return input_value
end
--
require "entity"
require "item"
require "combat"
require "tile"
--
--
longsword = item.Weapon:new()
  longsword.name = "Longsword"
  longsword.atk = 1
  longsword.dmg = 3
chainmail = item.Armor:new()
  chainmail.name = "Chainmail Armor"
  chainmail.defense = 3

player = entity.Entity:new()
  player.name = "Player"
  player.inventory[1] = longsword
  player.inventory[2] = chainmail
  player.equipped.weapon = player.inventory[1]
  player.equipped.armor = player.inventory[2]
  player:equip_update()
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

test_room = tile.CombatTile:new()
  test_room.monster = gerblin
  test_room.name = "Test Chamber"
  test_room.room_desc = "\tA blank room"
  test_room.is_complete = false
  test_room.rspwn_chance = 50

test_room:enter_tile(player)

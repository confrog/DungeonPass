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
bastard_sword = item.Weapon:new()
  bastard_sword.name = "Bastard Sword"
  bastard_sword.atk = 2
  bastard_sword.dmg = 4

player = entity.Player:new()
  player.inventory[1] = longsword
  player.inventory[2] = chainmail
  player.equipped.weapon = player.inventory[1]
  player.equipped.armor = player.inventory[2]
  player:equip_update()
--
gerblin = entity.Monster:new()
  gerblin.name = "Gerblin"
  gerblin.max_hp = 8
  gerblin.atk = 1
  gerblin.dmg = 2
  gerblin.defense = 11
  gerblin.loot = {bastard_sword, coins = 5}
  gerblin:monster_update()

test_room = tile.CombatTile:new()
  test_room.monster = gerblin
  test_room.name = "Test Chamber"
  test_room.room_desc = "\tA blank room"
  test_room.is_complete = false
  test_room.rspwn_chance = 50

test_room:enter_tile(player)
print ("Inventory:")
for k,v in pairs(player.inventory) do
  if k == "coins" then
    print (v.." coins")
  else
    print(v.name)
  end
end

function p_input()
  io.write(">>> ")
  input_value = tostring(io.read())
  return input_value
end
--
require "choices"
require "abilities"
require "entity"
require "item"
require "combat"
require "tile"
--
--
function set_lvl (player, level)
  level_add = level - player.level
  for i=1,level_add do
    player.xp = player.next_level
    player:level_up()
  end
end
--
player = entity.Warrior:new()
  player:equip_update()
--
gerblin = entity.Monster:new()
  gerblin.name = "Gerblin"
  gerblin.max_hp = 8
  gerblin.atk = 1
  gerblin.dmg = 2
  gerblin.defense = 11
  gerblin.loot = {bastard_sword, coins = 5}
  gerblin.xp_value = 50
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

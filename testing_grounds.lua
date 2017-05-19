require "ui"
require "choices"
require "abilities"
require "entity"
require "item"
require "combat"
require "tile"
require "camp"
require "game_engine"


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
  gerblin.loot = {coins = 5}
  gerblin.xp_value = 5
  gerblin:monster_update()

test_room = tile.CombatTile:new()
  test_room.monster = gerblin
  test_room.name = "Test Chamber"
  test_room.tile_desc = "A blank room"
  test_room.is_complete = false
  test_room.rspwn_chance = 50
  test_room.tile_id = "101"

tile_table = {camp.Camp,test_room}
game_loop(tile_table)
require "ui"
require "utility"
require "choices"
require "abilities"
require "entity"
require "item"
require "combat"
require "tile"
require "camp"
require "game_engine"
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
  test_room.tile_code = "101"
  test_room.next_code = "102"

test_room2 = tile.ExploreTile:new()
  test_room2.name = "Exploration Test Chamber"
  test_room2.tile_desc = "A blank room with a wooden door on the far wall."
  test_room2.option_text = {"Cross the room and open the door","Sit in the middle of the room"}
  local function option1(player)
    ui:message("You cross the room and pull the door open: behind the door is a yawning black void.")
    return true
  end
  local function option2(player)
    ui:message("You sit in the middle of the room, waiting for something to happen. A small rock falls from the ceiling and lands on your head. Ouch! You take 1 damage.")
    player.hp = player.hp - 1
    test_room2:load_tile(player)
  end
  test_room2.option_action = {option1, option2}
  test_room2.tile_code = "102"
  

tile_table = {camp.Camp,test_room,test_room2}
game_loop(tile_table)
---------------------------------
-- Tile IDs --
--> 000 - Error
--> 001 - In Camp
--> 002 - In Graveyard
--> 10X - In Caves: Tile X
--> 20X - In Dungeon: Tile X
--> 30X - In Castle: Tile X
--> 40X - In Tower: Tile X
--> 50X - In Mausoleum: Tile X
--> 60X - In Crypts: Tile X
---------------------------------

function game_start()
  player = nil
  choices.choose(
    "Choose your class",
    choices.options(
      "Mage",
      function()
        player = entity.Mage:new()
      end,
      "Thief",
      function()
        player = entity.Thief:new()
      end,
      "Warrior",
      function()
        player = entity.Warrior:new()
      end))
  if player == nil then
    ui:message("Error")
  end
  player:equip_update()
  return player
end
--
function tile_loader (tile_id,tile_table, player)
  for k,v in ipairs(tile_table) do
    if v.tile_code == tile_id then
      next_id = v:load_tile(player)
      return next_id
    end
  end
end
--
function game_loop (tile_table)
  player = game_start()
  tile_id = "001"
  while true do
    next_id = tile_loader(tile_id,tile_table,player)
    tile_id = next_id
  end
end
--

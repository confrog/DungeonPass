require "ui"

tile = {}
-- Combat Tile --
tile.CombatTile = {}
  tile.CombatTile.monster = nil;
  tile.CombatTile.name = "A Fighting Room";
  tile.CombatTile.tile_desc = "None";
  tile.CombatTile.is_complete = false;
  tile.CombatTile.rspwn_chance = 0
  tile.CombatTile.tile_id = "000"
  tile.CombatTile.next_id = "000"
function tile.CombatTile:new(o)
  o = o or {}
  setmetatable(o,self)
  self.__index = self
  return o
end
function tile.CombatTile:load_tile(player)
  ui:message(self.name)
  ui:message(self.tile_desc)
  if self.is_complete == false then
    self.is_complete = combat.fight(player, self.monster)
  else
    r = random.new(12345)
    r:seed(os.time())
    if r:value(1,100) <= self.rspwn_chance then
      ui:message("Another "..self.monster.name.." appeared!")
      combat.fight(player, self.monster)
    else
      ui:message("The room is empty")
    end
  end
  next_tile = choices.choose(
    "What do you want to do?",
    choices.options(
      "Continue forward",
      function()
        return tile.CombatTile.next_id
      end,
      "Return to camp",
      function()
        return "001"
      end))
  return next_tile
end
-- Exploration Tile --
tile.ExploreTile = {}
  tile.ExploreTile.name = "An Exploration Room"
  tile.ExploreTile.tile_desc = "None"
  tile.ExploreTile.option_text = {}
  tile.ExploreTile.option_action = {}
  tile.ExploreTile.key = nil
  tile.ExploreTile.is_complete = false
  tile.ExploreTile.tile_id = "000"
  tile.ExploreTile.next_id = "000"
--
return tile
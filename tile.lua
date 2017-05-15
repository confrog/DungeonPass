require('ui')

tile = {}
--
tile.CombatTile = {}
  tile.CombatTile.monster = nil;
  tile.CombatTile.name = "A Fighting Room";
  tile.CombatTile.room_desc = "None";
  tile.CombatTile.is_complete = false;
  tile.CombatTile.rspwn_chance = 0
function tile.CombatTile:new(o)
  o = o or {}
  setmetatable(o,self)
  self.__index = self
  return o
end
function tile.CombatTile:enter_tile(player)
  ui:message(self.name)
  ui:message(self.room_desc)
  if self.is_complete == false then
    combat.fight(player, self.monster)
  else
    math.randomseed(os.time()) --> create respawn chance function and value for combat tiles
    if math.random(100) <= self.rspwn_chance then
      combat.fight(player, self.monster)
    else
      ui:message("The room is empty")
    end
  end
end

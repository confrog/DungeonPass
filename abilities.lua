require "ui"

abilities = {}
--
-- Ability Object --
abilities.Ability = {}
  abilities.Ability.name = nil
  abilities.Ability.cd = 0
  abilities.Ability.cd_count = 0
function abilities.Ability:new(o)
  o = o or {}
  setmetatable(o,self)
  self.__index = self
  return o
end
-- Warrior Abilities --
power_atk = abilities.Ability:new()
  power_atk.name = "Power Attack"
  power_atk.cd = 3
function power_atk:ability (player,target)
  base_roll = roll.d20_roll()
  atk_roll = base_roll + player.atk
  abil_dmg = player.equipped.weapon.dmg + player.level
  if self.cd_count > 0 then
    ui:message("This ability is on cooldown. It can be used in "..self.cd_count.." turns")
    combat.player_turn (player, target)
  else
    if base_roll == 20 then
      target.hp = target.hp - 2*abil_dmg
      ui:message("Critical hit! You deal "..(2*abil_dmg).." damage.")
    elseif atk_roll >= target.defense then
      target.hp = target.hp - abil_dmg
      ui:message("Roll: "..atk_roll.."\nHit! You deal "..abil_dmg.." damage.")
    else
      ui:message("Roll: "..atk_roll.."\nMiss...")
    end
    ui:message("The power behind your swing throws you off balance as you follow through.")
    target.atk_circ.circ = "+"
    target.atk_circ.duration = 1
    self.cd_count = self.cd
  end
end
--
second_wind = abilities.Ability:new()
  second_wind.name = "Second Wind"
  second_wind.cd = math.huge
function second_wind:ability (player, target)
  r = random.new(12345)
  r:seed(os.time())
  if self.cd_count > 0 then
    ui:message("This ability is on cooldown. It cannot be used again in this combat.")
    combat.player_turn (player, target)
  else
    heal_amt = r:value(1,10) + player.level
    player.hp = player.hp + heal_amt
    if player.hp > player.max_hp then
      player.hp = player.max_hp
    end
    ui:message("You take a moment to breath and regain your focus, watching your opponent's every move. You regain "..heal_amt.." hit points.")
    self.cd_count = self.cd
  end
end
--
--
return abilities

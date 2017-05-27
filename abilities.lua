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
--> level 1
power_atk = abilities.Ability:new()
  power_atk.name = "Power Attack"
  power_atk.cd = 3
function power_atk:ability (player,target)
  base_roll = roll.d20_roll(player.atk_circ.circ)
  atk_roll = base_roll + player.atk
  abil_dmg = player.equipped.weapon.dmg + player.equipped.trinket.dmg + player.level
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
--> level 3
second_wind = abilities.Ability:new()
  second_wind.name = "Second Wind"
  second_wind.cd = math.huge
function second_wind:ability (player)
  if self.cd_count > 0 then
    ui:message("This ability is on cooldown. It cannot be used again in this combat.")
    combat.player_turn (player, target)
  else
    heal_amt = roll.basic_roll(10) + player.level
    player.hp = player.hp + heal_amt
    if player.hp > player.max_hp then
      player.hp = player.max_hp
      ui:message("You take a moment to breath and regain your focus, watching your opponent's every move. You regain "..heal_amt.." hit points.")
      self.cd_count = self.cd
    end
  end
end
--> level 6
disruptive_strike = abilities.Ability:new()
  disruptive_strike.name = "Disruptive Strike"
  disruptive_strike.cd = 5
function disruptive_strike:ability(player,target)
  base_roll = d20_roll(player.atk_circ.circ)
  atk_roll = base_roll + player.atk
  if self.cd_count > 0 then
    ui:message("This ability is on cooldown. It can be used in "..self.cd_count.." turns")
    combat.player_turn (player, target)
  else
    if base_roll == 20 then
      target.hp = target.hp - 2*player.dmg
      ui:message("Critical hit! You deal "..(2*player.dmg).." damage.")
    elseif atk_roll >= target.defense then
      target.hp = target.hp - player.dmg
      ui:message("Roll: "..atk_roll.."\nHit! You rush forward and strike, surprising the "..target.name.." and throwing it off-balance. You deal "..player.dmg.." damage.")
      target.atk_circ.circ = "-"
    target.atk_circ.duration = 1
    else
      ui:message("Roll: "..atk_roll.."\nMiss...")
    end
    self.cd_count = self.cd
  end
end
--> level 9

-- Thief Abilities --
--> level 1
feint = abilities.Ability:new()
  feint.name = "Feint"
  feint.cd = 3
function feint:ability(player,target)
  base_roll = roll.d20_roll("-")
  atk_roll = base_roll + player.atk
  if self.cd_count > 0 then
    ui:message("This ability is on cooldown. It can be used in "..self.cd_count.." turns")
    combat.player_turn (player, target)
  else
    if base_roll == 20 then
      target.hp = target.hp - 2*player.dmg
      ui:message("Critical hit! You deal "..(2*player.dmg).." damage.")
    elseif atk_roll >= target.defense then
      target.hp = target.hp - player.dmg
      ui:message("Roll: "..atk_roll.."\nHit! You deal "..player.dmg.." damage.")
    else
      ui:message("Roll: "..atk_roll.."\nMiss...")
    end
    ui:message("You dart forward with a flurry of feints, leaving your opponent open for your next attack.")
    player.atk_circ.circ = "+"
    target.atk_circ.duration = 2
    self.cd_count = self.cd
  end
end
--> level 3

--> level 6

--> level 9

-- Mage Abilities --
--> level 1
arcane_bolt = abilities.Ability:new()
  arcane_bolt.name = "Arcane Bolt"
  arcane_bolt.cd = 3
function arcane_bolt:ability(player,target)
  base_roll = roll.d20_roll(player.atk_circ.circ)
  atk_roll = base_roll + player.level
  abil_dmg = 2 + 2*player.level + player.equipped.trinket.dmg
  if self.cd_count > 0 then
    ui:message("This ability is on cooldown. It can be used in "..self.cd_count.." turns")
    combat.player_turn (player, target)
  else
    ui:message("You summon a bolt of arcane energy and hurl it at your enemy")
    if base_roll == 20 then
      target.hp = target.hp - 2*abil_dmg
      ui:message("Critical hit! You deal "..(2*abil_dmg).." damage.")
    elseif atk_roll >= target.defense then
      target.hp = target.hp - abil_dmg
      ui:message("Roll: "..atk_roll.."\nHit! You deal "..abil_dmg.." damage.")
    else
      ui:message("Roll: "..atk_roll.."\nMiss...")
    end
    self.cd_count = self.cd
  end
end
--> level 3

--> level 6

--> level 9
--
return abilities
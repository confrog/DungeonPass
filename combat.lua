require "ui"
require "roll"

combat = {}
--
function combat.attack(attacker, target, circ)
  roll_base = roll.d20_roll(circ)
  atk_roll = roll_base + attacker.atk
  if roll_base == 20 then
    target:lose_hp(attacker.dmg*2)
    ui:message("critical hit: "..(attacker.dmg*2).." damage")
  elseif atk_roll >= target.defense then
    target:lose_hp(attacker.dmg)
    ui:message("roll: "..atk_roll.."\nhit: "..attacker.dmg.." damage")
  else
    ui:message("miss: "..atk_roll)
  end
end
--
function combat.player_turn (player,monster)
  ui:message ("Hit Points: "..player.hp.."/"..player.max_hp)
  choices.choose(
    "It's your turn! What do you do?",
    choices.options(
      'Fight',
      function()
        choices.choose(
          "How do you want to fight?",
          choices.options(
            'Use a basic attack',
            function()
              combat.attack(player, monster)
            end,
            "Use an ability",
            function()
              choices.choose(
                "Which ability do you want to use?",
                choices.iterFunc_abil(player.abilities, player, monster)) 
            end))
        end,
      'Flee',
      function()
        ui:message("You flee from combat")
        player.fled = true
      end))
end
--
function combat.post_fight (player, monster, fight_res)
  player.atk_circ.circ = nil
  player.atk_circ.duration = 0
  for k,v in ipairs(player.abilities) do
    v.cd_count = 0
  end
  if fight_res == "monster dead" then
    ui:message("The "..monster.name.." died!")
    player.xp = player.xp + monster.xp_value
    ui:message("You gained "..monster.xp_value.." experience!")
    lvl_up = player:level_up()
    if lvl_up == true then
      ui:message ("You levelled up! You are now level "..player.level..".")
    end
    if monster.loot == nil then
        ui:message("The "..monster.name.." dropped no loot.")
    else
      ui:message("The "..monster.name.." dropped:")
      for k,v in pairs(monster.loot) do
        if k == "coins" then
          ui:message (" > "..v.." coins")
          player.inventory.coins = player.inventory.coins + v
        else
          ui:message(" > "..v.name)
          table.insert(player.inventory, v)
        end
      end
      return true
    end
  elseif fight_res == "monster fled" then
    ui:message("The "..monster.name.." flees from you!")
    player.xp = player.xp + monster.xp_value
    ui:message("You gained "..monster.xp_value.." experience!")
    lvl_up = player:level_up()
    if lvl_up == true then
      ui:message ("You levelled up! You are now level "..player.level..".")
    end
  elseif fight_res == "player dead" then
    ui:message("The "..monster.name.." strikes you down!")
    player.status = "unconscious"
    return false
  elseif fight_res == "player fled" then
    return false
  else
    ui:message("ERROR")
  end
end
--
function combat.turn_resolve(target1, target2)
  target1.atk_circ.duration = target1.atk_circ.duration - 1
    if target1.atk_circ.duration <= 0 then
      target1.atk_circ.circ = nil
    end
  if target1.name == "Player" then
    for k,v in pairs(target1.abilities) do
      if v.cd_count > 0 then
        v.cd_count = v.cd_count - 1
      end
    end
  end
  if target1.fled == true then
    if target1.name == "Player"then
      fight_res = "player fled"
      return true, fight_res
    else
      fight_res = "monster fled"
      return true,fight_res
    end
  elseif target2.hp <= 0 then
    if target2.name == "Player" then
      fight_res = "player dead"
      return true, fight_res
    else
      fight_res = "monster dead"
      return true, fight_res
    end
  end
end
--
function combat.fight(player, monster)
  player_init = roll.d20_roll()
  monster_init = roll.d20_roll()
  fight_res = nil
  if math.max(player_init, monster_init) == player_init then
    init_order = {player, monster}
  else
    init_order = {monster, player}
  end
  while true do
    ui:message(init_order[1].name.."'s turn")
    if init_order[1] == player then
      combat.player_turn(player,monster, player.atk_circ.circ)
    else
    combat.attack(init_order[1], init_order[2], init_order[1].atk_circ.circ)
    end
    end_combat, fight_res = combat.turn_resolve(init_order[1],init_order[2])
    if end_combat == true then
      break
    end
    ui:message("-------------------")
    utility.sleep(1)
    ui:message(init_order[2].name.."'s turn")
    if init_order[2] == player then
      combat.player_turn(player,monster, player.atk_circ.circ)
    else
    combat.attack(init_order[2], init_order[1], init_order[2].atk_circ.circ)
    end
    end_combat,fight_res = combat.turn_resolve(init_order[2],init_order[1])
    if end_combat == true then
      break
    end
    ui:message("-------------------")
    utility.sleep(1)
  end
  return combat.post_fight(player,monster,fight_res)
end
--
return combat

combat = {}
--
function combat.sleep(s)
  local ntime = os.clock() + s
  repeat until os.clock() > ntime
end
--
function combat.d20_roll(circ)
  if circ == "+" then
    math.randomseed(os.time())
    roll1 = math.random(20)
    math.randomseed(os.time()^2)
    roll2 = math.random(20)
    roll_f = math.max(roll1,roll2)
    return roll_f
  elseif circ == "-" then
    math.randomseed(os.time()^3)
    roll1 = math.random(20)
    math.randomseed(os.time()^4)
    roll2 = math.random(20)
    roll_f = math.min(roll1,roll2)
    return roll_f
  else
    math.randomseed(os.time()^5)
    roll_f = math.random(20)
    return roll_f
  end
end
--
function combat.attack(attacker, target, circ)
  roll_base = combat.d20_roll(circ)
  atk_roll = roll_base + attacker.atk
  if roll_base == 20 then
    target:lose_hp(attacker.dmg*2)
    print("critical hit: "..(attacker.dmg*2).." damage")
  elseif atk_roll >= target.defense then
    target:lose_hp(attacker.dmg)
    print("roll: "..atk_roll.."\nhit: "..attacker.dmg.." damage")
  else
    print("miss: "..atk_roll)
  end
end
--
function combat.fight(player, monster)
  player_init = combat.d20_roll()
  monster_init = combat.d20_roll()
  if math.max(player_init, monster_init) == player_init then
    init_order = {player, monster}
  else
    init_order = {monster, player}
  end
  while true do
    print(init_order[1].name.."'s turn")
    combat.attack(init_order[1], init_order[2])
    if init_order[2].hp <= 0 then
      print(init_order[2].name.." is dead")
      break
    end
    io.write("-------------------")
    io.read()
    combat.sleep(.25)
    print(init_order[2].name.."'s turn")
    combat.attack(init_order[2],init_order[1])
    if init_order[1].hp <= 0 then
      print(init_order[1].name.." is dead")
      break
    end
  
    io.write("-------------------")
    io.read()
    combat.sleep(.25)
  end
end
--
return combat
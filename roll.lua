roll = {}
--
function roll.d20_roll(circ)
  if circ == "+" then
    math.randomseed(os.time())
    roll1 = math.random(1,20)
    math.randomseed(os.time()^2)
    roll2 = math.random(1,20)
    roll_f = math.max(roll1,roll2)
    return roll_f
  elseif circ == "-" then
    math.randomseed(os.time())
    roll1 = math.random(1,20)
    math.randomseed(os.time()^2)
    roll2 = math.random(1,20)
    roll_f = math.min(roll1,roll2)
    return roll_f
  else
    math.randomseed(os.time())
    roll_f = math.random(1,20)
    return roll_f
  end
end
--
function roll.basic_roll(dice_size)
  math.randomseed(os.time())
  roll_f = math.random(1,dice_size)
  return roll_f
end
--
return roll
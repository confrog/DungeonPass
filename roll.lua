require "random"
roll = {}
--
function roll.d20_roll(circ)
  r = random.new(12345)
  if circ == "+" then
    r:seed(os.time())
    roll1 = r:value(1,20)
    r:seed(os.time()^2)
    roll2 = r:value(1,20)
    roll_f = math.max(roll1,roll2)
    return roll_f
  elseif circ == "-" then
    r:seed(os.time())
    roll1 = r:value(1,20)
    r:seed(os.time()^2)
    roll2 = r:value(1,20)
    roll_f = math.min(roll1,roll2)
    return roll_f
  else
    r:seed(os.time())
    roll_f = r:value(1,20)
    return roll_f
  end
end
--
return roll
utility = {}
--
function utility.sleep(s)
  local ntime = os.clock() + s
  repeat until os.clock() > ntime
end
--
function utility.arrayLen (array)
  local lengthNum = 0
  for k, v in pairs(array) do
   lengthNum = lengthNum + 1
  end
return lengthNum
end
--
return utility
require "item"
camp = {}
-- Merchant --
camp.Merchant = {}
  camp.Merchant.inventory = {bastard_sword, chainmail, s_rock} -- fill in item inventory
function camp.Merchant:visit_merchant(player)
  ui:message("As you approach the merchant's wagon, he greets you:\"Well met, Adventurer. What can I help you with today?\"")
  camp.Merchant:at_merchant(player)
end
function camp.Merchant:at_merchant(player)
  choices.choose(
    "What would you like to do?",
    choices.options(
      "Buy",
      function()
        camp.Merchant:buy(player)
      end,
      "Sell",
      function()
        camp.Merchant:sell(player)
      end,
      "Talk to the merchant",
      function()
        camp.Merchant:dialogue(player)
      end,
      "Return to the center of camp",
      function()
        camp.Camp:in_camp(player)
      end))
end
function camp.Merchant:buy(player)
  n = 0
  ui:message(" > Merchant's Inventory <")
  for k,v in ipairs(self.inventory) do
    n = n + 1
    if v.item_type == "weapon" then
      ui:message(k.." > "..v.name.."\tvalue: "..v.value.." coins\tattack: "..v.atk.."\tdamage: "..v.dmg)
    elseif v.item_type == "armor" then
      ui:message(k.." > "..v.name.."\tvalue: "..v.value.." coins\tdefense: "..v.defense)
    elseif v.item_type == "generic item" then
      ui:message(k.." > "..v.name.."\tvalue: "..v.value.." coins")
    end
  end
  ui:message((n+1).." > Back")
  ui:message("What would you like to buy?")
  input = tonumber(ui:formatPrompt('*n', "Enter a number (1-"..(n+1).."):\n\n"))
  if input == n+1 then
    camp.Merchant:at_merchant(player)
  elseif input <= n then
    choices.choose(
      "Are you sure you want to buy the "..self.inventory[input].name.."?",
      choices.options(
        "Yes",
        function ()
          if player.inventory.coins < self.inventory[input].value then
            ui:message("You cannot afford this item\n")
            utility.sleep(2)
            camp.Merchant:buy(player)
          else
            player.inventory.coins = player.inventory.coins - self.inventory[input].value
            table.insert(player.inventory,self.inventory[input])
            table.remove(self.inventory,input)
            ui:message("\"A fine purchase,\" says the merchant. \"Many thanks.\"")
            utility.sleep(2)
            camp.Merchant:buy(player)
          end
        end,
        "No",
        function()
          camp.Merchant:buy(player)
        end))
    
  else
    ui:message("Invalid Input\n")
    utility.sleep(2)
    camp.Merchant:buy(player)
  end
end
function camp.Merchant:sell(player)
  n = 0
  ui:message(" > Inventory <")
  for k,v in ipairs(player.inventory) do
    n = n + 1
    if v.equipped == true then
      if v.item_type == "weapon" then
        ui:message("(E) "..k.." > "..v.name.."\tvalue: "..v.value.." coins\tattack: "..v.atk.."\tdamage: "..v.dmg)
      elseif v.item_type == "armor" then
        ui:message("(E) "..k.." > "..v.name.."\tvalue: "..v.value.." coins\tdefense: "..v.defense)
      end
    elseif v.item_type == "weapon" then
      ui:message(k.." > "..v.name.."\tvalue: "..v.value.." coins\tattack: "..v.atk.."\tdamage: "..v.dmg)
    elseif v.item_type == "armor" then
      ui:message(k.." > "..v.name.."\tvalue: "..v.value.." coins\tdefense: "..v.defense)
    elseif v.item_type == "generic item" then
      ui:message(k.." > "..v.name.."\tvalue: "..v.value.." coins")
    end
  end
  ui:message((n+1).." > Back")
  ui:message("What would you like to sell?")
  input = tonumber(ui:formatPrompt('*n', "Enter a number (1-"..(n+1).."):\n\n"))
  if input == n+1 then
    camp.Merchant:at_merchant(player)
  elseif input <= n then
    choices.choose(
      "Are you sure you want to sell the "..player.inventory[input].name.."?",
      choices.options(
        "Yes",
        function ()
          player.inventory.coins = player.inventory.coins + player.inventory[input].value
          table.insert(self.inventory,player.inventory[input])
          table.remove(player.inventory,input)
          ui:message("\"A fine sale,\" says the merchant. \"Many thanks.\"")
          utility.sleep(2)
          camp.Merchant:sell(player)
        end,
        "No",
        function()
          camp.Merchant:sell(player)
        end))
  else
    ui:message("Invalid Input\n")
    utility.sleep(2)
    camp.Merchant:sell(player)
  end
end
function camp.Merchant:dialogue(player)
  choices.choose(
    "What do you want to say?",
    choices.options(
      '"What sort of things do you sell?"',
      function()
        ui:message('"All sorts of things! I\'ve got weapons, armor, and just about anything else an adventurer like yourself might need in their travels."')
        prompt = ui:formatPrompt('*n', "(Enter 1 to continue)")
        if prompt == 1 then
          self:dialogue(player)
        end
      end,
      '"What can you tell me about the caves?"',
      function()
        ui:message('"I\'ve heard from other adventurers like yourself that those caves have an opening into the dungeons of that castle up on the mountain, but that there are strange stone soldiers that patrol the dungeon\'s halls."')
        prompt = ui:formatPrompt('*n', "(Enter 1 to continue)\n\n")
        if prompt == 1 then
          self:dialogue(player)
        end
      end,
      '"Why are you here?"',
      function()
        ui:message('"Business, my friend, business! While it\'s fairly quiet right now, there are always more adventurers like yourself passing through who are willing to spend good coin on my wares. The fountain here in the camp is also considered somewhat of a holy site, so I get the occasional pilgrim as well."')
        prompt = ui:formatPrompt('*n', "(Enter 1 to continue)")
        if prompt == 1 then
          self:dialogue(player)
        end
      end,
      'Back',
      function()
        self:at_merchant(player)
      end))
end       
-- Fountain --
camp.Fountain = {}
function camp.Fountain:visit_fountain(player)
  ui:message("You approach the fountain and hear the pleasant sounds of water splashing into the carved marble basin. As you stand in front of it, you see that the water within the basin is glowing softly with white light.")
  camp.Fountain:at_fountain(player)
end
function camp.Fountain:at_fountain(player)
    choices.choose(
    "What do you do?",
    choices.options(
      "Drink from the fountain",
      function()
        player.hp = player.max_hp
        ui:message("You drink from the fountain, the water glowing softly as you scoop it up in your hands. You feel all of your wounds close in an instant.")
        camp.Fountain:at_fountain(player)
      end,
      "Fill your flasks",
      function()
        for k,v in pairs(player.inventory) do
          if v.name == "Flask" then
            v.filled = true
          end
        end
        ui:message("You fill your flasks with water from the fountain, and you can see the white glow emanating from the mouth of your flasks before you stopper them.")
        camp.Fountain:at_fountain(player)
      end,
      "Return to the center of camp",
      function()
        camp.Camp:in_camp(player)
      end))
end
-- Camp Tile --
camp.Camp = {}
  camp.Camp.visits = 0
  camp.Camp.tile_code = "001"
function camp.Camp:enter_camp(player)
  self.visits = self.visits + 1
  if player.status == "unconscious" then
    player.hp = 1
    player.status = "alive"
    ui:message("You awake on your bedroll, sore and injured, to see a stocky, grizzled man in dirt-stained clothes leaning over you.\n\"You're alive after all, I see,\" he says. He turns and grabs the handles of a wheelbarrow beside him and says, \"Next time, make sure you die properly. I've got a nice plot picked out for you.\" With that, he lifts his wheelbarrow and walks away to the west, past the fountain and up the rocky path to the crag.")
  else
    if self.visits > 1 then
      ui:message("You make your way back into the camp.")
    else
      ui:message("\tYou find your way into a camp of sorts from the south, a clearing of smooth stone in a field of rocky outcroppings and rough grass. At the center of the clearing is a ring of stones, filled with the ashes of previous campfires. On the eastern side of the clearing is a wagon piled high with supplies, weapons, and armor, minded by a heavyset older man with well-trimmed grey hair and beard. On the western side of the clearing is a rock outcropping with a trickle of water running down into a stone basin, as well as a steep, rocky path that leads up to the top of a nearby crag. To the north is a winding path that leads towards what appears to be a cave mouth.")
    end
  end
end
function camp.Camp:in_camp (player)
  info = choices.choose(
    "You stand in the center of camp. What do you want to do?",
    choices.options(
      "Go North - To the caves",
      function()
        return "101"
      end,
      "Go East - Visit the merchant",
      function()
        camp.Merchant:visit_merchant(player)
      end,
      "Go West - Visit the fountain",
      function()
        camp.Fountain:visit_fountain(player)
      end,
      "Go West - Climb the crag",
      function()
        ui:message("You make your way up the rocky path to the top of the western crag, and you are met with a spectacular view: \n\tTo the north, you see through a gap in the mountains a large castle with a tall tower at its center.\n\tTo the west you see set of switchbacks leading down the face of the crag into a sprawling graveyard to spreads as far as you can see. Near the end of the switchbacks is a hut with a trickle of smoke coming from the chimney. Way out in the center of the graveyard at the end of the path is a low stone building that seems to sunken partially into the ground.")
        choices.choose(
          "What do you want to do?",
          choices.options(
            "Go East - Back down to camp",
            function()
              return "001"
            end,
            "Go West - Down the switchbacks to the graveyard",
            function()
              return "002"
            end))
      end,
      "View Character",
      function()
        ui:message("Class: "..player.class)
        ui:message("Hit Points: "..player.hp.."/"..player.max_hp)
        ui:message("Attack: "..player.atk)
        ui:message("Damage: "..player.dmg)
        ui:message("Defense: "..player.defense)
        ui:message("Weapon: "..player.equipped.weapon.name)
        ui:message("Armor: "..player.equipped.armor.name)
        if player.equipped.trinket ~= nil then
          ui:message("Trinket: "..player.equipped.trinket.name)
        end
        choices.choose(
          "What do you want to do?",
          choices.options(
            "Equip item",
            function()
              camp.Camp:equipping_item(player)
            end,
            "View abilities",
            function()
              
            end))
      end))
    return info
  end
  function camp.Camp:equipping_item(player)
    n = 0
    ui:message(" > Inventory <")
    for k,v in ipairs(player.inventory) do
      n = n + 1
      if v.equipped == true then
        if v.item_type == "weapon" then
          ui:message("(E) "..k.." > "..v.name.."\tvalue: "..v.value.." coins\tattack: "..v.atk.."\tdamage: "..v.dmg)
        elseif v.item_type == "armor" then
        ui:message("(E) "..k.." > "..v.name.."\tvalue: "..v.value.." coins\tdefense: "..v.defense)
        end
      elseif v.item_type == "weapon" then
        ui:message(k.." > "..v.name.."\tvalue: "..v.value.." coins\tattack: "..v.atk.."\tdamage: "..v.dmg)
      elseif v.item_type == "armor" then
        ui:message(k.." > "..v.name.."\tvalue: "..v.value.." coins\tdefense: "..v.defense)
      elseif v.item_type == "generic item" then
        ui:message(k.." > "..v.name.."\tvalue: "..v.value.." coins")
      end
    end
    ui:message((n+1).." > Back")
    ui:message("What would you like to equip?")
    input = tonumber(ui:formatPrompt('*n', "Enter a number (1-"..(n+1).."):\n\n"))
    if input == n+1 then
      camp.Camp:in_camp(player)
    elseif input <= n then
      player:equip_item(player.inventory[input])
      camp.Camp:in_camp(player)
    else
      ui:message("Invalid Input")
      utility.sleep(2)
      camp.Camp:in_camp(player)
    end
  end
function camp.Camp:load_tile(player)
  camp.Camp:enter_camp (player)
  next_code = camp.Camp:in_camp(player)
  return next_code
end
--
return camp
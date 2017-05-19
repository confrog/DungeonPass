
camp = {}
-- Merchant --
camp.Merchant = {}
  camp.Merchant.inventory = {} -- fill in item inventory
function camp.Merchant:dialogue()
  -- write merchant dialogue code
end
function camp.Merchant:visit_merchant(player)
  -- write visit merchant code
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
  choices.choose(
    "You stand in the center of camp, next to your bedroll. Where do you go?",
    choices.options(
      "North - To the caves",
      function()
        return "101"
      end,
      "East - Visit the merchant",
      function()
        camp.Merchant:visit_merchant(player)
      end,
      "West - Visit the fountain",
      function()
        camp.Fountain:visit_fountain(player)
      end,
      "West - Climb the crag",
      function()
        ui:message("You make your way up the rocky path to the top of the western crag, and you are met with a spectacular view: \n\tTo the north, you see through a gap in the mountains a large castle with a tall tower at its center.\n\tTo the west you see set of switchbacks leading down the face of the crag into a sprawling graveyard to spreads as far as you can see. Near the end of the switchbacks is a hut with a trickle of smoke coming from the chimney. Way out in the center of the graveyard at the end of the path is a low stone building that seems to sunken partially into the ground.")
        choices.choose(
          "Where do you go?",
          choices.options(
            "East - Back down to camp",
            function()
              return "001"
            end,
            "West - Down the switchbacks to the graveyard",
            function()
              return "002"
            end))
      end))
  end
function camp.Camp:load_tile(player)
  camp.Camp:enter_camp (player)
  tile_code = camp.Camp:in_camp(player)
  return tile_code
end
--
return camp
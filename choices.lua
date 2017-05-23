-- Let the user choose between a number of options,
-- running a particular function for each option.
-- (This could be implemented differently depending
--  on whether we're on the Pico8 or not)

require "ui"

choices = {}
function choices.choose(prompt, choices)
   local numChoices = #choices

   ui:message(prompt)

   for i = 1, numChoices do
      local choice = choices[i]
      ui:formatMessage(' %i) %s\n',
                       i, choice.label)
   end

   local choice = ui:formatPrompt('*n',
      'Enter a number (1-%i):\n\n',
      numChoices)
   if choice == nil or choice < 1 or choice > numChoices then
      error('Invalid selection!')
   end

   return choices[choice].callback()
end

function choices.options(...)
   local opts = {}
   local input = {...}

   for i = 1, #input, 2 do
      local option = {
         label = input[i];
         callback = input[i + 1]
      }
      table.insert(opts, option)
   end

   return opts
end
--
function choices.iter_options(...)
  local opts = {}
  local input = {...}
  for i = 1, #input[1], 2 do
    local option = {
        label = input[1][i];
        callback = input[2][i]
    }
    table.insert(opts, option)
   end
  return opts
end
--
return choices
-------------------
-- USAGE EXAMPLE --
-------------------

--choose(
--   'You come to a fork in the road. What do you do?',
--   options(
--      'Go left',
--      function()
--         print('You go left')
--         print('You are promptly devoured by a nearsighted ogre')
--      end,

--      'Go right',
--      function()
--         print('You go right')
--         print('You trip on your own shoelace, and land in a bush')
--         print('A branch pierces your eyeball with a sickening *POP*')
--         print('You have died')
--      end,

--      'Run away! Forks are scary',
--      function()
--         print('... but why are you afraid of forks')
--      end))

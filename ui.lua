-- User interface for the game
-- ---------------------------
--
-- Eventually, I imagine the user interface looking
-- something like this:
--
--     █████████████████████
--     █        █          █
--     █        █          █
--     █        █          █
--     █   INV  █   game   █
--     █        █          █
--     ██████████          █
--     █        █          █
--     █   HUD  █▄▄▄▄▄▄▄▄▄▄█
--     █        █   input  █
--     █████████████████████

ui = {}

function ui:message(text)
   self:formatMessage('%s\n', text)
end

function ui:formatMessage(text, ...)
   -- TODO leave a static message window on the screen
   io.write(string.format(text, ...))
end

function ui:prompt(fmt, text)
   self:formatPrompt(fmt, '%s\n', text)
end

function ui:formatPrompt(fmt, text, ...)
   -- TODO may need to reposition the cursor
   self:formatMessage(text, ...)
   return io.read(fmt)
end

return ui

-- Usage Example
-- -------------

-- ui:message('Ay, traveler!')
-- local name = ui:prompt('And what might ye name be?')
-- ui:message(name .. '..? Well okay then')

-- local typedUi = {}
-- setmetatable(typedUi, ui)
-- function typedUi:message(text)
--   require('socket')
--   for i = 1,#text do
--      self:formatMessage(text[i])
--      socket.sleep(0.2)
--   end
--
--   self:formatMessage('\n')
--end

--typedUi:message('This is typed slowly')

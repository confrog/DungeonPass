-- User interface for the game
-- ---------------------------

require "vscreen"

ui = {
   gameScreen = vscreen:new({
         height = 20;
         width = 70;
   });
   input = vscreen:new({
         height = 2;
         width = 70;
         y = 22;
   });
}

function ui:message(text)
   self.gameScreen:write(text .. '\n')
end

function ui:formatMessage(text, ...)
   self.gameScreen:write(
      string.format(text, ...))
end

function ui:prompt(fmt, text)
   if text == nil then
      text = fmt
      fmt = '*l'
   end

   self:message(text)
   return self.input:read(fmt)
end

function ui:formatPrompt(fmt, text, ...)
   self:formatMessage(text, ...)
   return self.input:read(fmt)
end

return ui

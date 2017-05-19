-- Virtual Screens
-- ---------------
-- These virtual screens take up a section of the real
-- screen, and allow text to be written within them.

require "terminal"

vscreen = {
   terminal = terminal;
}

function vscreen:new(props)
   local v = {
      height = props.height or 24;
      width = props.width or 80;
      x = props.x or 1;
      y = props.y or 1;
      history = {};
   }
   
   setmetatable(v, { __index = self })
   v:clear()
   return v
end

function vscreen:write(text)
   while string.len(text) > 0 do
      local nextBreak = string.find(text, '\n') or self.width
      if nextBreak > (self.width - 2) then
         nextBreak = self.width - 2
      end
      
      local snip = string.sub(text, 1, nextBreak)
      table.insert(self.history, snip)
      text = string.sub(text, nextBreak + 1)
   end

   self:refresh()
end

function vscreen:refresh()
   self:clear()
   local start = #self.history - (self.height - 3)
   if start < 1 then
      start = 1
   end
   local offset = 1
   for i = start,#self.history do
      self.terminal:pos(self.x + 1, offset + self.y + 1)
      self.terminal:write(self.history[i])
      offset = offset + 1
   end
end

function vscreen:fill(char)
   self:drawBorder()
   local cleanLine = string.rep(char, self.width - 2)
   for i = 1,self.height - 1 do
      self.terminal:pos(self.x + 1, i + self.y)
      self.terminal:write(cleanLine)
   end
end

function vscreen:clear()
   self:fill(' ')
end

function vscreen:drawBorder()
   self.terminal:pos(self.x, self.y)
   self.terminal:write(string.rep('▄', self.width+1))
   self.terminal:pos(self.x, self.y + self.height)
   self.terminal:write(string.rep('▀', self.width+1))
   for i = 1,self.height-1 do
      self.terminal:pos(self.x, self.y + i)
      self.terminal:write('█')
      self.terminal:pos(self.x + self.width, self.y + i)
      self.terminal:write('█')
   end
end

function vscreen:read(fmt)
   self.terminal:pos(self.x+1, self.y+1)
   self.terminal:write('> ')
   local value = self.terminal:read(fmt)
   self:clear()
   return value
end

return vscreen

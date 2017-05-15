-- An interface to ANSI terminals
-- ------------------------------

terminal = {
   io = io;
}

function terminal:pos(x, y)
   x = x or 0
   y = y or 0
   self:write('\x1b[' .. string.format('%i;%iH', y, x))
end

function terminal:write(text)
   self.io.write(text)
end

function terminal:clear()
   self:pos()
   self:write('\x1b[2J')
end

function terminal:read(fmt)
   return self.io.read(fmt)
end

return terminal

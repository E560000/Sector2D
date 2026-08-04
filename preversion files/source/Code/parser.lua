Classic = require "Libraries/classic"
local Note = Classic:extend()
function Note:new(Type,Timing)
  self.Type = Type
  self.Timing = Timing
end
function loadMap(difficulty)
    local notes = {}

    local filename = "Maps/" .. difficulty .. ".s2d"
    local contents = love.filesystem.read(filename)

    if not contents then
        error("E001")
    end

    for line in contents:gmatch("[^\r\n]+") do
        local orientation, timing = line:match("([^,]+),([^,]+)")
        table.insert(notes, tonumber(timing), tonumber(orientation))
    end
    for i in notes() do
      print(notes[i])
    end
    return notes
end
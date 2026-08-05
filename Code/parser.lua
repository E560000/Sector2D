Classic = require "Libraries/classic"
local Note = Classic:extend()
function Note:new(Type,Timing,Mode)
  self.Type = Type
  self.Timing = Timing
  self.Mode = Mode
end
function loadMap(difficulty)
    local notes = {}

    local filename = "Maps/" .. difficulty .. ".s2d"
    local contents = love.filesystem.read(filename)

    if not contents then
        error("E001")
    end

    for line in contents:gmatch("[^\r\n]+") do
        local orientation, timing, mode = line:match("([^,]+),([^,]+),([^,]+)")
        if orientation and timing and mode then
            table.insert(notes, Note(orientation, tonumber(timing), mode))
        else
          error("E002")
        end
    end
    for i, note in ipairs(notes) do
        print("Index: ", i, note.Type, note.Timing, note.Mode)
    end
    return notes
end
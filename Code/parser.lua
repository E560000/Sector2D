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
        if orientation and timing then
            table.insert(notes, Note((orientation), tonumber(timing)))
        end
    end
    for i, note in ipairs(notes) do
        print(note.Type, note.Timing)
    end
    return notes
end
Classic = require "Libraries/classic"
local Note = Classic:extend()
function Note:new(Type,Timing,Mode,Effect)
  self.Type = Type
  self.Timing = Timing
  self.Mode = Mode
  self.Effect = Effect
end
function Note:serialize()
  return string.format("%s,%s,%s,%s",self.Type,self.Timing,self.Mode,self.Effect)
end
function saveMap(notes, difficulty)
  local result
  local path = love.filesystem.getWorkingDirectory().."/Maps/" .. difficulty .. ".s2d"
  
  print("path:"..path)
  local lines = {}
  local file,err = io.open(path, "w")
  if not file then
    print("Save failed: "..err)
    return
  end
  for _, note in ipairs(notes) do
    lines[#lines + 1] = note:serialize()
  end
  file:write(table.concat(lines, "\n"))
  file:close()
  result = "Saved."
  print(result)
end
function loadMap(difficulty)
    local notes = {}

    local filename = "Maps/" .. difficulty .. ".s2d"
    local contents = love.filesystem.read(filename)

    if not contents then
        error("E001")
    end

    for line in contents:gmatch("[^\r\n]+") do
        local orientation, timing, mode, effect = line:match("([^,]+),([^,]+),([^,]+),([^,]+)")
        if orientation and timing and mode and effect then
            table.insert(notes, Note(orientation, tonumber(timing), mode, effect))
        else
          error("E002")
        end
    end
    for i, note in ipairs(notes) do
        print("Index: ", i, note.Type, note.Timing, note.Mode, note.Effect)
    end
    return notes
end
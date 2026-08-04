
function loadMap(difficulty)
  mapLines = {}
  local filename = "Maps/"..difficulty .. ".txt"
  local contents = love.filesystem.read(filename)

  if contents then
      for line in contents:gmatch(";") --[[newline separator ;]] do
          table.insert(mapLines, line)
          print(line)
          print(mapLines)
      end
  else
      print("Could not read file: " .. filename)
  end
  print("File length: " .. #contents)
  love.window.showMessageBox("Raw contents", contents, "info")
end
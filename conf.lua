--config
function love.conf(f)
  f.author="Enis Bayram"
  f.console=true
  f.modules.physics=false
  f.window.title = "Sector2D"
  f.window.resizable = true
  f.window.minwidth = 1920
  f.window.minheight = 1080
  f.window.fullscreen = false
  f.window.vsync = false
  f.window.icon = "Assets/Images/logo.png"
end

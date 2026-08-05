--Enis Bayram 2025,2026,2027 Sector2D: Computer Science OCR project
loadStart=love.timer.getTime()
--Modules
require "Code/audio"
require "Code/variables"
require "Code/fonts"
require "Code/images"
require "Code/settings"
require "Code/parser"
--Libraries
Classic = require "Libraries/classic"
function love.load()
  notes = loadMap(difficulty)
end
function isHovered(x1,x2,y1,y2)
  return mousePosX>=x1 and mousePosX<=x2 and mousePosY>=y1 and mousePosY<=y2
end
function round(number,decimalPlaces)
  local mult=10^(decimalPlaces or 0)
  return math.floor(number*mult+0.5)/mult
end
function clamp(value,min,max)
  if value<min then return min end
  if value>max then return max end
  return value
end
function setEditorBPM(x)
  local left=editorSliderX
  local range=editorSliderWidth
  local normalized=(clamp(x,left,left+range)-left)/range
  bpm = math.floor(normalized * (editorBpmMax-editorBpmMin) + editorBpmMin + 0.5)
end
function hit(key)
  local time=love.timer.getTime()
  local relativeTime=time*1000-startTime*1000
  print(relativeTime,key)
  return(relativeTime)
end
function love.keypressed(key)
  if screenState=="Play" then
    if players==2 then
      if key=="w" then
        hit("u1")
        love.audio.play(pop)
        langle = -pi/2
        leftstate = "u"
        colourA.r=194/255
        colourA.g=75/255
        colourA.b=153/255
      end
      if key=="d" then
        hit("r1")
        love.audio.play(pop)
        langle = 0
        leftstate = "r"
        colourA.r=0
        colourA.g=1
        colourA.b=1
      end
      if key=="a" then
        hit("l1")
        love.audio.play(pop)
        langle = pi
        leftstate = "l"
        colourA.r=18/255
        colourA.g=250/255
        colourA.b=5/255
      end
      if key=="s" then
        hit("d1")
        love.audio.play(pop)
        langle = pi/2
        leftstate = "d"
        colourA.r=249/255
        colourA.g=57/255
        colourA.b=63/255
      end
    end
    if key=="up" then
      hit("u2")
      love.audio.play(pop)
      rangle = -pi/2
      rightstate="u"
      colourB.r=194/255
      colourB.g=75/255
      colourB.b=153/255
    end
    if key=="right" then
      hit("r2")
      love.audio.play(pop)
      rangle=0
      rightstate="r"
      colourB.r=0
      colourB.g=1
      colourB.b=1
    end
    if key=="left" then
      hit("l2")
      love.audio.play(pop)
      rangle=pi
      rightstate="l"
      colourB.r=18/255
      colourB.g=250/255
      colourB.b=5/255
    end
    if key=="down" then
      hit("d2")
      love.audio.play(pop)
      rangle=pi/2
      rightstate="d"
      colourB.r=249/255
      colourB.g=57/255
      colourB.b=63/255
    end
  end
  if screenState=="Launch" then
  --main menu buttons
  end
  if screenState=="Settings" then
  --settings buttons
  end
end
function love.keyreleased(key)
  if screenState=="Play" then
    if players==2 then
      if key=="w" then
        up1="released"
      end
      if key=="a" then
        left1="released"
      end
      if key=="s" then
        down1="released"
      end
      if key=="d" then
        right1="released"
      end
    if key=="up" then
      up2="released"
    end
    end
    if key=="left" then
      left2="released"
    end
    if key=="down" then
      down2="released"
    end
    if key=="right" then
      right2="released"
    end
  end
end
function love.mousepressed(x,y,button,number)
  if screenState=="Play" then
    if isHovered(-40,40,200,220) then
      if button==1 then
        screenState="Launch"
        backgroundMusicPlaying=-1
        hitcounter=0
      end
    end
  end
  if screenState=="Launch" then
    if isHovered(-170,-90,180,200) then
      if button==1 then
        screenState="Play"
        --Allows for timing comparison
        startTime=love.timer.getTime()
        backgroundMusicPlaying=-1
      end
    end
    if isHovered(50,130,180,200) then
      if button==1 then
        screenState="Settings"
        backgroundMusicPlaying=-1
      end
    end
  end
  if screenState=="Settings" then
    if isHovered(500,525,-200,-175) then
      if button==1 then
        screenState="Launch"
        backgroundMusicPlaying=-1
      end
    end
    if isHovered(-160,-80,-90,-70) then
      if button==1 then
        if difficulty=="Easy" then
          difficulty="Medium"
          songName="Aquaris -- Croove"
          notes=loadMap("Medium")
          bpm=140
        elseif difficulty=="Medium" then
          difficulty="Hard"
          songName="Burning Eyes -- Toby Fox"
          notes=loadMap("Hard")
          bpm=147.5
        else
          difficulty="Easy"
          songName="Death By Glamour -- Toby Fox"
          notes=loadMap("Easy")
          bpm=148 
        end
      end
    end
    if isHovered(-280,-200,10,30) then
      if players==1 then
        players=2
      else
        players=1
      end
    end
  end
  if screenState=="Editor" then
    if button==1 then
      local centeredX = x - (width or love.graphics.getWidth()) / 2
      local centeredY = y - (height or love.graphics.getHeight()) / 2
      if isHovered(editorSliderX, editorSliderX + editorSliderWidth, editorSliderY - editorSliderHeight, editorSliderY + editorSliderHeight, centeredX, centeredY) then
        editorSliderDragging=true
        setEditorBPM(centeredX)
      end
    end
  end
end
function love.mousereleased(x,y,button)
  if button==1 then
    leftclick=false
    editorSliderDragging=false
  end
end
--love.update function refreshes for every frame
function love.update(dt)
  width=love.graphics.getWidth()
  height=love.graphics.getHeight()
  mousePosX=love.mouse.getX()-width/2
  mousePosY=love.mouse.getY()-height/2
  leftclick=love.mouse.isDown(1)
  if leftclick then
    screenBrightness=0.5
  end
  if screenBrightness>0 then
    screenBrightness=screenBrightness-(dt*2)
  end
  if PlayBackgroundMusic==true then
    if backgroundMusicPlaying~=1 then
      love.audio.play(backgroundMusic)
      backgroundMusicPlaying=1
    end
  else
    love.audio.pause(backgroundMusic)
  end
  if PlaySettingsMusic==true then
    if settingsMusicPlaying~=1 then
      love.audio.play(settingsMusic)
      settingsMusicPlaying=1
    end
  else
    love.audio.pause(settingsMusic)
    settingsMusicPlaying=-1
  end 
  if screenState=="Play" and GameplayAudioPlaying~=1 then
    if difficulty=="Easy" then
      love.audio.play(EasyGameplayAudio)
    elseif difficulty=="Medium" then
      love.audio.play(MediumGameplayAudio)
    else
      love.audio.play(HardGameplayAudio)
    end
    GameplayAudioPlaying=1
  elseif screenState~="Play" then
    love.audio.stop(EasyGameplayAudio)
    love.audio.stop(MediumGameplayAudio)
    love.audio.stop(HardGameplayAudio)
    GameplayAudioPlaying=0
  end
  if screenState=="Launch" then
    PlayBackgroundMusic=true
    PlaySettingsMusic=false
    titleBrightness = (math.sin(love.timer.getTime() * math.pi * 2 * bpm/120) + 1) / 2
    titleColour.r = titleBrightness
    titleColour.g = titleBrightness
    titleColour.b = titleBrightness
    if isHovered(-170,-90,180,200) then
      hover.button1=1
    else
      hover.button1=-1
    end
    if isHovered(50,130,180,200) then
      hover.button2=1
    else
      hover.button2=0
    end
    if leftclick and isHovered(50,130,180,200) then
      screenState="Settings"
      backgroundMusicPlaying=-1
    end
  end 
  if screenState=="Settings" then
    PlaySettingsMusic=true
    PlayBackgroundMusic=false
    -- settings stuff here
    --Exit button
    if isHovered(500,525,-200,-175) then
      hover.button1=1
    else
      hover.button1=-1
    end
    --Difficulty button
    if isHovered(-160,-80,-90,-70) then
      hover.button2=1
    else
      hover.button2=-1
    end
    --Players button
    if isHovered(-280,-200,10,30) then
      hover.button3=1
    else
      hover.button3=-1
    end
  end
  if screenState=="Editor" then
    if leftclick and editorSliderDragging then
      setEditorBPM(mousePosX)
    end
    if isHovered(-430,-400,-125,-85) then
      hover.button1=1
    else
      hover.button1=-1
    end
    if isHovered(-385,-355,-125,-85) then
      hover.button2=1
    else
      hover.button2=-1
    end
    if isHovered(-340,-310,-125,-85) then
      hover.button3=1
    else
      hover.button3=-1
    end
    if isHovered(-293,-263,-125,-85) then
      hover.button4=1
    else
      hover.button4=-1
    end
    if isHovered(-505,-365,-73,28) then
      hover.button5=1
    else
      hover.button5=-1
    end
  end
  if screenState=="Play" then
    if isHovered(-40,40,200,220) then
      hover.button1=1
    else
      hover.button1=-1
    end
    PlayBackgroundMusic=false
    if songNameBright==0 then
      songNameColour.r=songNameColour.r+bpm/60*dt
      songNameColour.g=songNameColour.g+bpm/60*dt
      songNameColour.b=songNameColour.b+bpm/60*dt
    elseif songNameBright==1 then
      songNameColour.r=songNameColour.r-bpm/60*dt
      songNameColour.g=songNameColour.g-bpm/60*dt
      songNameColour.b=songNameColour.b-bpm/60*dt
    end
    if songNameColour.r>=1 then
      songNameBright=1
    elseif songNameColour.r<=0 then
      songNameBright=0
    end
  end
end
love.graphics.setLineWidth(4)
--love.draw function draws every frame
function love.draw()
  --hiding screen fade on settings to hide low FPS workaround
  if screenState=="Launch" or screenState=="Play" then
    love.graphics.setBackgroundColor(screenBrightness,screenBrightness,screenBrightness)
  end
  --setting a new origin to the center of the window
  love.graphics.translate(width/2,height/2)
  --refreshing colour for text etc
  love.graphics.setColor(1,1,1)
  love.graphics.setFont(rimouski)
  --Main Menu
  if screenState=="Launch" then
    love.graphics.setColor(1,1,1)
    love.graphics.draw(background,-980,-600,0,1,1)
    love.graphics.print(loadTime.." Seconds to load",-150,380)
    if hover.button1==1 then
      love.graphics.setColor(hoverColour.r,hoverColour.g,hoverColour.b)
    end
    love.graphics.rectangle("fill",-170,180,buttonDimensions.width,buttonDimensions.height)
    love.graphics.setColor(1,1,1)
    if hover.button2==1 then
      love.graphics.setColor(hoverColour.r,hoverColour.g,hoverColour.b)
    end
    love.graphics.rectangle("fill",50,180,buttonDimensions.width,buttonDimensions.height)
    love.graphics.setColor(0,0,0)
    love.graphics.print("Start",-150,180,0,0.6,0.6)
    love.graphics.print("Settings",60,180,0,0.55,0.55)
    love.graphics.setColor(titleColour.r,titleColour.g,titleColour.b)
    love.graphics.setFont(cubic)
    love.graphics.print("Sector2D",-320,-200,0,2,2)
    love.graphics.setColor(1,1,1)
    love.graphics.setFont(rimouski)
    love.graphics.print("GUIDE:\n-Click playfield to see controls\n-Press corresponding keys to hit notes\n-Listen and look for cues on what to hit\n-Don't miss!",-350,-50,0,1,1)
  end
  --Play screen
  if screenState=="Play" then
    if hover.button1==1 then
      love.graphics.setColor(hoverColour.r,hoverColour.g,hoverColour.b)
    end
    love.graphics.rectangle("fill",-40,200,buttonDimensions.width,buttonDimensions.height)
    love.graphics.setColor(songNameColour.r,songNameColour.g,songNameColour.b)
    love.graphics.setFont(cubic)
    love.graphics.printf(songName,-750,250,1500,"center")
    love.graphics.setFont(rimouski)
    love.graphics.setColor(1,1,1)
    love.graphics.print("FPS:"..love.timer.getFPS().." "..(round(love.timer.getDelta(),3)*1000).."ms frametime",-535,-300,0,1.5,1.5)
    love.graphics.setColor(0,0,0)
    love.graphics.print("Menu",-23,199,0,0.6,0.6)
    --drawing the playing area
    if players==1 then
      --Judgement counting
      love.graphics.setColor(1,1,1)
      love.graphics.print("Perfect:"..perfectCounter1,-530,-130,0,1.5,1.5)
      love.graphics.print("Great:"..greatCounter1,-530,-80,0,1.5,1.5)
      love.graphics.print("Good:"..goodCounter1,-530,-30,0,1.5,1.5)
      love.graphics.print("OK:"..okCounter1,-530,20,0,1.5,1.5)
      love.graphics.print("Miss:"..missCounter1,-530,70,0,1.5,1.5)
    end
    if players==2 then
      love.graphics.setColor(1,1,1)
      love.graphics.print("Perfect:"..perfectCounter1,-600,-130,0,1.5,1.5)
      love.graphics.print("Great:"..greatCounter1,-600,-80,0,1.5,1.5)
      love.graphics.print("Good:"..goodCounter1,-600,-30,0,1.5,1.5)
      love.graphics.print("OK:"..okCounter1,-600,20,0,1.5,1.5)
      love.graphics.print("Miss:"..missCounter1,-600,70,0,1.5,1.5)
      love.graphics.printf(perfectCounter2..":Perfect",350,-130,170,"right",0,1.5,1.5)
      love.graphics.printf(greatCounter2..":Great",350,-80,170,"right",0,1.5,1.5)
      love.graphics.printf(goodCounter2..":Good",350,-30,170,"right",0,1.5,1.5)
      love.graphics.printf(okCounter2..":OK",350,20,170,"right",0,1.5,1.5)
      love.graphics.printf(missCounter2..":Miss",350,70,170,"right",0,1.5,1.5)
      love.graphics.translate(-200,0)
      love.graphics.setColor(0,0,0)
      love.graphics.print("A",-90,-15,0,1,1)
      love.graphics.print("D",75,-15,0,1,1)
      love.graphics.print("W",-12,-93,0,1,1)
      love.graphics.print("S",-8,68,0,1,1)
      love.graphics.setColor(18/255,250/255,5/255)
      love.graphics.arc("line",0,0,103,pi-pi/4,pi+pi/4)--left
      love.graphics.setColor(249/255,57/255,63/255)
      love.graphics.arc("line",0,0,103,pi/2-pi/4,pi/2+pi/4) --down
      love.graphics.setColor(194/255,75/255,153/255)
      love.graphics.arc("line",0,0,103,-pi/2-pi/4,-pi/2+pi/4) --up
      love.graphics.setColor(0,1,1)
      love.graphics.arc("line",0,0,103,-pi/4,pi/4) --right
      love.graphics.translate(400,0)
    end
    --second playing area
    love.graphics.setColor(0,0,0)
    love.graphics.print("Left",-95,-15)
    love.graphics.print("Right",20,-15)
    love.graphics.print("Up",-15,-93)
    love.graphics.print("Down",-40,60)
    love.graphics.setColor(18/255,250/255,5/255)
    love.graphics.arc("line",0,0,103,pi-pi/4,pi+pi/4)--left
    love.graphics.setColor(249/255,57/255,63/255)
    love.graphics.arc("line",0,0,103,pi/2-pi/4,pi/2+pi/4) --down
    love.graphics.setColor(194/255,75/255,153/255)
    love.graphics.arc("line",0,0,103,-pi/2-pi/4,-pi/2+pi/4) --up
    love.graphics.setColor(0,1,1)
    love.graphics.arc("line",0,0,103,-pi/4,pi/4) --right
    --Arrows
    if players==2 then
      love.graphics.translate(-400,0)
      love.graphics.rotate(langle)
      love.graphics.setColor(colourA.r, colourA.g, colourA.b)
      love.graphics.line(100,0,90,-10)
      love.graphics.line(100,0,90,10)
      love.graphics.line(0, 0, 100, 0)
      love.graphics.rotate(-langle)
      love.graphics.translate(400,0)  
    end
    love.graphics.rotate(rangle)
    love.graphics.setColor(colourB.r, colourB.g, colourB.b)
    love.graphics.line(100,0,90,-10)
    love.graphics.line(100,0,90,10)
    love.graphics.line(0, 0, 100, 0)
    love.graphics.rotate(-rangle)
  end
  --Settings screen
  if screenState=="Settings" then
    love.graphics.print("Settings",-100,-300,0,2,2)
    love.graphics.print("Change the options below to customise your experience!",-430,-200)
    love.graphics.print("Difficulty: "..difficulty,-430,-100)
    love.graphics.print("Players: "..players,-430,0)
    love.graphics.setFont(cubic)
    love.graphics.setColor(1,1,1)
    love.graphics.draw(signature,-730,200,0,0.4,0.4)
    love.graphics.print("Version 0.2.3_Alpha", -700,325,0,0.5,0.5)
    
    --buttons
    if hover.button1==1 then      
      love.graphics.setColor(hoverColour.r,hoverColour.g,hoverColour.b)
    else
      love.graphics.setColor(1,1,1)
    end
    love.graphics.rectangle("fill",500,-200,25,25)
    love.graphics.setColor(0.5,0,0)
    love.graphics.setFont(rimouski)
    love.graphics.print("X",505,-206)
    if hover.button2==1 then
      love.graphics.setColor(hoverColour.r,hoverColour.g,hoverColour.b)
    else
      love.graphics.setColor(1,1,1)
    end
    love.graphics.draw(button,-160,-90)
    love.graphics.setColor(0,0,0)
    love.graphics.print("Change",-151,-89,0,0.5,0.5)
    if hover.button3==1 then
      love.graphics.setColor(hoverColour.r,hoverColour.g,hoverColour.b)
    else
      love.graphics.setColor(1,1,1)
    end
    love.graphics.draw(button,-280,10)
    love.graphics.setColor(0,0,0)
    love.graphics.print("Change",-271,11,0,0.5,0.5)
  end
  if screenState=="Editor" then
    love.graphics.setFont(rimouski)
    --button boxes
    love.graphics.setColor(1,1,1)
    if hover.button1==1 then
      love.graphics.setColor(hoverColour.r,hoverColour.g,hoverColour.b)
    else
      love.graphics.setColor(1,1,1)
    end
    love.graphics.rectangle("fill",-430,-125,30,40)--U
    if hover.button2==1 then
      love.graphics.setColor(hoverColour.r,hoverColour.g,hoverColour.b)
    else
      love.graphics.setColor(1,1,1)
    end
    love.graphics.rectangle("fill",-385,-125,30,40)--L
    if hover.button3==1 then
      love.graphics.setColor(hoverColour.r,hoverColour.g,hoverColour.b)
    else
      love.graphics.setColor(1,1,1)
    end
    love.graphics.rectangle("fill",-340,-125,30,40)--D
    if hover.button4==1 then
      love.graphics.setColor(hoverColour.r,hoverColour.g,hoverColour.b)
    else
      love.graphics.setColor(1,1,1)
    end
    love.graphics.rectangle("fill",-293,-125,30,40)--R
    if hover.button5==1 then
      love.graphics.setColor(hoverColour.r,hoverColour.g,hoverColour.b)
    else
      love.graphics.setColor(1,1,1)
    end
    love.graphics.rectangle("fill",-505,-73,140,45)
    love.graphics.setColor(1,1,1)
    love.graphics.print(mousePosX,-400,-300)
    love.graphics.print(mousePosY,-400,-275)
    love.graphics.print("Map Editor",-700,-330,0,2,2)
    love.graphics.setColor(0.6,0.6,0.6)
    love.graphics.print("BPM:",-650,-180,0,1.5,1.5)
    love.graphics.print("New Note:  U  L  D  R",-650,-130,0,1.5,1.5)
    love.graphics.print("Mode:  Master  Regular",-650,-80,0,1.5,1.5)
    love.graphics.print("Effect:  Regular  Finish",-650,-30,0,1.5,1.5)
    love.graphics.print("Step:",-650,20,0,1.5,1.5)
    love.graphics.print("Next:",-650,70)
    love.graphics.print("Back:",-650,110)
    love.graphics.setColor(0.9,0.2,0.2)
    love.graphics.print("Delete",350,200,0,2,2)
    love.graphics.setColor(1,1,1)
    love.graphics.line(170,-400,170,400)
    love.graphics.print("Current Note:",210,-350,0,2,2)
    if notes[currentNote] then
      love.graphics.print("Type: "..notes[currentNote].Type,300,-250,0,1.5,1.5)
      love.graphics.print("Timing: "..notes[currentNote].Timing,300,-210,0,1.5,1.5)
      love.graphics.print("Mode: "..notes[currentNote].Mode,300,-170,0,1.5,1.5)
    else
      love.graphics.print("No notes",300,-250,0,1.5,1.5)
    end
    local sliderLeft = editorSliderX
    local sliderTop = editorSliderY - editorSliderHeight
    local sliderRight = editorSliderX + editorSliderWidth
    local sliderBottom = editorSliderY + editorSliderHeight
    love.graphics.setColor(0.3,0.3,0.3)
    love.graphics.rectangle("fill", sliderLeft, sliderTop, editorSliderWidth, editorSliderHeight)

    local normalized = (bpm - editorBpmMin) / (editorBpmMax - editorBpmMin)
    local handleX = sliderLeft + normalized * editorSliderWidth
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("fill", handleX - 8, sliderTop - 4, 16, editorSliderHeight + 8)
    love.graphics.setColor(1,1,1)
    love.graphics.print(""..bpm, sliderRight + 30, editorSliderY - 35, 0, 1.5, 1.5)
  end
end
loadEnd=love.timer.getTime()
loadTime=round(loadEnd-loadStart,2)
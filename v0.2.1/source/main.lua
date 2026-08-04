--Enis Bayram 2026, Sector2D: Computer Science OCR project
--Assets
pop=love.audio.newSource("Assets/Audio/pop.wav","static")
GameplayAudio=love.audio.newSource("Assets/Audio/BadApple.mp3","static")
GameplayAudioPlaying=0
backgroundMusic=love.audio.newSource("Assets/Audio/bg.mp3","static")
backgroundMusic:setLooping(true)
backgroundMusicPlaying=0
up=love.audio.newSource("Assets/Audio/up.wav","static")
right=love.audio.newSource("Assets/Audio/right.wav","static")
down=love.audio.newSource("Assets/Audio/down.wav","static")
left=love.audio.newSource("Assets/Audio/left.wav","static")
--Fonts and Images
cubic=love.graphics.newFont("Assets/Fonts/cubic.ttf",50)
beattech=love.graphics.newFont("Assets/Fonts/BEATTECH.ttf",30)
signature=love.graphics.newImage("Assets/Images/signature.png")
background=love.graphics.newImage("Assets/Images/background.jpg")
--Initializing values that are used elsewhere
pi=math.pi
langle=0
rangle=0
colourA= {r=1,g=1,b=1}
colourB= {r=1,g=1,b=1}
leftstate="unmoved"
rightstate="unmoved"
screenState="Launch"
buttonDimensions={width=80,height=20}
hover = {button1=-1,button2=-1}
hoverColour={r=0.8,g=0.8,b=0.8}
titleColour={r=0.3,g=0.3,b=0.3}
titleBright=0
screenBrightness=0
PlayBackgroundMusic=false
mousePosX=0
mousePosY=0
function isHovered(x1,x2,y1,y2)
  return mousePosX>=x1 and mousePosX<=x2 and mousePosY>=y1 and mousePosY<=y2
end
--settings
players=1
drawJudgementCounter=-1
--love.update function refreshes for every frame
function love.update(dt)
  width=love.graphics.getWidth()
  height=love.graphics.getHeight()
  mousePosX=love.mouse.getX()-width/2
  mousePosY=love.mouse.getY()-height/2
  leftclick=love.mouse.isDown(1)
  space=love.keyboard.isDown("space")
  if leftclick or space then
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
    love.audio.stop(backgroundMusic)
  end
  if screenState=="Play" and GameplayAudioPlaying~=1 then
    love.audio.play(GameplayAudio)
    GameplayAudioPlaying=1
  elseif screenState~="Play" then
    love.audio.stop(GameplayAudio)
    GameplayAudioPlaying=0
  end
  if screenState=="Launch" then
    PlayBackgroundMusic=true
    if titleBright==0 then
      titleColour.r=titleColour.r+0.005
      titleColour.g=titleColour.g+0.005
      titleColour.b=titleColour.b+0.005
    elseif titleBright==1 then
      titleColour.r=titleColour.r-0.005
      titleColour.g=titleColour.g-0.005
      titleColour.b=titleColour.b-0.005
    end
    if titleColour.r>=1 then
      titleBright=1
    elseif titleColour.r<=0.3 then
      titleBright=0
    end
    if isHovered(-170,-90,180,200) then
      hover.button1=1
    else
      hover.button1=-1
    end
    --coords should match
    if leftclick and isHovered(-170,-90,180,200) then
      screenState="Play"
    end
    if isHovered(50,130,180,200) then
      hover.button2=1
    else
      hover.button2=0
    end
    if leftclick and isHovered(50,130,180,200) then
      screenState="Settings"
    end
  end 
  if screenState=="Settings" then
    PlayBackgroundMusic=true
    -- settings stuff here
    if isHovered(500,525,-200,-175) then
      hover.button1=1
    else
      hover.button1=-1
    end
    if leftclick and isHovered(500,525,-200,-175) then
      screenState="Launch"
    end
    if isHovered(-270,-190,-50,-30) then
      hover.button2=1
    else
      hover.button2=-1
    end
    if leftclick and isHovered(-270,-190,-50,-30) then
      if players==1 then
        players=2
      else
        players=1
      end
    end
  end
  if screenState=="Play" then
    PlayBackgroundMusic=false
    if isHovered(-40,40,200,220) then
      hover.button1=1
    else
      hover.button1=-1
    end
    if leftclick and isHovered(-40,40,200,220) then
      screenState="Launch"
      backgroundMusicPlaying=-1
    end
    --checking for keypresses, and then acting on input by changing arrow direction and colour.
    if players==2 then
      if love.keyboard.isDown("w") then
        if leftstate~="u" then
          love.audio.play(pop)
        end
        langle = -pi/2
        leftstate = "u"
        colourA.r=194/255
        colourA.g=75/255
        colourA.b=153/255
      end
      if love.keyboard.isDown("d") then
        if leftstate~="r" then
          love.audio.play(pop)
        end
        langle = 0
        leftstate = "r"
        colourA.r=0
        colourA.g=1
        colourA.b=1
      end
      if love.keyboard.isDown("a") then
        if leftstate~="l" then
          love.audio.play(pop)
        end
        langle = pi
        leftstate = "l"
        colourA.r=18/255
        colourA.g=250/255
        colourA.b=5/255
      end
      if love.keyboard.isDown("s") then
        if leftstate~="d" then
          love.audio.play(pop)
        end
        langle = pi/2
        leftstate = "d"
        colourA.r=249/255
        colourA.g=57/255
        colourA.b=63/255
      end
    end
    if love.keyboard.isDown("up") then
      if rightstate~="u" then
        love.audio.play(pop)
      end
      rangle = -pi/2
      rightstate="u"
      colourB.r=194/255
      colourB.g=75/255
      colourB.b=153/255
    end
    if love.keyboard.isDown("right") then
      if rightstate~="r" then
        love.audio.play(pop)
      end
      rangle=0
      rightstate="r"
      colourB.r=0
      colourB.g=1
      colourB.b=1
    end
    if love.keyboard.isDown("left") then
      if rightstate~="l" then
        love.audio.play(pop)
      end
      rangle=pi
      rightstate="l"
      colourB.r=18/255
      colourB.g=250/255
      colourB.b=5/255
    end
    if love.keyboard.isDown("down") then
      if rightstate~="d" then
        love.audio.play(pop)
      end
      rangle=pi/2
      rightstate="d"
      colourB.r=249/255
      colourB.g=57/255
      colourB.b=63/255
    end
  end
end
love.graphics.setLineWidth(4)
love.graphics.setLineStyle("rough")
--love.draw function draws every frame
function love.draw()
  love.graphics.setBackgroundColor(screenBrightness,screenBrightness,screenBrightness)
  --setting a new origin to the center of the window
  love.graphics.translate(width/2,height/2)
  --refreshing colour for text etc
  love.graphics.setColor(1,1,1)
  love.graphics.setFont(beattech)
  --Main Menu
  if screenState=="Launch" then
    love.graphics.setColor(1,1,1)
    love.graphics.draw(background,-980,-600,0,1,1)
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
    love.graphics.print("Start",-156,183,0,0.6,0.6)
    love.graphics.print("Settings",54,183,0,0.55,0.55)
    love.graphics.setColor(titleColour.r,titleColour.g,titleColour.b)
    love.graphics.setFont(cubic)
    love.graphics.print("Sector2D",-320,-180,0,2,2)
    love.graphics.setColor(1,1,1)
    love.graphics.setFont(beattech)
    love.graphics.print("Welcome to...",-250,-240,0,1,1)
    love.graphics.print("GUIDE:\n-Click/Space playfield to see controls\n-Press corresponding keys to hit notes\n-Listen and look for cues on what to hit\n-Don't miss!",-350,-50,0,1,1)
  end
  --Play screen
  if screenState=="Play" then
    if hover.button1==1 then
      love.graphics.setColor(hoverColour.r,hoverColour.g,hoverColour.b)
    end
    love.graphics.rectangle("fill",-40,200,buttonDimensions.width,buttonDimensions.height)
    love.graphics.setColor(1,1,1)
    love.graphics.print("FPS:",-535,-300,0,1.5,1.5)
    love.graphics.print(love.timer.getFPS(),-435,-300,0,1.5,1.5)
    love.graphics.setColor(0,0,0)
    love.graphics.print("Menu",-37,203,0,0.6,0.6)
    --drawing the playing area
    if players==2 then
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
    love.graphics.print("Change the options below to customise your experience\n\n\nDifficulty:Easy\n\nPlayers:",-430,-200)
    love.graphics.print(players,-300,-56)
    love.graphics.rectangle("fill",-270,-50,buttonDimensions.width,buttonDimensions.height)
    love.graphics.setColor(0,0,0)
    love.graphics.print("Change",-268,-48,0,0.7,0.7)
    love.graphics.setFont(cubic)
    love.graphics.setColor(1,1,1)
    love.graphics.draw(signature,-530,75,0,0.4,0.4)
    love.graphics.print("Version 0.2.1", -500,200,0,0.5,0.5)
    
    --buttons
    if hover.button1==1 then      
      love.graphics.setColor(hoverColour.r,hoverColour.g,hoverColour.b)
    else
      love.graphics.setColor(1,1,1)
    end
    love.graphics.rectangle("fill",500,-200,25,25)
    love.graphics.setColor(0.5,0,0)
    love.graphics.print("X",503,-206,0,0.65,0.63)
    if hover.button2==1 then
      love.graphics.setColor(hoverColour.r,hoverColour.g,hoverColour.b)
    else
      love.graphics.setColor(1,1,1)
    end
    love.graphics.rectangle("fill",-270,-50,80,20)
    love.graphics.setColor(0,0,0)
    love.graphics.setFont(beattech)
    love.graphics.print("Change",-268,-48,0,0.7,0.7)
  end
end

--setting values to be used later
pi=math.pi
angle=-pi/2
popEnabled=-1
colourA= { r = 0, g = 0, b = 0 }
colourB= { r = 1, g = 1, b = 1 }
state="unmoved"
pop=love.audio.newSource("pop.wav","static")
backgroundMusic=love.audio.newSource("bg.mp3","static")
backgroundMusic:setLooping(true)
love.audio.play(backgroundMusic)
drawMouseArrow=-1
drawWasdArrow=-1
--love.update function refreshes for every frame
function love.update(dt)
  mousePosX=love.mouse.getX()-400
  mousePosY=love.mouse.getY()-300
  leftclick=love.mouse.isDown(1)
  if leftclick and mousePosX>=-100 and mousePosX<=-20 and mousePosY>=200 and mousePosY<=220 then
    drawMouseArrow=drawMouseArrow*-1
    love.timer.sleep(0.2)
  end
  if leftclick and mousePosX>=10 and mousePosX<=90 and mousePosY>=200 and mousePosY<=220 then
    drawWasdArrow=drawWasdArrow*-1
    popEnabled=popEnabled*-1
    love.timer.sleep(0.2)
  end
  --checking for keypresses every frame, and then acting on input by changing arrow direction and colour.
    if love.keyboard.isDown("w") then
      if popEnabled==1 and state~="u" then
        love.audio.play(pop)
      end
      angle = -pi/2
      state = "u"
      colourB.r=194/255
      colourB.g=75/255
      colourB.b=153/255
    end
    if love.keyboard.isDown("d") then
      if popEnabled==1 and state~="r" then
        love.audio.play(pop)
      end
      angle = 0
      state = "r"
      colourB.r=0
      colourB.g=1
      colourB.b=1
    end
    if love.keyboard.isDown("a") then
      if popEnabled==1 and state~="l" then
        love.audio.play(pop)
      end
      angle = pi
      state = "l"
      colourB.r=18/255
      colourB.g=250/255
      colourB.b=5/255
    end
    if love.keyboard.isDown("s") then
      if popEnabled==1 and state~="d" then
        love.audio.play(pop)
      end
      angle = pi/2
      state = "d"
      colourB.r=249/255
      colourB.g=57/255
      colourB.b=63/255
    end
      if mousePosX>mousePosY and mousePosX<-mousePosY then
        mouseState = "up"
        colourA.r=194/255
        colourA.g=75/255
        colourA.b=153/255
      end
      if mousePosX>mousePosY and mousePosX>-mousePosY then
        mouseState = "right"
        colourA.r=0
        colourA.g=1
        colourA.b=1
      end
      if mousePosX<mousePosY and -mousePosX>mousePosY then
        mouseState = "left"
        colourA.r=18/255
        colourA.g=250/255
        colourA.b=5/255
      end
      if mousePosX>-mousePosY and mousePosX<mousePosY then
        mouseState = "down"
        colourA.r=249/255
        colourA.g=57/255
        colourA.b=63/255
      end
end
--love.draw function draws every frame
function love.draw()
  --setting a new origin to the center of the window
  love.graphics.translate(400,300)
  --refreshing colour for text etc
  love.graphics.setColor(1,1,1)
  --printing fps and arrow state for debug
  love.graphics.print(love.timer.getFPS(),-300,-50,0,2,2)
  love.graphics.print(state,-300,-100,0,2,2)
  --GUI
  love.graphics.rectangle("fill",10,200,80,20)
  love.graphics.rectangle("fill",-100,200,80,20)
  love.graphics.setColor(0,0,0)
  love.graphics.print("MouseArrow",-99,200)
  love.graphics.print("WasdArrow",11,200)
  --drawing the playing area
  love.graphics.setColor(18/255,250/255,5/255)
  love.graphics.arc("line",0,0,103,pi-pi/4,pi+pi/4)--left
  love.graphics.setColor(249/255,57/255,63/255)
  love.graphics.arc("line",0,0,103,pi/2-pi/4,pi/2+pi/4) --down
  love.graphics.setColor(194/255,75/255,153/255)
  love.graphics.arc("line",0,0,103,-pi/2-pi/4,-pi/2+pi/4) --up
  love.graphics.setColor(0,1,1)
  love.graphics.arc("line",0,0,103,-pi/4,pi/4) --right
  --updates the arrow's rotation
  if mousePosX>=0 then
    angleRelative=math.atan(mousePosY/mousePosX)
  else 
    angleRelative=math.atan(mousePosY/mousePosX)+pi
  end
  --checking if arrows should be drawn and then drawing
  if drawMouseArrow==1 then
    love.graphics.rotate(angleRelative)
    love.graphics.setColor(colourA.r, colourA.g, colourA.b)
    love.graphics.line(100,0,90,-10)
    love.graphics.line(100,0,90,10)
    love.graphics.line(0, 0, 100, 0)
    love.graphics.rotate(-angleRelative)
  end
  if drawWasdArrow==1 then
    popEnabled=1
    love.graphics.rotate(angle)
    love.graphics.setColor(colourB.r, colourB.g, colourB.b)
    love.graphics.line(100,0,90,-10)
    love.graphics.line(100,0,90,10)
    love.graphics.line(0, 0, 100, 0)
  end
end

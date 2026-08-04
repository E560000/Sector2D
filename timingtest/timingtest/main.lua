timing=0
pasttiming=0
bpm=60
x=0
pi=math.pi
pop=love.audio.newSource("Assets/Audio/pop.wav","static")
function love.update(dt)
	timing=timing+dt*1000
	beat=math.sin(love.timer.getTime()*2*pi*bpm/60)
end
function love.draw()
	love.graphics.setColor(1,1,1)
	love.graphics.print("Timing point:"..timing,0,0)
	love.graphics.print("FPS:"..love.timer.getFPS(),0,50)
  love.graphics.print("x:"..x,0,75)
  love.graphics.print("Beat:"..beat,0,100)
	if pasttiming ~= math.floor(timing/1000) then
		love.graphics.setBackgroundColor(0.5,0.5,love.math.random())
		pasttiming=pasttiming+1
    love.audio.play(pop)
	end
	
end
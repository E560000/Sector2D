--These are all the sound files for the game
--Easy, Medium, Hard, Settings Music made by Toby Fox
EasyGameplayAudio=love.audio.newSource("Assets/Audio/DeathByGlamour.mp3","static")
MediumGameplayAudio=love.audio.newSource("Assets/Audio/BadApple.mp3","static")
HardGameplayAudio=love.audio.newSource("Assets/Audio/BurningEyes.mp3","static")
settingsMusic=love.audio.newSource("Assets/Audio/TheDistanceBetweenTwo.mp3","static")
settingsMusic:setLooping(true)
--Background music made by Frums 
backgroundMusic=love.audio.newSource("Assets/Audio/startup.mp3","static")
backgroundMusic:setLooping(true)
--Up, Down, Left, Right, Pop made by Enis Bayram
up=love.audio.newSource("Assets/Audio/up.wav","static")
right=love.audio.newSource("Assets/Audio/right.wav","static")
down=love.audio.newSource("Assets/Audio/down.wav","static")
left=love.audio.newSource("Assets/Audio/left.wav","static")
pop=love.audio.newSource("Assets/Audio/pop.wav","static")